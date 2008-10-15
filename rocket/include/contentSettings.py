#!/usr/bin/env python

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
import pygtk
pygtk.require('2.0')
import gtk

from scrollList import scrollList
from settingsForm import *
import random

class contentSettings(gtk.Dialog):
	    ui = '''<ui>
		<toolbar name="main">
			<toolitem action="Accept"/>
			<separator/>   
			<toolitem action="Discard"/>
			<separator/>   
			<toolitem action="Apply"/>
		</toolbar>
		</ui>''' 

	    def __init__(self,db):
		gtk.Dialog.__init__(self,"Content Settings")
		self.set_skip_taskbar_hint(True)
		self.db=db

		########
		# Content
		########
		notebook = gtk.Notebook()
		#notebook.append_page(streamSettings(db),gtk.Label("Streams"))
		notebook.append_page(jingleSettings(self),gtk.Label("Sound Boards"))
		
		########
		# UI Manager
		########
		uimanager = gtk.UIManager()
		uimanager.add_ui_from_string(self.ui)		
		actiongroup =  gtk.ActionGroup("Settings")	
		uimanager.insert_action_group(actiongroup, 0)
		actiongroup.add_actions([
					('Accept',gtk.STOCK_OK,'_Accept',None,
					'Accept changes',lambda x:self.destroy()),
					('Discard',gtk.STOCK_CANCEL,'_Discard',None,
					'Discard changes',lambda x:self.destroy()),
					('Apply',gtk.STOCK_APPLY,'_Apply',None,
					'Apply changes',None),
					('Ok', None, '_ok', None,
	                               'Nothing', lambda x:self.destroy())					
					])	
		
		########
		# Layout
		########
		self.vbox.pack_start(notebook,0)
		mainButtons = uimanager.get_widget("/main")	
		mainButtons.set_style(gtk.TOOLBAR_BOTH)	
		self.vbox.pack_end(mainButtons)
		self.set_size_request(600,420)
		self.show_all()


	################################################################################


class jingleTable(gtk.Table):
	def __init__(self):
		gtk.Table.__init__(self,5,5,True)
		self.show()

		jinTotal = 1
		for i in range(5):
			for j in range(5):
				button = gtk.Button("Jingle %d" % (jinTotal))  
				num1 = random.randrange(5000,65000)
				num2 = random.randrange(5000,65000)
				num3 = random.randrange(5000,65000)
	
				button.modify_bg(gtk.STATE_NORMAL,gtk.gdk.Color(num1,num2,num3,0));
				button.show()
				self.attach(button, j, j+1, i, i+1)
				jinTotal+=1	


class jingleSettings(gtk.Frame):
	ui = '''<ui>
		<toolbar name="JinglesMenu">
     			<toolitem action="boardNew"/>  
			<separator/>      	
      			<toolitem action="boardEdit"/>	
			<separator/>	
			<toolitem action="boardAccess"/>
			<separator/>	
			<toolitem action="boardDel"/>		
    		</toolbar>
		</ui>'''

	def updateList(self):
		data = self.db.select("soundBoards","name")
		for i in data:	
			if not self.sl.search(i['name']):
				self.sl.append_row( [i['name'],""])

	def __init__(self,parent):
		gtk.Frame.__init__(self)
		self.db = parent.db
		########
		# Content
		########
		sl = scrollList( OrderedDict([
					('name',{
						'label':'Name',
						'value':''
						}),
					('owner',{
						'label':'Owner',
						'value':''
						})
				    ])) 
		self.sl = sl
		self.updateList()
		
	

		class editSoundBoard(gtk.Dialog):

			def alterTable(self,data):
				button = self.soundButton(data)
				
				self.table.remove(self.addNew)
				totalNum=len(self.table.get_children())				
			
				totalCols=totalNum%5
				totalRows=totalNum//5
				self.table.attach(button,totalCols,totalCols+1,totalRows,totalRows+1)
				totalCols=(totalNum+1)%5
				totalRows=(totalNum+1)//5
				self.table.attach(self.addNew,totalCols,totalCols+1,totalRows,totalRows+1)
				if data['path']!=None:
					self.workingDir=data['path']
				
				totalNum=len(self.table.get_children())
				self.validate_ok(self.nameField)

			### Sound Buttons, to be attached to sound table ##
			class soundButton(gtk.Button):
				def __init__(self,data):
					gtk.Button.__init__(self,data['label'])
					self.data=data
					self.show()
					self.modify_bg(gtk.STATE_NORMAL,data['bgColour'])
					self.modify_text(gtk.STATE_NORMAL,data['fgColour'])
				def get_path(self):
					return self.data['path']
				def get_filename(self):
					return self.data['filename']
				def get_bg(self):
					return self.data['bgColour'].to_string()

			###################################################

			def validate_ok(self, data):
				if data.get_text()=="" or len(self.table.get_children())<2:
					self.set_response_sensitive(gtk.RESPONSE_OK, False)
				else:
					self.set_response_sensitive(gtk.RESPONSE_OK, True)		

			def __init__(self,parent):
				gtk.Dialog.__init__(self,"Edit sound board")
				self.db=parent.db
				self.set_size_request(500,400)
				self.show_all()
				self.set_skip_taskbar_hint(True)

				vBox = self.get_child()				
				vBox.show_all()
				hBox = gtk.HBox(False)
				hBox.add(gtk.Label("Name"))
				nameField=gtk.Entry(10)
				nameField.connect("changed",self.validate_ok)
				self.nameField = nameField
				hBox.add(nameField)
				hBox.show_all()


				table = gtk.Table(5,5,True)

				
				class editItem(gtk.Dialog):

					def on_file_activated(self, chooser=None):
						fileName=chooser.get_preview_filename()
						if fileName == None:
							self.nameEntry.set_sensitive(False)
							self.nameEntry.set_text("Select a file first")
						else:	
							self.nameEntry.set_sensitive(True)
							shortName = fileName.rsplit('/')
							self.filename=shortName[len(shortName)-1]
							shortName = shortName[len(shortName)-1].split(".")[0]
							self.nameEntry.set_text(shortName)
							self.shortName=shortName
							
							self.set_response_sensitive(gtk.RESPONSE_APPLY, True)

					def on_name_change(self, data):
						if data.get_text()=="":
							self.set_response_sensitive(gtk.RESPONSE_APPLY, False)
						else:
							self.set_response_sensitive(gtk.RESPONSE_APPLY, True)
				
					def __init__(self,widget,parent=None):
						gtk.Dialog.__init__(self,"Add new item")
						self.show_all()
						self.set_size_request(300,200)
						self.set_skip_taskbar_hint(True)
						vBox = self.get_child()
						
						nameLine = gtk.HBox()
						nameLine.add(gtk.Label("Name"))	
						nameEntry = gtk.Entry(30)
						nameEntry.connect("changed",self.on_name_change)
						self.nameEntry = nameEntry						
						nameLine.add(nameEntry)
						
						fileLine = gtk.HBox()
						itemChooser = gtk.FileChooserButton("Select Item")
						self.itemChooser = itemChooser
						fileFilter = gtk.FileFilter()
						fileFilter.set_name("Audio MP3")
						fileFilter.add_pattern("*.mp3")
						itemChooser.add_filter(fileFilter)
					

						try:
							itemChooser.set_current_folder(parent.workingDir)
						except AttributeError: None
						itemChooser.connect("selection-changed",self.on_file_activated)
						self.on_file_activated(itemChooser)

						fileLine.add(itemChooser)

						colourLine = gtk.HBox()
						colourDescLine = gtk.HBox(True)

						num1 = random.randrange(5000,65000)
						num2 = random.randrange(5000,65000)
						num3 = random.randrange(5000,65000)
						
						self.backColourChooser = gtk.ColorButton(gtk.gdk.Color(num1,num2,num3))					
						self.foreColourChooser = gtk.ColorButton(gtk.gdk.color_parse('white'))
					
						colourLine.add(self.backColourChooser)
						colourLine.add(self.foreColourChooser)

						colourDescLine.add(gtk.Label("Background colour"))
						colourDescLine.add(gtk.Label("Text colour"))					
						
						vBox.add(fileLine)
						vBox.add(nameLine)
						vBox.add(colourDescLine)
						vBox.add(colourLine)
						self.add_buttons(gtk.STOCK_CANCEL,gtk.RESPONSE_CANCEL,gtk.STOCK_APPLY,gtk.RESPONSE_APPLY)
						self.set_response_sensitive(gtk.RESPONSE_APPLY, False)
						vBox.show_all()
						response = self.run()
						if response == gtk.RESPONSE_APPLY:
							parent.alterTable({ 
								'path':self.itemChooser.get_current_folder(),
								'filename':self.filename,								
								'label':self.nameEntry.get_text(),
								'bgColour':self.backColourChooser.get_color(),
								'fgColour':self.foreColourChooser.get_color() 
							})
							
						self.destroy()
					

				addNew = gtk.Button("      + \nNew Item")
				
				addNew.connect("clicked", editItem,self)
				self.addNew = addNew

				table.attach(addNew,0,1,0,1)
				table.show_all()
				self.table = table
				vBox.add(hBox)
				vBox.add(table)
				
				self.add_buttons(gtk.STOCK_CANCEL,gtk.RESPONSE_CANCEL,gtk.STOCK_OK,gtk.RESPONSE_OK)
				self.set_response_sensitive(gtk.RESPONSE_OK, False)
				response = self.run()
				if response == gtk.RESPONSE_OK:
					data = { 'name' : self.nameField.get_text() }
					self.db.insert("soundBoards",data)
					boardID=self.db.last_insert()

					self.table.remove(self.addNew) #Remove the addNew button
					items = self.table.get_children()
					items.reverse()
					
					for i in items:
						
						data = {
							'path':i.get_path(),
							'filename':i.get_filename(),
							'name':i.get_label()
						}
						self.db.insert("files",data)
						itemID=self.db.last_insert()
						
						data = {
							'soundboard_id':boardID,
							'file_id':itemID,
							'bgColour':i.get_bg()
						}
						self.db.insert("boardItems",data)
					parent.updateList()
				self.destroy()
					
					
			

		########
		# UI Manager
		########	
		uimanager = gtk.UIManager()
		uimanager.add_ui_from_string(self.ui)		
		actiongroup =  gtk.ActionGroup("Settings")	
		actiongroup.add_actions([
			('boardNew', gtk.STOCK_NEW, '_New Board', None,
                               'Create a new jingle board', lambda x:editSoundBoard(self)),
			('boardEdit', gtk.STOCK_EDIT, '_Edit Board', None,
                               'Edit the selected jingle board', None),
			('boardAccess', gtk.STOCK_DIALOG_AUTHENTICATION,'_Board Access', None,
                               'Setup jingle board user access', None),
			('boardDel', gtk.STOCK_DELETE,'_Delete Board',None,
                               'Delete jingle board', lambda x:self.deleteRecord())
		])
		uimanager.insert_action_group(actiongroup, 0)		

		########
		# Layout
		########
		menubar = uimanager.get_widget('/JinglesMenu')
		vBox = gtk.VBox(False,2)
		vBox.show()
		vBox.pack_start(sl)
		vBox.pack_start(menubar)
		self.add(vBox)
		self.show_all()

	def deleteRecord(self):
		board_id=str(self.db.select("soundBoards","board_id","name='"+self.sl.get_current()+"'")[0]['board_id'])		
		self.db.remove("boardItems","soundBoard_id="+board_id)
		self.db.remove("soundBoards","board_id="+board_id)
		self.sl.remove_row()
	


