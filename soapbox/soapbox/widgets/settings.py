import gtk

class content(gtk.Dialog):

  def __init__(self):
	gtk.Dialog.__init__(self,"Content")
	self.set_size_request(500,400)
	self.set_skip_taskbar_hint(True)
	self.show_all()
