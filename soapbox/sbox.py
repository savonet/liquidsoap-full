#!/usr/bin/python


import sys,os,time
sys.path.append(os.environ['PWD']+'/../lib/python'+sys.version[:3]+'/site-packages')
mainPath=sys.path[0]
sys.path.append(mainPath+'/libs')

if os.environ.has_key('_'):
  path=os.environ['_'][2:]
  p=path.split('/')
  s=""
  for i in p[:len(p)-2]:
	s+=i+'/'
  sys.path.append(s+'lib/python'+sys.version[:3]+'/site-packages')

import pygtk
pygtk.require('2.0')
import gtk

from soapbox import odict,db,playback

from xl.collection import Collection,Library


##################################
# Calls to create everything
##################################
class soapbox: 
    def __init__(self):
	from soapbox.gui import main as guiMain
	db_con=db.__init__()
	self.playback=playback.__init__()
	time.sleep(2)
	mainWindow=guiMain.guiWindow(db_con,self.playback)
	mainWindow.connect("delete_event",self.quit)
	mainWindow.show_all()

    def quit(self,sender,event):
	gtk.main_quit()
	self.playback.disconnect()

    def main(self):
        gtk.main()

if __name__ == "__main__":
    soapbox=soapbox()
    soapbox.main()

