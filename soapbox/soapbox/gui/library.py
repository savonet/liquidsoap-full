import gtk,gobject

class library_settings(gtk.Dialog):
  

  def __init__(self,soapbox):
	self.soapbox=soapbox
	gtk.Dialog.__init__(self,"Library settings")
	self.set_size_request(300,200)
	self.set_skip_taskbar_hint(True)
	vBox=self.get_child()

	self.listStore = gtk.ListStore(str)
	self.listStore.append(["String 1"])
	self.listStore.append(["String 2"])
	self.listStore.append(["String 3"])
	self.listStore.append(["String 4"])
	self.listStore.append(["String 5"])
	self.listColumn = gtk.TreeViewColumn("Directory")
	self.textRenderer = gtk.CellRendererText()
	self.listColumn.pack_start(self.textRenderer, True)
	self.listColumn.set_attributes(self.textRenderer, text = 0)
	self.listBox = gtk.TreeView(self.listStore)
	self.listBox.append_column(self.listColumn)

	#Buttons
	add=gtk.Button('Add')
	add.connect('clicked',self.on_add)
	

	directory_buttons=gtk.VBox()
	directory_buttons.pack_start(add,False,False)
	directory_buttons.pack_start(gtk.Button('Remove'),False,False)

	directory_box=gtk.HBox()
	directory_box.pack_start(self.listBox)
	directory_box.pack_end(directory_buttons,False)

	vBox.pack_start(directory_box)
	self.show_all()

  def on_add(self,button,*args):
	dialog = gtk.FileChooserDialog('Add directory',
	self, gtk.FILE_CHOOSER_ACTION_SELECT_FOLDER,
            (gtk.STOCK_CANCEL, gtk.RESPONSE_CANCEL,
            gtk.STOCK_ADD, gtk.RESPONSE_OK))
	dialog.show_all()
	response = dialog.run()
        dialog.hide()

        if response == gtk.RESPONSE_OK:
            path = dialog.get_filename()
            import_location = self.exaile.settings.get_str('import/location')
            tmp_items = self.items + [import_location]

            for item in tmp_items:
                if not item: continue
                if path.startswith(item):
                    # our added path is a subdir of an existing path
                    return
                elif item.startswith(path):
                    # path is a parent to some previously added directories
                    if item == import_location:
                        # we don't remove the import dir from the list.
                        # instead we don't scan it anymore, since the
                        # dir we are adding right now covers it
                        self.exaile.settings['import/scan_import_dir'] = False
                    else:
                        self.list.remove(item)
    
            self.add_list.append(path)
            self.list.append(path)

        dialog.destroy()
	
