import gtk
from soapbox.gui.pages import page
from soapbox import widgets
#import page,widgets
################################
# The main screen for playout
################################
class playout(page.page):
    def __init__(self,db,pb):
	page.page.__init__(self,'Main')
	
	################
	# Boxes
	hBox=gtk.HBox()
	mainCont=gtk.VBox()
	################

	################
	# Sample data
#	db.insert()

	################
	# Appends
	#mainCont.pack_start(widgets.main.jinglesPage())


	mainCont.pack_start(widgets.main.page_jingles(db,pb.get_source('jingles')))
	#mainCont.pack_end(widgets.main.infoBox(),False)
	hBox.pack_start(mainCont)
	self.add(hBox)
	################

	
