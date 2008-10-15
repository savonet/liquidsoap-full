import gtk

class page(gtk.EventBox):
    label=""
    def __init__(self,label=''):
	self.label=label
	gtk.EventBox.__init__(self)
