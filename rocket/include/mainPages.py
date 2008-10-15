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

import gtk
import random
from scrollList import scrollList
import sys
sys.path.append("libs")
from odict import *
from db import db
import gobject

class jinglePage(gtk.Frame):
	def __init__(self,db,playback):

		#Setup the main frame
		gtk.Frame.__init__(self)
		self.set_border_width(10)
		self.set_size_request(100, 75)
		self.show()

		#Create our jingle board selection notebook
		jingleNotebook = gtk.Notebook()
		jingleNotebook.set_tab_pos(gtk.POS_BOTTOM)
		jingleNotebook.show()

		#Get the jingle tables from the db
		dbTempData = db.select("soundBoards","board_id,name")
		for result in dbTempData:
			jingleData = db.select("boardItems INNER JOIN files ON boardItems.file_id = files.file_id","soundBoard_id,files.file_id,bgColour,files.filename,files.name,files.path"
			,"soundBoard_id= (select board_id from soundBoards where name ='"+result['name']+"')")

			jingleMain = gtk.Frame()
			jingleMain.add(jingleTable(jingleData,playback))
			jingleMain.show()	
			jingleNotebook.append_page(jingleMain,gtk.Label(result['name']))
		

		self.add(jingleNotebook)

####################################################################################################
####################################################################################################

class jingleTable(gtk.Table):
	def __init__(self,jingleData,playback):
		gtk.Table.__init__(self,3,3,True)
		self.show()
		self.playback = playback
		
		self.jingleData = jingleData

		def on_button_clicked(self,parent):
			uri = self.data['path']+"/"+self.data['filename']
			playback.enqueue(uri)
			
			
		totalNum=len(jingleData)
		i=0
		for jingle in jingleData:		
			
			#label = gtk.Label( jingle['name'] )
			#label.set_justify( gtk.JUSTIFY_CENTER )	
			#label.set_line_wrap(True)
			button = jingleButton( jingle, self )
			#button.modify_bg(gtk.STATE_NORMAL,gtk.gdk.color_parse(jingle['bgColour']))
			#button.data = jingle
			#button.connect("clicked",on_button_clicked,self)
			self.attach(button,i%3,(i%3)+1,i//3,(i//3)+1)
			
			i+=1
		#self.attach(jingleButton())
		self.show_all()

class jingleButton(gtk.ToggleButton):
	def __init__(self,data,parent):
		gtk.Button.__init__(self,data['name'])
		self.highlight=False
		self.playback=parent.playback
		self.data=data
		self.colour=gtk.gdk.color_parse(data['bgColour'])
		self.modify_bg(gtk.STATE_NORMAL,self.colour)
		
		self.connect("toggled",self.on_clicked)

	def on_clicked(self,data):
		uri = self.data['path']+"/"+self.data['filename']
		if self.get_active():
			time = gobject.timeout_add(250,self.blinking)			
			self.playback.enqueue(uri)
			
			#self.playback.get_current()
		else:
			self.playback.stop_current(uri)
			self.modify_bg(gtk.STATE_ACTIVE,self.colour)
		
		
	def blinking(self):
		if self.get_active():
			if self.highlight:
				self.modify_bg(gtk.STATE_ACTIVE,self.colour)
				self.highlight=False
			else:
				self.modify_bg(gtk.STATE_ACTIVE,gtk.gdk.Color(00000,50000,00000,self.colour.pixel))
				self.highlight=True
			return True
		else:
			return False
		
####################################################################################################
####################################################################################################

class statusPage(gtk.Frame):

  

    def __init__(self,playback):
	gtk.Frame.__init__(self)
	self.set_border_width(10)
	self.set_size_request(100, 75)
	self.show()
	streams = gtk.VBox()
	streams.show()
	self.add(streams)

	connections = daemon.get_connections()
	for i in connections:
		if connections[i].is_connected()==True :
			connected = 1
		else:
			connected = 0
		streams.add(self.stream(i,connected,0,""))


   
	
	

    class stream(gtk.Frame):

	padlockImage = gtk.Image()

	def setup_images(self):
		padlockImage = gtk.Image()
		padlockImage.set_from_file("graphics/padlockButton-Trans60x40.png")
		self.padlockImage = padlockImage

	def __init__(self,stream,status,access,message):
		gtk.Frame.__init__(self)

		self.setup_images()

		mainSplit = gtk.VBox()
		mainSplit.show()
		
		topLayout = gtk.Layout()
		topLayout.show()
		bottomLayout = gtk.Layout()
		bottomLayout.show()
		if access == 1:
			buttonStatus = gtk.ToggleButton(stream)
		else:
			buttonStatus = gtk.Button(stream)
			#buttonStatus.set_sensitive(False)
			buttonStatus.set_image(self.padlockImage)

		buttonStatus.set_size_request(200,50)
		
				
		if status == 1:
			buttonStatus.modify_bg(gtk.STATE_NORMAL,gtk.gdk.Color(red=7700,green=55000,blue=7700))
		elif status == 2:
			buttonStatus.modify_bg(gtk.STATE_NORMAL,gtk.gdk.Color(red=55000,green=40000,blue=7700))
		else:
			buttonStatus.modify_bg(gtk.STATE_NORMAL,gtk.gdk.Color(red=55000,green=7700,blue=7700))
		buttonStatus.show()
		
			
	
		
		topLayout.add(buttonStatus)
	
		message = gtk.Label(message)
		message.show()
		bottomLayout.add(message)

		mainSplit.add(topLayout)	
		mainSplit.add(bottomLayout)	
		self.add(mainSplit)	
		self.show()

####################################################################################################
####################################################################################################

class mixerPage(gtk.Frame): 
#The main tabbed index
  
    def __init__(self):
	gtk.Frame.__init__(self)

	
	self.setup_containers()

	self.show()	

    def setup_containers(self):
	mixerHBox = gtk.HBox(False,2)
	mixerHBox.pack_start(self.channel(),0)
	mixerHBox.pack_end(self.channel(),0)
	mixerHBox.show()
	self.add(mixerHBox)

    class channel(gtk.VBox):
	playStateImage = gtk.Image()
    	cueImage = gtk.Image() 
    	playStateButton = gtk.ToggleButton()
    	cueButton = gtk.ToggleButton()


	def __init__(self):
		gtk.VBox.__init__(self)
		self.set_size_request(250,600)
		self.setup_images()
		self.mixerVBox = gtk.VBox(False,3)

		topBox = gtk.HPaned()
		topBox.show()

		gtk.rc_parse_string('''
       		 style "mystyle" {
                bg[NORMAL] = "#00FF00"
        	}
        	widget "*.mybutton" style "mystyle"''')
		
	

		statusBox = gtk.Button()
		statusBox.show()
		statusBox.modify_bg(gtk.STATE_NORMAL,gtk.gdk.Color(red=7700,green=40000,blue=7700))
		statusBox.set_border_width(2)
	
		statusBox.set_size_request(120,80)
		status = gtk.Label("1:30:05\n||||||\nShape Shifters")
		status.set_state(gtk.STATE_NORMAL)
		status.set_justify(gtk.JUSTIFY_LEFT)		
		status.show()

		

		statusBox.add(status)

		topBox.set_size_request(50,150)
		topBox.add(statusBox)
		topBox.set_border_width(20)
		topBox.add(self.get_vScale())

		mainButtons = gtk.HButtonBox()
		mainButtons.set_size_request(100,100)	
		mainButtons.pack_start(self.get_cueButton(),0)
		mainButtons.pack_start(self.get_playStateButton(),0)	
		mainButtons.set_spacing(10)
		mainButtons.show()
		
		self.pack_start(topBox,0)
		self.pack_start(mainButtons,0)
		#self.pack_start(self.get_vScale(),0)
		self.show()

	def setup_images(self):
		cueFirstImage = gtk.Image();
		playStateFirstImage = gtk.Image();
		cueFirstImage.set_from_file("graphics/cueButton-Trans60x40.png");
		playStateFirstImage.set_from_file("graphics/playPauseButton-Trans60x40.png")
		self.cueImage = cueFirstImage
		self.playStateImage = playStateFirstImage;


	def get_playStateButton(self):	
		playStateButton = gtk.ToggleButton()		
		playStateButton.set_size_request(75,50)	
		playStateButton.modify_bg(gtk.STATE_NORMAL,gtk.gdk.Color(red=7700,green=40000,blue=7700));
		playStateButton.modify_bg(gtk.STATE_PRELIGHT,gtk.gdk.Color(red=7700,green=55000,blue=7700));
		playStateButton.modify_bg(gtk.STATE_ACTIVE,gtk.gdk.Color(red=7700,green=55000,blue=7700));
		playStateButton.set_image(self.playStateImage)
		playStateButton.show()
		return playStateButton

	def get_cueButton(self):
		cueButton = gtk.ToggleButton()
		cueButton.set_size_request(75,60)	
		cueButton.modify_bg(gtk.STATE_NORMAL,gtk.gdk.Color(red=40000,green=7700,blue=7700));
		cueButton.modify_bg(gtk.STATE_PRELIGHT,gtk.gdk.Color(red=55000,green=7700,blue=7700));
		cueButton.modify_bg(gtk.STATE_ACTIVE,gtk.gdk.Color(red=55000,green=7700,blue=7700));
		cueButton.set_image(self.cueImage)
		cueButton.show()
		return cueButton

	def get_vScale(self):
	
		scale = gtk.VScale()
		scale.set_size_request(0,200)
		scale.set_inverted(True)
		scale.show()
		return scale
 
####################################################################################################
####################################################################################################

class messagesPage(gtk.Frame):

	def __init__(self):
		gtk.Frame.__init__(self)		
		self.show_all()

		playList = scrollList( OrderedDict([
					('name',{
						'label':'Name'
					}),
					('source',{
						'label':'Source'
					}),
					('message',{
						'label':'Message'
					})
				]))
		self.add(playList)
		#messagesDB = db('messages.db')	
		#messagesDB.cursor.execute("SELECT * FROM sqlite_master")
		#messagesDB.select("messages")


class webcamPage(gtk.Frame):
	def __init__(self):
		gtk.Frame.__init__(self)
		self.show_all()
		
####################################################################################################
####################################################################################################

class playlistPage(gtk.Frame): 
#The main tabbed index

    ui = '''<ui>
	<toolbar name="options">
		<toolitem action="keyboard"/>
	</toolbar>
    </ui>'''
  
    def __init__(self):
	gtk.Frame.__init__(self)
	#Menubar as created by a uimanager
	uimanager = gtk.UIManager()
	uimanager.add_ui_from_string(self.ui)	
	
	actiongroup = gtk.ActionGroup("sub")
        actiongroup = actiongroup
	uimanager.insert_action_group(actiongroup, 0)

        # Create actions
        actiongroup.add_actions([('keyboard', None, '_Keyboard', None,
                                  'Keyboard', self.update_keyboard)
				])
	
     	menubar = uimanager.get_widget('/options')
	toolbar = menubar.get_children()	
	
	self.show()	
	vBox = gtk.VBox(3,False)
	vBox.set_homogeneous(False)
	vBox.show()
	self.add(vBox)

	mainHBox = gtk.HBox(2,False)
	mainHBox.show()	
	
	local = gtk.VBox(2,False)
	local.set_homogeneous(False)
	local.show()
	location = gtk.Label("Location: music/")
	
	location.show()
	local.pack_start(location)
	fileList = scrollList( OrderedDict([
					('name',{
						'label':'Name'
					}),
					('lastMod',{
						'label':'Last Modified'
					}) 
				]))
	local.pack_end(fileList)

	dest = gtk.VBox(2,False)
	dest.show()
	playList = scrollList( OrderedDict([
					('name',{
						'label':'Name'
					}),
					('plays',{
						'label':'Plays'
					}) 
				]))
	dest.pack_end(playList)	
	
	mainHBox.pack_start(local,0)
	mainHBox.pack_end(dest,0)
	
	vBox.pack_start(mainHBox)
	vBox.pack_end(menubar,1)

	keyboard = gtk.Table(3,8)
	keyboard.show()
	total=0;
	for i in range(4):
		for j in range(8):
			if i<3 or i==3 and j<2:
				button = gtk.Button("%c" % chr(total+97))
				button.set_size_request(25,25)
				button.show()
				keyboard.attach(button,j,j+1,i,i+1)
				total+=1
			else:
				break

	button = gtk.Button("Space")
	button.show()
	keyboard.attach(button,2,5,3,4)

	self.keyboard = keyboard
			


    def update_keyboard(self,widget,data=None):
	vBox=self.get_child()
	children = vBox.get_children()
	if self.keyboard in children:
		vBox.remove(self.keyboard)
	else:
		vBox.pack_start(self.keyboard,0)

