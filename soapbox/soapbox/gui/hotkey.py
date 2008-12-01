import pygtk
pygtk.require('2.0')
import gtk,gobject

class Container(gtk.VBox):
    table=None

    def __init__(self,hotKey):
	gtk.VBox.__init__(self)
	self.table=Table()

	self.table.connect("update",hotKey.update)

	self.pack_start(self.table)
	self.pack_end(Controls(self),False)

    def edit_clicked(self,refer):
	self.table.edit_mode=not self.table.edit_mode
	self.table.emit("update")

class Table(gtk.Table):
    __gsignals__ = {
	"update":(gobject.SIGNAL_RUN_LAST, gobject.TYPE_NONE, [])
    }
    edit_mode=False

    def __init__(self,rows=4,columns=4,homogeneous=True):
	gtk.Table.__init__(self,rows,columns,homogeneous)
	self.itemControls=ItemControls()

    def add_item(self):
	None

    def add_table(self):
	None

    def add_controls(self):
	if self.edit_mode:
	    self.attach(self.itemControls,0,1,0,1)
	else:
	    self.remove(self.itemControls)
	self.show_all()
	

class Button(gtk.Button):
    def __init__(self,label=""):
	gtk.Button.__init__(self,label)

class TableButton(Button):
    def __init__(self):
	Button.__init__(self)

class ItemButton(Button):
    def __init__(self):
	Button.__init__(self)
	self.remove(self.get_child())
	self.add(gtk.VBox())

class Controls(gtk.HBox):
    def __init__(self,parent):
	gtk.HBox.__init__(self)
	self.set_size_request(-1,100)

	edit=EditButton()
	edit.connect("clicked",parent.edit_clicked)
	self.pack_start(edit,False)

class ItemControls(gtk.VBox):
    def __init__(self):
	gtk.VBox.__init__(self)
	
	addTable=gtk.Button("Add Table")
	self.pack_start(addTable)
	addItem=gtk.Button("Add Item")
	self.pack_end(addItem)

class EditButton(gtk.Button):
    def __init__(self):
	gtk.Button.__init__(self,"Edit")
	self.set_size_request(150,-1)

