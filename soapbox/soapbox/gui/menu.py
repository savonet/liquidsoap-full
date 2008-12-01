import gtk
class navigation(gtk.Notebook):
    def __init__(self,pages):
	gtk.Notebook.__init__(self)
	self.set_tab_pos(gtk.POS_LEFT)
	for item in pages:
	    page=pages[item]
	    label=gtk.Label(page.label)
	    label.set_size_request(100,60)
	    self.append_page(page,label)

