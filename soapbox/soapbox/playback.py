import sys,re
mainPath=sys.path[0]
sys.path.append(mainPath+'/libs')

import os,gobject
from socket import socket, AF_INET, SOCK_STREAM
from types import *
from soapbox import widgets,liquidsoap

def __init__():
  return playback()

class _IdleObject(gobject.GObject):
    def __init__(self):
        gobject.GObject.__init__(self)

    def emit(self, *args):
        gobject.idle_add(gobject.GObject.emit,self,*args)


class playback:
  daemon=None
  manager=None

  def __init__(self):
	self.daemon=daemon()
	self.manager=liquidsoap.ClientThreadManager.__init__(self.daemon.script.telnetPort,10)

  def disconnect(self):
	self.daemon.disconnect()

  def get_source(self,name):
	return self.source(self,name)


  class source(_IdleObject):
	'''
	  A source connected to the Liquidsoap client
	'''
	__gsignals__ = {
	"queue":(gobject.SIGNAL_RUN_LAST,gobject.TYPE_NONE,[
	  gobject.TYPE_PYOBJECT])
#	"enqueue_rid"
	}
	name=None
	#queue=odict.OrderedDict([])
	queue=[]

  	def __init__(self,pb,name):
	  _IdleObject.__init__(self)
	  self.name=name
	  self.pb=pb

	def start(self):
	  self.pb.manager.make_metaWatcher_thread(self.handle_metaData,self.handle_error,self.empty_queue,self.name)

	def skip(self):
	  s='mixer_'+self.name+'.skip 0'
	  self.pb.manager.make_command_thread(s)

	def debug_cb(self,*args):
	  print args

	def set_play(self,play):
	  s='mixer_'+self.name+'.select 0 '+str(play).lower()
	  self.pb.manager.make_command_thread(s)

	def enqueue(self,button):
	  s=str(self.name+'.push '+button.filename)
	  self.queue.append({'button':button,'s':s})
	  #self.pb.manager.make_command_thread(s)
	  self.pb.manager.make_response_thread(s,'(\\d+)',self.enqueue_cb)
	def enqueue_cb(self,sender,data):
	  for i in self.queue:
		if i['s']==sender.s:
		  i['button'].queue_rid=data
		  break

 	def handle_metaData(self,metaWatcher,metaData,*args):
	  data=[]	  
	  for i in metaData:
		if not i.has_key('status'):
		  status='pre'
		else:
		  status=i['status']
		if i.has_key('initial_uri'):
		  filename=i['initial_uri']
		if i.has_key('filename'):
		  filename=i['filename']
		data.append(
		  {
			'rid':i['rid'],
			'filename':filename,
			'status':status
		  }
		)
	  self.emit('queue',data)
	def handle_error(self,*args):
	  None
	def empty_queue(self,*args):
	  None

	def request_tag(self,filename,cb):
	  return self.pb.daemon.request_tag(filename,cb)


######################################################################################################
######################################################################################################

class daemon:
  '''
    Daemon to fork the Liquidsoap server
  '''
  script=None

  def __init__(self):
	self.script=script()
	self.connect()

  def connect(self):
	try:
	  self.pid=pid=os.fork()
	  if pid==0:
	    os.execlp('liquidsoap','liquidsoap',self.script.get_script())
	except:
	  exit()

  def disconnect(self):
	os.kill(self.pid,15)		
      	os.waitpid(self.pid,1)
  def request_tag(self,filename,cb):
	title=None
	(dummy, stdout_and_stderr)=os.popen4("liquidsoap -r '%s'"%filename)
	s=stdout_and_stderr.read()
	sParts=s.split('\n')
	for i in sParts:
	  j=i.split('=')
	  if len(j)>1:
		if j[0]=='title':
		  title=j[1].strip('"')
	if not title or len(title)==0:
	  filename=filename.rsplit('/')
	  filename=filename[len(filename)-1].rsplit('.')
	  filename=filename[0]
	  title=filename
	return title


######################################################################################################
######################################################################################################

class script:
  settings = {}
  sources = {}
  outputs = {}
  script = ""
  telnetPort = None

  def __init__(self):
	self.freePort=freePort=portFinder()
	self.telnetPort=port=freePort.getPort()			
			
	self.settings['telnet']=self.setting('server.telnet',True)
	self.settings['telnetPort']=self.setting('server.telnet.port',port)
	self.settings['framesize']=self.setting('frame.size',940)	

	self.sources['jingles']=self.requestMixer('jingles')
	self.sources['temp']=self.requestMixer('temp')

	self.outputs['alsa']=self.output('alsa','mksafe(mixer_jingles)','bufferize=false','alsaOut')
	self.outputs['dummy']=self.output('dummy','mksafe(mixer_temp)','','tempDummy')
	self.script=self.generate()	

  def generate(self):
	script=""	
	for i in self.settings:
	  script+=self.settings[i].get_script()+'\n'
	for i in self.sources:
	  script+=self.sources[i].get_script()+'\n'
	for i in self.outputs:
	  script+=self.outputs[i].get_script()+'\n'
	return script

  def get_script(self):
	return self.script

  def get_port(self):
	return self.telnetPort
  def get_source(self,name):
	return self.sources[name]

  ##############################
  ##Script elements
  class setting:
	field=None
	value=None

	def __init__(self,field,value):
	  self.field=field
	  self.value=value
  	def get_script(self):
	  value=self.value
	  if type(value)==StringType:
	  	value="'"+value+"'"
	  else:
	  	value=str(value)
	  if value=="True":
	  	value="true"
	  if value=="False":
	  	value="false"
	
	  return "set('"+self.field+"',"+value+")"

  class requestMixer:
	name=None

	def __init__(self,name):
	  self.name=name

	def get_name(self):
	  return self.name

	def get_script(self):
	  return self.name+"="+"request.equeue(id='"+self.name+"')"+\
	    "\nmixer_"+self.name+"=mix(id='mixer_"+self.name+"'"+",["+self.name+"])"

  class output:
	typ=None
	source=None
	args=None
	name=None
		
	def __init__(self,typ,source,args="",name=None):
	  self.typ=typ
	  self.source=source
	  self.args=args
	  self.name=name
	def get_script(self):
	  args=""
	  name=""
	  if len(self.args)>0:
		args=","+self.args
	  if len(self.name)>0:
		name=",id='"+self.name+"'"
	  return "output."+self.typ+"("+self.source+args+name+")"

class portFinder:
   	'''
  	  Find a free telnet port to start the server on
   	'''
	port = None
	socketobj = None

	def __init__(self):
		i=2000
		portStatus=0
		while portStatus!=111:
			sockobj = socket(AF_INET, SOCK_STREAM)
	   		portStatus=sockobj.connect_ex(('localhost',i))
			if portStatus!=111:
				i+=1
				sockobj.close()
		self.port=i
			
	def getPort(self):
		return self.port
		
