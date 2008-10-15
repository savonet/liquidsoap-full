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
################################
## Create liquidsoap processes
################################

import os, threading,socket
from socket import socket, AF_INET, SOCK_STREAM
from types import *


class daemon:
	telnetPort = None
	scriptObj = None
	
	def __init__(self):
		self.files={}

	def load(self):
		self.scriptObj=scriptObj=self.script()
		pid = os.fork()
		if pid==0:			
			
			print scriptObj.get_script()
			self.telnetPort=scriptObj.get_port()
			os.execlp('liquidsoap','liquidsoap',scriptObj.get_script())
		else:
    			print "Running liquidsoap..."
			self.pid=pid

	def get_port(self):
		return self.scriptObj.get_port()

	def close(self):
		if self.pid!=None:
      			os.kill(self.pid,15)		
      			os.waitpid(self.pid,1)
	def get_source(self,name):
		return self.scriptObj.get_source(name)

##############################
##############################
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

			self.outputs['alsa']=self.output('alsa','mksafe(mixer_jingles)','bufferize=false','alsaOut')

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
	def free(self):
		self.portHolderObj.close()

	class portHolder(threading.Thread):#Incomplete
		socketObj=None

		def __init__(self,port):
			self.port=port	
			self.run()

		def run(self):
			socketObj=socket(AF_INET, SOCK_STREAM)
			socketObj.bind(('localhost',self.port))
			self.socketObj=socketObj
			
			socketObj.listen(1)
			conn,addr = socketObj.accept()
		def close(self):
			self.socketObj.close()
		
