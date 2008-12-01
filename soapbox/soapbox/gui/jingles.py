import gtk
from soapbox import jingles

class jingle_board(gtk.Table):
  def __init__(self):
	gtk.Table(self,4,5,True)


class jingle_button(gtk.Button):
  def __init__(self):
	gtk.Button.__init__(self)
