import pygtk
pygtk.require('2.0')
import gtk


#from soapbox import widgets
#from soapbox import odict
#from soapbox.gui.pages import jingles
#import soapbox.widgets,soapbox.gui.pages
#from soapbox.gui import menu
from soapbox.gui import hotkey

class guiWindow(gtk.Window):
    def __init__(self,hotKey):
	gtk.Window.__init__(self, gtk.WINDOW_TOPLEVEL)

	self.maximize()
	self.set_size_request(800,600)
	self.set_title('Soapbox')

	hotKey_container=hotkey.Container(hotKey)

	VBox=gtk.VBox()
	self.add(VBox)
	VBox.pack_end(hotKey_container)
	

	'''
	########
	# Layout boxes
	mainVBox=gtk.VBox() #Holds everything
	mainHBox=gtk.HBox() #Holds all but File menu
	mainContBox=gtk.VBox() #Holds Jingles & Message box
	########

	########
	#
	#self.catalogues=catalogues=widgets.catalogues.__init__()

	nav_items=odict.OrderedDict([
		#('main',jingles())
		#('main',pages.playout(db,pb)),
		#('cue',pages.cue())
		#('jingles',pages.jingles())
	]
	)
	navigation = menu.navigation(nav_items)
	########

	########
	# Appends
	self.add(mainVBox)
	#mainVBox.pack_start(widgets.menu.mainMenu(self),False)
	mainVBox.pack_end(mainHBox)
	
	#quickMenu=widgets.menu.quickMenu(p)
	mainHBox.pack_start(navigation)
	#mainHBox.pack_end(catalogues,False)
	#quickMenu.connect('switch-page',self.select_page)
#	mainHBox.pack_start(mainContBox)
#	mainHBox.pack_end(widgets.main.outsoapboxox(),False)

#	mainContBox.pack_start(widgets.main.jinglesoapboxoard())
#	mainContBox.pack_end(widgets.main.infoBox(),False)
	########
	'''
    '''
    def select_page(self,widget,*args):
	current=widget.get_children()[widget.get_current_page()-1]
	self.catalogues.set_edit(isinstance(current,pages.cue))
	if isinstance(current,pages.cue) or isinstance(current,pages.playout):
	  self.catalogues.show_all()
	else:
	  self.catalogues.hide_all()
    '''

