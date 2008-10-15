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
from scrollList import scrollList
from odict import *

class settingsSection(gtk.Frame):
	def __init__(self,data):
		gtk.Frame.__init__(self)
		########
		# Content
		########
		self.sl = sl =  scrollList( data["listColumns"] )
		self.data = data
		
		for item in data["rows"]:
			row = []
			for col in data["listColumns"]:
				row.append(data["listRows"][item][col])
			
			sl.append_row(row)
					
		########
		# UI Manager
		########	
		uimanager = gtk.UIManager()
		uimanager.add_ui_from_string(data["ui"])		
		actiongroup =  gtk.ActionGroup("Settings")	
		actiongroup.add_actions( data["actions"] )
		uimanager.insert_action_group(actiongroup, 0)		

		########
		# Layout
		########
		menubar = uimanager.get_widget('/menu')
		vBox = gtk.VBox(False,2)
		vBox.show()
		vBox.pack_start(sl)
		vBox.pack_start(menubar)
		self.add(vBox)
		self.show_all()

	def appendRow(self,row):
		self.sl.append_row(row)		

	def newRow(self):
		data = self.data
		items = []
		for item in data["columns"]:
			items.append( (item,{	"label":data["columns"][item]["label"],"type":data["columns"][item]["type"]	}))
		sForm = settingsForm("Stream",OrderedDict(items))	
		if len(sForm.dataFields)!=0:
			if not self.sl.search(sForm.dataFields["name"]):
				self.saveData(sForm.dataFields)
			else:
				self.newRow()
		
	def editRow(self):

		label = self.sl.get_current()
		data = self.data
		if label == None:
			return
		items = []

		for item in data["columns"]:
			items.append( (item,{	"label":data["columns"][item]["label"], "value":str(data["rows"][label][str(item)]),"type":data["columns"][item]["type"] }))
		sForm = settingsForm("Stream",  OrderedDict(items)  )	
		if len(sForm.dataFields)!=0:
			self.saveData(sForm.dataFields)

class settingsForm(gtk.Dialog):
	def __init__(self,title,entries):
		gtk.Dialog.__init__(self,title,self,
                                gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT,
                                (gtk.STOCK_CANCEL, gtk.RESPONSE_CANCEL,
				gtk.STOCK_OK, gtk.RESPONSE_OK))		
		self.entries=entries
		self.set_skip_taskbar_hint(True)
		
		self.dataFields = {}		

		self.show()
		vBox = self.get_child()
		table = gtk.Table(2,3)		

		#Render the form fields
		row = 0;	
		for entry in entries:
			if entries[entry]["type"] == "text" :
				table.attach(gtk.Label(entries[entry]["label"]),0,1,row,row+1)
				inputBox = gtk.Entry(10)
				inputBox.set_name(entry)
				if entries[entry].has_key("value"):
					inputBox.set_text(entries[entry]["value"])
				table.attach(inputBox,1,2,row,row+1)
				row+=1

		self.set_size_request(300,50*row)
	
		table.show_all()
		vBox.add(table)
		self.table=table
		
		#Handle button reponses
		result = self.run()		
            	if result == gtk.RESPONSE_OK  or result == gtk.RESPONSE_APPLY:
			self.saveData()

		if result == gtk.RESPONSE_CANCEL or result == gtk.RESPONSE_OK:
                	self.destroy()
	
	def saveData(self):
		tableFields = {}
		for entry in self.table:
			if type(entry) ==  gtk.Entry and len(entry.get_text())!=0:
				tableFields[entry.get_name()]=entry.get_text()

		for entry in self.entries:
			if not entry in tableFields and "value" in self.entries[entry]:
				tableFields[entry]=self.entries[entry]["value"]
		self.dataFields = tableFields
