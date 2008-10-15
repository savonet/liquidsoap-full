#!/usr/bin/python

import gtk,gobject


class scrollList(gtk.ScrolledWindow):
	listModel = gtk.ListStore(gobject.TYPE_STRING,
				 gobject.TYPE_STRING)	
	treeView = gtk.TreeView()

	def __init__(self,columns):		
		gtk.ScrolledWindow.__init__(self)
		self.columns = columns
		self.set_size_request(1,1)
		self.show()
		listArgs = []
		for column in columns:
			listArgs.append( gobject.TYPE_STRING )
		self.listModel = gtk.ListStore( *listArgs)

		self.treeView = gtk.TreeView()
		self.treeView.show()
		self.add(self.treeView)
		
		self.treeView.set_model(self.listModel)

		self.treeView.set_headers_visible(True)
		

		count = 0
		for column in columns:
			
			renderer=gtk.CellRendererText()
			column=gtk.TreeViewColumn(columns[column]["label"],renderer,text=count)
			column.set_resizable(True)
			self.treeView.append_column(column)
			count+=1
	

	def append_row(self,row):		
		self.listModel.append(row)

	def search(self,data):
		if not self.listModel:
			return False
		for row in self.listModel:
			if row[0] == data:
				return True
		return False

	def remove_row(self):
		(model, iter) = self.treeView.get_selection().get_selected()
		if iter:
			model.remove(iter)		

	def get_current(self):	
		(model, iter) = self.treeView.get_selection().get_selected()
		if iter:
			current = model.get(iter,0)
	
			return current[0]
		else:
			return None

	def get_num_cols(self):
		return len(self.treeView.get_columns())
	
		
