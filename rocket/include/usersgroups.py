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

import gtk
from settingsForm import *

class usersgroupsSettings(gtk.Dialog):
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

		########
		# Content
		########
		notebook = gtk.Notebook()
		notebook.append_page(usersSettings(db),gtk.Label("Users"))
		notebook.append_page(groupsSettings(db),gtk.Label("Groups"))
		
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

class usersSettings(settingsSection):
	def __init__(self,db):
		self.db=db

		########
		# Menu
		########		
		ui = '''<ui>	
			<toolbar name="menu">
				<toolitem action="newUser"/>
				<separator/>
				<toolitem action="editUser"/>
				<separator/>
				<toolitem action="deleteUser"/>
			</toolbar>
			</ui>'''
		actions = [('newUser',gtk.STOCK_NEW, '_New User',None,
				'Create a new user',lambda x:self.newRow()),
			('editUser',gtk.STOCK_EDIT, '_Edit User', None,
				'Edit the selected user',lambda x:self.editRow()),	
			('deleteUser',gtk.STOCK_DELETE, '_Delete User', None,
				'Delete the selected user',lambda x:sl.remove_row())]
		########
		# settingItems
		########
		rows = {}
		listRows = {}			
		connections = db.select("users","user_id,name,realname")
		for connection in connections:
			rows[connection["name"]] = OrderedDict([
					("id", connection["user_id"]),	
					("name", connection["name"])					
					])
			
			listRows[connection["name"]] = {
					"id" : connection["user_id"],
					
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
					})
				]),
			"listRows" : listRows,
			"rows" : rows
		}		
	
	
		self.sSection = settingsSection.__init__(self,self.data)

	def saveData(self,inData):
		print ""

################################################################################

class groupsSettings(settingsSection):
	def __init__(self,db):
		self.db=db

		########
		# Menu
		########		
		ui = '''<ui>	
			<toolbar name="menu">
				<toolitem action="newGroup"/>
				<separator/>
				<toolitem action="editGroup"/>
				<separator/>
				<toolitem action="deleteGroup"/>
			</toolbar>
			</ui>'''
		actions = [('newGroup',gtk.STOCK_NEW, '_New Group',None,
				'Create a new group',lambda x:self.newRow()),
			('editGroup',gtk.STOCK_EDIT, '_Edit Group', None,
				'Edit the selected group',lambda x:self.editRow()),	
			('deleteGroup',gtk.STOCK_DELETE, '_Delete Group', None,
				'Delete the selected user',lambda x:sl.remove_row())]
		########
		# settingItems
		########
		rows = {}
		listRows = {}			
		connections = db.select("groups","group_id,name")
		for connection in connections:
			rows[connection["name"]] = OrderedDict([
					("id", connection["group_id"]),	
					("name", connection["name"])					
					])
			
			listRows[connection["name"]] = {
					"id" : connection["group_id"],
					
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
					})
				]),
			"listRows" : listRows,
			"rows" : rows
		}		
	
	
		self.sSection = settingsSection.__init__(self,self.data)

	def saveData(self,inData):
		print ""
