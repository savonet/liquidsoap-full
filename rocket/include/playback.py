#!/usr/bin/python
#*****************************************************************************
#
#  Liquidsoap, a programmable audio stream generator.
#  Copyright 2003-2007 Savonet team
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details, fully stated in the COPYING
#  file at the root of the liquidsoap distribution.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
#*****************************************************************************

from client import LiqClient
import re
import gobject
import socket
from datetime import datetime
import time,threading

class playback:
	source=None
	daemon=None
	metaWatcher=None
	client=None

	queue=[]

	def __init__(self,daemon,name):
		self.daemon=daemon
		self.source=source=daemon.get_source(name)
		self.metaWatcher=metaWatcher(source.get_name(),daemon.get_port())

	def get_metaWatcher(self):
		metaWatcher=self.metaWatcher
		if not metaWatcher.get_running():
			metaWatcher.set_running(True)
		if not metaWatcher.get_running():
			return False
		else:
			while not metaWatcher.isActive():
				time.sleep(1)

			return metaWatcher

	def enqueue(self,uri):
		metaWatcher=self.get_metaWatcher()
		if not metaWatcher:
			return False

		client=self.get_client()
		date=datetime.now()
		rid=client.command(str(self.source.get_name()+".push "+uri))
		self.queue.append({'uri':uri,'date':date,'rid':rid})

	def get_client(self):
		if not self.client:
			self.client=LiqClient("localhost",self.daemon.get_port())

		self.client.command("mixer_"+self.source.get_name()+".select 0 true")
		return self.client
		
	class metaWatcherGet(threading.thread):
		def run(self):
			None	
		
		
#	def __init__(self):
#		self.mW=None
#		self.talker=None
#		self.metadata=None
#		
#	def enqueue(self,uri):
#		self.try_connection()
#		self.try_talk()
#		#self.tel=LiqClient("localhost",'1234')
#		
#		#self.tel.command("mixer.volume 60")		
#		self.talker.command(str("jinglesKUBE.push "+uri))
#		#time = gobject.timeout_add(550,self.active,uri)
#		#t = Timer()
#		#t.connect("tick",self.print_something)
#		#t.set_property('running',True)
#
#	def accept_metadata(self,arg,metadata):			
#		if self.metadata!=None :
#			self.compare_metadata(self.metadata,metadata)
#		self.metadata = metadata
#
#	def compare_metadata(self,current,new):
#		print "compare"
#		None
#		#print "NEW COMPARE"
#		#print current
#		#
#		#for i in current:
#		#	print i
#
#	def try_connection(self):
#		if self.mW==None:
#			mW = metaWatcher("jinglesKUBE")
#			mW.set_running(True)
#			mW.connect("metadata",self.accept_metadata)
#
#	def try_talk(self):
#		if self.talker==None:
#			self.talker = LiqClient("localhost",'1234')
#			self.talker.command("mixer_jinglesKUBE.select 0 true")
#
#	
#
#	def active(self,track):
#		None	
#	#	current=self.get_current()
#	#			
#	#	if current==track:
#	#		print "track"
#	#		
#	#	else:
#	#		print "not the track"
#	#	return True
#		
#	def stop_current(self,track):
#		None	
#	#	metadata = self.get_metadata()
#	#	current = metadata[0]
#	#	if current['initial_uri']==track:
#	#		self.tel.command("mixer.skip 0")
#	#	else:
#	#		current_id=current['rid']
#	#		for i in metadata:
#	#			if i['initial_uri']==track:
#	#				if i['rid']>current_id+2:
#	#					self.tel.command("jingles.remove "+str(i['rid']))
#	#				else:
#	#					print "TOO LOW TO REMOVE"		
#
#	#def get_metadata(self):
#	#	a = filter(lambda x: x!='',
#	#	re.compile('(\d+)\s*').split(self.tel.command("jingles.queue")))
#	#	a = [ self.tel.metadata('metadata '+e)[0] for e in a ]
#	#	return a
#
#	def get_current(self):
#		None	
#	#	metadata = self.get_metadata()
#	#	return metadata[0]['initial_uri']
#
#	def close(self):
#		self.mW.set_running(False)

class metaWatcher(gobject.GObject):
    __gsignals__ = {
        'tick' : (gobject.SIGNAL_RUN_FIRST, gobject.TYPE_NONE,
                      ()),
	'metadata' : (gobject.SIGNAL_RUN_FIRST, gobject.TYPE_NONE,
                      (gobject.TYPE_PYOBJECT,))
    }
    __gproperties__ = {
        'running' :  (gobject.TYPE_BOOLEAN,
                      'running property',
                      'indicates if the timer has started',
                      0,
                      gobject.PARAM_READWRITE)
        }
    def __init__(self, device, port,interval=1000):
        self.__gobject_init__()
        self.__interval=interval
        self.__afterid=None
        self.running=0
	self.device=device
	self.port=port
	self.metadata=None
	self.tel=None

    def do_set_property(self,pspec,value=None):	
        if pspec.name=='running':
            self.running=value
            if value:
                self.__start()
            else:
                self.__stop()
        else:
            raise AttributeError, 'unknown property %s' % pspec.name

    def do_get_property(self,pspec):
	
        if pspec.name=='running':
            return self.running
        else:
            raise AttributeError, 'unknown property %s' % pspec.name

    def set_running(self,setRunning):
	alreadyRunning=self.get_running()

	try:
		if not alreadyRunning and setRunning:
			self.tel=LiqClient("localhost",self.port)
			self.__start()
		elif alreadyRunning and not setRunning:
			self.tel.close()
	        self.set_property('running',setRunning)
	except socket.error:
		print "socket error"
		return False

    def get_running(self):
        return self.get_property('running')


    def __start(self):
        if self.__afterid==None:
            self.__afterid=gobject.timeout_add(self.__interval,
                                       self.__commandwrapper)

    def __stop(self):
        if self.__afterid!=None:
            gobject.source_remove(self.__afterid)
            self.__afterid=None
    def isActive(self):
	print "isActive?"
	print self.metadata
	if self.metadata:
		return True
	return False

    def __commandwrapper(self):	
	a = filter(lambda x: x!='',
		re.compile('(\d+)\s*').split(self.tel.command(self.device+".queue")))
	a = [ self.tel.metadata('metadata '+e)[0] for e in a ]
	if self.metadata==None:
		self.metadata=a
	else:
		self.handle_data(a)
		self.metadata=a
	
        #self.emit("metadata",a)
	
        return True

    def check_order(self,metadata):
	counter=0
	for i in self.metadata:
		if i['initial_uri']!=metadata[counter]['initial_uri']:
			return False
		counter+=1
	return True

    def handle_data(self,metadata):
	print "Handling data"
	metaDiff = len(self.metadata)-len(metadata)

	## Check if the queue is empty
	if metaDiff==0: #Maybe nothing, but there could be some changes
		if len(metadata)==0: #Nothing is in the queue
			queue_empty = True
		else: #Check that the contents are the same
			queue_empty = self.check_order(metadata)
	elif metaDiff>1 or metaDiff<1: #Queue has increased/decreased		
		queue_empty = False

	#if not queue_empty:
	#	for i in self.metadata:
	#		None

	#if not queue_empty:
	#	counterI = 0
	#	for i in self.metadata:
	#		counterJ = 0
	#		for j in metadata:
	#			if i['rid']==j['rid']:
	#				if counterI==counterJ:
	#					None
	#				else:
	#					None
	#			
	#			counterJ+=1
	#		counter+=1
