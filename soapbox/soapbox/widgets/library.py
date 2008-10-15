import gtk
'''
 The Music Library Widget

'''
def __init__():
  return library()

class library(gtk.VBox):
  def __init__(self):
	gtk.VBox.__init__(self)

	################
	# Main box
	self.library_items=self.library_items()
	self.category_filter=self.category_filter()
	HBox=gtk.HBox()
	HBox.pack_start(self.category_filter,False)
	HBox.pack_end(self.library_items)
	################

	################
	# Search Box	
	search_entry=gtk.Entry()
	search_label=gtk.Label('Search')
	search_label.set_size_request(100,-1)
	search_box=gtk.HBox()
	search_box.pack_start(search_label,False)
	search_box.pack_start(search_entry)
	search_box.pack_end(gtk.Button('Clear'),False)
	################

	self.pack_start(search_box,False)
	self.pack_start(HBox)

  class library_items(gtk.Table):
	'''
	   Class holding items that match
	   library filter
	'''
	def __init__(self):
	  gtk.Table.__init__(self,5,5)
	  i=0
	  while i<20:
		xCoord=len(self)%5
	   	yCoord=len(self)//5
		self.attach(gtk.Button(str(i)),xCoord,xCoord+1,yCoord,yCoord+1)
		i=i+1

  class category_filter(gtk.VBox):
	'''
	   Button Box to hold filters
	'''
	def __init__(self):
	  gtk.VBox.__init__(self,False)
	  self.pack_start(self.filter_button('Playlist'),False)
	  self.pack_start(self.filter_button('Top Tracks'),False)
	  self.pack_start(gtk.Label('Search by'),False)
	  self.pack_start(self.filter_button('Artist'),False)
	  self.pack_start(self.filter_button('Track'),False)
	  
	  

	class filter_button(gtk.Button):
	  def __init__(self,l):
		gtk.Button.__init__(self,l)
		self.set_size_request(-1,80)


