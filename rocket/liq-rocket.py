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
import sys
sys.path.append("include")

import pygtk
pygtk.require('2.0')
import gtk

from db import db
from mainPages import *	
from settings import *
from contentSettings import *
from usersgroups import *
from daemon import daemon
from playback import *

class guiWindow(gtk.Window):
    ui = '''<ui>
    <menubar name="MenuBar">
      <menu action="File">
        <menuitem action="Quit"/>
      </menu>
      <menu action="Tools">
	<menuitem action="content"/>
	<menuitem action="users/groups"/>
	
	<menuitem action="Settings"/>
      </menu>
    </menubar>
    </ui>'''

    def __init__(self):
	#Initilize the connections
	self.daemon = daemon()
	self.daemon.load()
	self.db = db()

	#self.playback = playback(self.daemon)

#	self.db.createTables()
	gtk.Window.__init__(self, gtk.WINDOW_TOPLEVEL)
	
	self.connect('destroy', lambda w: exit())
	#Window properties
	self.set_title("LiGUIdsoap Rocket")
	self.set_size_request(800,600)

	#Menubar as created by a uimanager
	uimanager = gtk.UIManager()
	uimanager.add_ui_from_string(self.ui)	
	accelgroup = uimanager.get_accel_group()
       	self.add_accel_group(accelgroup)
	actiongroup = gtk.ActionGroup('UIManagerExample')
        actiongroup = actiongroup
	uimanager.insert_action_group(actiongroup, 0)

        # Create actions
        actiongroup.add_actions([('Quit', gtk.STOCK_QUIT, '_Quit', None,
                                  'Quit the Program', None),
				 ('content',None, '_Content', None, None,lambda x:contentSettings(self.db)),
				 ('users/groups',None, '_Users/Groups', None, None,lambda x:usersgroupsSettings(self.db)),
				 ('Settings',None, '_Settings', None, None,lambda x:settings(self.db)),
                                 ('File', None, '_File'),
				 ('Tools', None, '_Tools')
				])
        actiongroup.get_action('Quit').set_property('short-label', '_Quit')
	menubar = uimanager.get_widget('/MenuBar')

	#Bottom pane
	#bottomPane = gtk.HBox(False,2)
	#bLeftPane = infoNotebook()
	#bRightPane = jinglePage(self.db,self.playback)
	
	#bottomPane.pack_start(bLeftPane)
	#bottomPane.pack_end(bRightPane)

	#The main vertical container
	vBox = gtk.VBox(False,3)	
	vBox.pack_start(menubar,0)
	vBox.pack_start(mainNotebook(self.db,self.daemon), 50)	
	#vBox.pack_end(bottomPane,10)

	self.add(vBox)
	
	self.show_all()

	def exit():
		self.daemon.close()
		#self.playback.close()
		gtk.main_quit()
   
####################################################################################################
####################################################################################################

class mainNotebook(gtk.Notebook): 
#The main tabbed index
    def __init__(self,db,daemon):
	gtk.Notebook.__init__(self)

	#Empty Frames
	
	#beds = gtk.Frame("Empty Frame")
	#beds.show()			

	#self.append_page(statusPage(daemon),gtk.Label("Status"))	
	#self.append_page(mixerPage(),gtk.Label("Mixer"))
	#self.append_page(playlistPage(),gtk.Label("Playlist"))
	#self.append_page(messagesPage(),gtk.Label("Messages"))
	

	self.append_page(jinglePage(db,playback(daemon,'jingles')),gtk.Label("Jingles"))	
	#self.append_page(beds,gtk.Label("Beds"))	
	self.show()

class infoNotebook(gtk.Notebook):
    def __init__(self):
	gtk.Notebook.__init__(self)
	
	#self.append_page(messagesPage(),gtk.Label("Messages"))
	#self.append_page(webcamPage(),gtk.Label("Webcam"))
	
####################################################################################################
####################################################################################################


####################################################################################################
####################################################################################################

class liguidsoap:
    def __init__(self):
	mainWindow = guiWindow()

    def main(self):
        gtk.main()


#myDB.dropTables()

if __name__ == "__main__":
    liguidsoap = liguidsoap()
    liguidsoap.main()

