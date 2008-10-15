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
import gobject
import random

from odict import *
from types import *

from scrollList import scrollList
from settingsForm import *



################################################################################

class settings(gtk.Dialog):
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
		gtk.Dialog.__init__(self,"Settings")

		self.set_skip_taskbar_hint(True)

		########
		# Content
		########
		notebook = gtk.Notebook()
		notebook.append_page(gtk.Frame("This is a blank frame")	,gtk.Label("Layout"))
		notebook.append_page(globalSettings(),gtk.Label("Global"))
		notebook.append_page(streamSettings(db),gtk.Label("Streams"))
		
		
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



		
			
################################################################################

class streamSettings(settingsSection):
	def __init__(self,db):
		self.db=db

		########
		# Menu
		########		
		ui = '''<ui>	
			<toolbar name="menu">
				<toolitem action="New Stream"/>
				<separator/>
				<toolitem action="Edit Stream"/>
				<separator/>
				<toolitem action="deleteStream"/>
			</toolbar>
			</ui>'''
		actions = [('New Stream',gtk.STOCK_NEW, '_New Stream',None,
				'Create a new stream',lambda x:self.newRow()),
			('Edit Stream',gtk.STOCK_EDIT, '_Edit Stream', None,
				'Edit the selected stream',lambda x:self.editRow()),	
			('deleteStream',gtk.STOCK_DELETE, '_Delete Stream', None,
				'Delete the selected stream',lambda x:sl.remove_row())]
		########
		# settingItems
		########
		rows = {}
		listRows = {}			
		connections = db.select("streams","stream_id,host,port,name","enabled='TRUE'","name")
		for connection in connections:
			rows[connection["name"]] = OrderedDict([
					("id", connection["stream_id"]),	
					("name", connection["name"]),				
					("host", connection["host"]),
					("port", connection["port"]) 
					])
			
			listRows[connection["name"]] = {
					"id" : connection["stream_id"],
					
					"name" : connection["name"] }
		self.data = {"ui" : ui , 
			"listColumns" : OrderedDict([
					#('id',{
					#	'label':'Id'
					#	}),
					('name',{
						'label':'Name'
						})
				
				    ]), 
			"actions" : actions ,
			"columns" :  OrderedDict([
					("id",{
						"label" : "id",
						"type" : "hidden"
						
					}),
					("name",{
						 "label" : "Name",
						 "required" : True,	
						"type" : "text"					
					}),
					("host",{
						 "label" : "Host",
						 "required" : True,	
						"type" : "text"	

					}),
					("port",{
						 "label" : "Port",
						 "required" : True,	
						"type" : "text"	
					})
				]),
			"listRows" : listRows,
			"rows" : rows
		}		
	
	
		self.sSection = settingsSection.__init__(self,self.data)

	def saveData(self,inData):
		data = self.data
		
		for column in data["columns"]:
			if "required" in data["columns"][column] and data["columns"][column]["required"] and not inData.has_key(column)  and not data.has_key(column):
				return
	
		if 'id' in inData:	
			idField = inData.pop('id')
			
			self.db.update("streams",inData,"stream_id="+idField)
		else:	
			self.db.insert("streams",inData)
		
		return True
	

################################################################################




class globalSettings(gtk.Frame):
	def __init__(self):
		gtk.Frame.__init__(self)
		notebook = gtk.Notebook()
		notebook.append_page(masterServerSettings(),gtk.Label("Master server"))
		self.add(notebook)
		self.show_all()


		



class masterServerSettings(gtk.Frame):
	def __init__(self):
		gtk.Frame.__init__(self)
		
		box = gtk.Alignment(0)
		box.set_size_request(10,10)
		vBox = gtk.VButtonBox()

		hBox = gtk.HButtonBox()
		hBox.add(gtk.Label("Host"))
		hBox.add(gtk.Entry())
		vBox.add(hBox)

		hBox = gtk.HButtonBox()
		hBox.add(gtk.Label("Port"))
		hBox.add(gtk.Entry())
		vBox.add(hBox)

		hBox = gtk.HButtonBox()
		hBox.add(gtk.Label("Database"))
		hBox.add(gtk.Entry())
		vBox.add(hBox)

		hBox = gtk.HButtonBox()
		hBox.add(gtk.Label("Username"))
		hBox.add(gtk.Entry())
		vBox.add(hBox)

		hBox = gtk.HButtonBox()
		hBox.add(gtk.Label("Password"))
		hBox.add(gtk.Entry())
		vBox.add(hBox)

		box.add(vBox)
		self.add(box)
		self.show_all()



####################################################################################################
####################################################################################################



		
		
		
####################################################################################################
####################################################################################################



	
	

