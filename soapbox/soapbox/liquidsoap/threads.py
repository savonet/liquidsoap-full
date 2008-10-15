#!/usr/bin/python
############################
# Using pygtk threads safely, this was built on the example
# from John Stowers, if you need any help understanding the 
# threading concepts, please visit his blog at http://www.johnstowers.co.nz
# first and run the example there.
#
#
############################


import gobject,threading,time,random,re
from telnetlib import Telnet
import socket #Needed for exception
gobject.threads_init()


class _IdleObject(gobject.GObject):
    def __init__(self):
        gobject.GObject.__init__(self)

    def emit(self, *args):
        gobject.idle_add(gobject.GObject.emit,self,*args)

class _telnetThread(threading.Thread, _IdleObject):
    ##############
    # Create communication with liq
    ##############
    __gsignals__ = {
	"connectionError":(gobject.SIGNAL_RUN_LAST, gobject.TYPE_NONE, [
          gobject.TYPE_STRING]),
	"completed": (
                gobject.SIGNAL_RUN_LAST, gobject.TYPE_NONE, [])

	}
    def __init__(self,port):
    	threading.Thread.__init__(self)
        _IdleObject.__init__(self)
	
	self.cancelled=False
	try:
		self.tel=Telnet('localhost',port)
	except socket.error:
		self.cancel()
		self.emit("connectionError","Could not connect")


    def command(self,s):
	try:
		tel=self.tel
		tel.write("%s\n" % s)
		ans=tel.read_until("END")
		ans=re.sub("\nEND$","",ans)
	    	ans=re.sub("^\n","",ans)
		return ans
	except socket.error:
		self.emit("connectionError","Lost connection.")
		self.cancel()
		return False

    def cancel(self):
	self.cancelled=True
#################################################################################################################

class _watcherThread(_telnetThread):
    watchers={}
    watchersLock=threading.Lock()


    def __init__(self,port):
	_telnetThread.__init__(self,port)

    def register_watcher(self,watcher,source,arg):
	self.watchersLock.acquire()	

	if source not in self.watchers:
	    self.watchers[source]={}
	self.watchers[source][arg]=watcher

	self.watchersLock.release()

    def delete_watcher(self,source,arg):
	self.watchersLock.acquire()

	del self.watchers[source][arg]
	if len(self.watchers[source])==0:
	    del self.watchers[source]

	self.watchersLock.release()

    def run(self):
	while not self.cancelled:
	    time.sleep(0.1)
	    self.watchersLock.acquire()
	    for source in self.watchers:
		for name in self.watchers[source]:
			watcher=self.watchers[source][name]
			watcher.run(self)
	    self.watchersLock.release()

    def read(self,s):
	return self.command(s)

    def stop_watchers(self):
	self.watchersLock.acquire()
	for source in self.watchers:
		for name in self.watchers[source]:
			watcher=self.watchers[source][name]
			watcher.stop()
	self.watchersLock.release()

#################################################################################################################

class _metaWatcher(_IdleObject):
    __gsignals__ = {
	"emptyQueue":  (gobject.SIGNAL_RUN_LAST, gobject.TYPE_NONE, []),
	"status": (
          gobject.SIGNAL_RUN_LAST, gobject.TYPE_NONE, [
          gobject.TYPE_PYOBJECT]),
	"stopped": (
                gobject.SIGNAL_RUN_LAST, gobject.TYPE_NONE, [])
    }
    metaData={}

    def __init__(self,source):
	_IdleObject.__init__(self)
	self.source=source

    def encode_metadata(self,s):
	def dohash(a):
	  h={}
	  for i in range(len(a)/2):
	    a[2*i+1] = re.sub('^"','',re.sub('"$','',a[2*i+1]))
	    if a[2*i] in ('2nd_queue_pos','rid','source_id'):
              h[a[2*i]]=int(a[2*i+1])
            else:
              if a[2*i] in ('skip'):
                if a[2*i+1]=='true':
                  h[a[2*i]]=True
              	else:
                  h[a[2*i]]=False
              else:
            	h[a[2*i]]=unicode(a[2*i+1],'latin1')
	  return h

        def noblank(a):
	    return filter(lambda x: x!='',a)
	
        return [ dohash(noblank(re.compile('(.+)=(".*")\n').split(e))) for e in
             noblank(re.compile('--- \d+ ---\n').split(s)) ]
 
    def getRid(self,w):

	i=0    
	while not (w.read('metadata '+str(i)) == "No such request."):
		if w.cancelled:#!Important, prevents deadlock
			break
      		i=i+1
	return i
 
    def run(self,watcher):
	i=0
	total=self.getRid(watcher)
	if total==0:
	    self.emit("emptyQueue")  
	while i<total:
	    if watcher.cancelled:#!Important, prevents deadlock
		break
	    ans=watcher.read("metadata %s" %i)
	    if ans == False:
		break
	    metaData=self.encode_metadata(ans)
	    i=i+1
	    if not self.metaData.has_key(i) or metaData!=self.metaData[i]:
	    	self.emit("status",metaData)
	  	self.metaData[i]=metaData

    def stop(self):
	self.emit("stopped")

#################################################################################################################

class _commandWatcher(_IdleObject):
    __gsignals__ = {
	"answer": (
          gobject.SIGNAL_RUN_LAST, gobject.TYPE_NONE, [
          gobject.TYPE_STRING]),
	"stopped": (
                gobject.SIGNAL_RUN_LAST, gobject.TYPE_NONE, [])
    }  

    def __init__(self,s,re=None):
	_IdleObject.__init__(self)
	self.s=s
	self.re=re
	self.ans=""

    def run(self,w):
	if w.cancelled:
		return


	

	ans=w.read(self.s)
	if self.re and ans:
		rg=re.compile(self.re,re.IGNORECASE|re.DOTALL)
		m = rg.search(ans)
		if not m:
			return
		ans=m.group(1)
		
	if not self.ans == ans:
		self.ans=ans
		self.emit("answer",ans)

    def stop(self):
	self.emit("stopped")

#################################################################################################################

class _commandThread(_telnetThread):
    ##############
    # Thread to simply send a command with no callback 
    ##############

    def __init__(self,port,s):
    	_telnetThread.__init__(self,port)
	self.s=s
	
    def run(self):
	if not self.cancelled:
		self.command(self.s)
	self.emit('completed')


#################################################################################################################

class _responseThread(_telnetThread):
    __gsignals__ = {
	"answer": (
          gobject.SIGNAL_RUN_LAST, gobject.TYPE_NONE, [
          gobject.TYPE_STRING])
	}

    def __init__(self,port,s,re=''):
    	_telnetThread.__init__(self,port)
	self.s=s
	self.re=re

    def run(self):
	if not self.cancelled:
		ans=self.command(self.s)
		if len(ans)>0:
			rg=re.compile(self.re,re.IGNORECASE|re.DOTALL)
			m = rg.search(ans)
			if not m:
				return
			ans=m.group(1)

		self.emit("answer",ans)
		self.emit('completed')

class _debug_responseThread(_telnetThread):
    __gsignals__ = {
	"answer": (
          gobject.SIGNAL_RUN_LAST, gobject.TYPE_NONE, [
          gobject.TYPE_STRING])
	}

    def __init__(self,port,s,re=''):
    	_telnetThread.__init__(self,port)
	self.s=s
	self.re=re

    def run(self):
	if not self.cancelled:
		ans=self.command(self.s)
		

		self.emit("answer",ans)
		self.emit('completed')

#################################################################################################################

class _countdownThread(threading.Thread, _IdleObject):
    __gsignals__ = {
	"status": (
          gobject.SIGNAL_RUN_LAST, gobject.TYPE_NONE, [
          gobject.TYPE_STRING]),
	"completed": (
                gobject.SIGNAL_RUN_LAST, gobject.TYPE_NONE, []),
	"warning": (
                gobject.SIGNAL_RUN_LAST, gobject.TYPE_NONE, [])
	
	}
    def __init__(self,time,warningTime=20.):
    	threading.Thread.__init__(self)
        _IdleObject.__init__(self)
	self.cancelled=False
	self.time=float(time)
	self.warningTime=float(warningTime)

    def cancel(self):
	self.cancelled=True

    def run(self):
	while not self.cancelled:
		if self.time<=0:
			break
		time.sleep(0.1)
		self.time-=0.1
		t=self.time

		if t<self.warningTime:
			self.emit('warning')

		if t>60:
			mins = int(t/60)
			rsecs = t % 60
			t="%.2f" % (mins + rsecs / 100.0)
		else:
			t="%.0f" %t
		if t>0:
			self.emit('status',t)
	
	self.emit('completed')

  
