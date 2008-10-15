import gtk,pango
'''
   Catalogues
	The outputs for music
'''

def __init__():
  return catalogues()

class catalogues(gtk.VBox):
  catalogues=[]
  edit=False

  def __init__(self):
	gtk.VBox.__init__(self)

	#### Sample data
	self.add_catalogue('Catalogue 1')
	self.add_catalogue('Catalogue 2')

  def set_edit(self,edit):
	self.edit=edit
	for i in self.catalogues:
	  i.set_edit(edit)

  def add_catalogue(self,source):
	catalogue=self.catalogue(source)
	self.catalogues.append(catalogue)
	self.pack_start(catalogue,False)


  class catalogue(gtk.EventBox):
	'''
	   
	'''
	source=None

	def __init__(self,source):
	  gtk.EventBox.__init__(self)
	  self.source=source

	  self.edit_assign=gtk.Button('->')

	  ################
	  # Playlist
	  playlist=gtk.Label('Playlist')
	  ################  

	  ################
	  # Main VBox
	  VBox=gtk.VBox()
	  VBox.pack_start(gtk.Label(source))
	  VBox.pack_start(playlist)
	  VBox.pack_start(self.control_buttons())

	  ################	  
	
	  ################
	  # Main HBox
	  self.HBox=gtk.HBox()
	  self.HBox.pack_start(self.edit_assign)
	  self.HBox.pack_end(VBox)
	  self.add(self.HBox)
	  ################

	def set_edit(self,edit):
	  if edit:
		self.HBox.pack_start(self.edit_assign)
	  else:
		self.HBox.remove(self.edit_assign)

	class control_buttons(gtk.HBox):
	  def __init__(self):
		gtk.HBox.__init__(self)

		################
	 	# Buttons
		playButton=gtk.ToggleButton()
	    	playButton.set_label('PLAY')	    
	    	playButton.set_size_request(-1,int(pango.SCALE/20))	    

	    	playButtonFont=pango.FontDescription()
	    	playButtonFont.set_size(20*pango.SCALE)	
	    	playButton.modify_font(playButtonFont)

	    	ejectButton=gtk.Button("Eject")
	    	ejectButton.modify_bg(gtk.STATE_NORMAL,gtk.gdk.Color(40000,20000,20000))
	
		queueButton=gtk.Button("QUEUE")	
		################

		################
		# Timer
		timerBox=gtk.EventBox()
	    	timerBox.set_size_request(100,-1)

	    	timerFont=pango.FontDescription()
	    	timerFont.set_size(22*pango.SCALE)

		timerLabel=gtk.Label('00:50')
	    	timerLabel.modify_font(timerFont)

	    	timerBox.add(timerLabel)
		################

		self.pack_start(playButton)
		self.pack_start(ejectButton)
		self.pack_start(timerBox)
		self.pack_end(queueButton)

		
