import gtk,random,pango,gobject,sys,copy
#odict

'''
  **JINGLES**
  
'''

class page_jingles(gtk.VBox):
  '''
    Main page to hold all jingle boards
  '''
  source=None
  root=None
  current=None
  edit=False

  def __init__(self,db,source):
	gtk.VBox.__init__(self)
	self.db=db
	self.source=source
	source.start()
	source.set_play(True)
	source.connect('queue',self.update_queue)

	########################
	# Get root element
	rootData=db.select('soundBoards','board_id,name','board_id=1')
	if len(rootData)==0:
	  db.insert('soundBoards',{'board_id':1,'name':'index'})
	  rootData=db.select('soundBoards','board_id,name','board_id=1')
	self.root=self.current=sound_board(self,rootData[0])
	########################
	self.boards_navigator=boards_navigator(self)

	self.pack_start(self.root)
	self.pack_end(items_navigator(self),False)
	self.pack_end(self.boards_navigator,False)
  def get_table(self):
	None
  def get_items_navigator(self):
	None
  def get_boards_navigator(self):
	current=self.current.parent_board
	while current:
	 current=current.parent_board
  def update_queue(self,refer,data):
	self.root.update_queue(data)
  def enqueue(self,button):
	self.source.enqueue(button)
  def skip(self):
	self.source.skip()
  def set_board(self,board):
	previous=self.current
	self.remove(previous)
	self.pack_start(board)
	self.current=board
	self.boards_navigator.update()
	'''
	res=self.db.select('soundBoards','board_id, name','board_id='+str(board_id))
	previous=self.current
	self.remove(previous)
	current=sound_board(self,res[0])
	current.parent_board=previous
  	self.pack_start(current)
	self.current=current
	self.get_boards_navigator()
	'''
	

class sound_board(gtk.Table):
  '''
    Sound board
  '''
  board_id=None
  board_name=None
  items=None
  item_new=None 
  pastelColours=None
  parent_board=None
  current_path=None 

  def __init__(self,refer,boardData):
	gtk.Table.__init__(self,4,5,True)
	
	########################
	# Assign values
	self.db=db=refer.db
	self.refer=refer
	self.board_id=boardData['board_id']
	self.board_name=boardData['name']
	self.pastelColours=pastelColours()
	self.items={}
	self.load_table()

  def load_table(self):
	'''
	  Get board items
	'''
	itemsData=self.db.select('boardItems','boardItem_id,bgColour,fgColour,board_id,file_id',"soundBoard_id=%s"%self.board_id)	
#	itemsData=self.db.select('boardItems as bI','boardItem_id,bgColour,fgColour,board_id,file_id',"soundBoard_id=%s"%self.board_id)	

	if self.item_new:
	  self.remove(self.item_new)
	  self.item_new=None



	for i in itemsData:
	  if not self.items.has_key(i['boardItem_id']):
	    button=None
	    xCoord=len(self)%5
	    yCoord=len(self)//5
	    if i['board_id'] and i['file_id']:
		continue #We have a freak record

	    if i['board_id']: # Sound board item
		j=self.db.select('soundBoards','name','board_id='+str(i['board_id']))
		if len(j)>0:
		  button=button_jingleBoard(self,i['boardItem_id'],j[0]['name'])
	    if i['file_id']:
		j=self.db.select('files','name,filename,path','file_id='+str(i['file_id']))
		button=button_jingle(self,i['boardItem_id'],j[0]['path']+'/'+j[0]['filename'],j[0]['name'],i['fgColour'],i['bgColour'])
	    if button:
	      self.items[i['boardItem_id']]=button
	      self.attach(button,xCoord,xCoord+1,yCoord,yCoord+1)
	  else:
	    k=None
	    if i['board_id']: #Temp FIX
		j=self.db.select('soundBoards','name','board_id='+str(i['board_id']))
	    if i['file_id']:
		j=self.db.select('files','name,filename,path','file_id='+str(i['file_id']))
		k=self.db.select('boardItems','bgColour,fgColour','file_id='+str(i['file_id']))
	    if len(j)>0:
		item=self.items[i['boardItem_id']]
		item.set_label(j[0]['name'])
		if k:
		  item.modify_bg(gtk.STATE_NORMAL,gtk.gdk.color_parse(k[0]['bgColour']))
		  item.modify_bg(gtk.STATE_PRELIGHT,gtk.gdk.color_parse(k[0]['bgColour']))

	################
	# Remove items
	keys=[]
	for i in itemsData:
	  keys.append(i['boardItem_id'])

	rmItems=[]
	for i in self.items:
	  if i not in keys:
		total=len(self.get_children())
		rmItem=self.items[i]
		if isinstance(rmItem,button_jingle):
		  if rmItem.state=='playing':
			self.skip()
		  
		position=self.get_children().index(self.items[i])
		self.remove(self.items[i])
		rmItems.append(i)
		################
		# Adjust table	
		if position!=0:
		  children=self.get_children()
		  j=position-1
		  while j>=0:
		    item=children[j]
		    newPos=(total-1)-j-1
		    xCoord=newPos%5
	    	    yCoord=newPos//5
		    self.remove(item)
		    self.attach(item,xCoord,xCoord+1,yCoord,yCoord+1)
		    self.show_all()
		    j=j-1
		 ################
	
	for i in rmItems:
	  del(self.items[i])
	################

	if self.refer.current==self and self.refer.edit:
	  xCoord=len(self)%5
	  yCoord=len(self)//5
	  self.item_new=item_new(self)
	  self.attach(self.item_new,xCoord,xCoord+1,yCoord,yCoord+1)

	self.show_all()

  def update_queue(self,data):
	for i in self.items:
	  item=self.items[i]

	  if isinstance(item,button_jingle) and item.queue_rid and int(item.queue_rid)==data[0]['rid']:
		item.state=data[0]['status']
		item.start()
	  if isinstance(item,button_jingleBoard):
		item.board_child.update_queue(data)
  def enqueue(self,button):
	self.refer.enqueue(button)
  def skip(self):
	self.refer.skip()

class board_item(gtk.VBox):
  def __init__(self):
	gtk.VBox.__init__(self)

class item_new(board_item):
  def __init__(self,refer):
	board_item.__init__(self)
	self.refer=refer
	self.db=refer.db

	button_addJingle=gtk.Button('Add Jingle')
	button_addJingle.connect('clicked',lambda x:jingle_editor(refer))
	button_addJingle.modify_bg(gtk.STATE_NORMAL,gtk.gdk.Color(42321,13732,13005))
	button_addBoard=gtk.Button('Add Board')
	button_addBoard.connect('clicked',lambda x:board_editor(refer))
	button_addBoard.modify_bg(gtk.STATE_NORMAL,gtk.gdk.Color(42321,13732,13005))
	self.pack_start(button_addJingle)
	self.pack_end(button_addBoard)

class item_sound(board_item):
  file_uri=None
  bgColour=gtk.gdk.Color(0,0,0)
  fgColour=gtk.gdk.Color(0,0,0)
  
  def __init__(self,file_uri=None):
	board_item.__init__(self)
	self.file_uri=file_uri

class item_board(board_item):
  board=None

  def __init__(self,board):
	board_item.__init__(self)
	self.board=board

########################
# Dialogs

class board_editor(gtk.Dialog):
  nameEntry=None
  button=None
  soundBoard=None

  def __init__(self,soundBoard,button=None):
	if button:
	  title='Edit Board'
	else:
	  title='Add Board'

	gtk.Dialog.__init__(self,title,None,
			gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT,
                     ( gtk.STOCK_DELETE, gtk.RESPONSE_NO,
		      gtk.STOCK_CANCEL, gtk.RESPONSE_REJECT,
                      gtk.STOCK_OK, gtk.RESPONSE_ACCEPT))
	if not button:
	  self.set_response_sensitive(gtk.RESPONSE_NO, False)
	self.show_all()
	self.set_skip_taskbar_hint(True)
	self.soundBoard=soundBoard
	self.button=button
	
	self.nameEntry=nameEntry=gtk.Entry()
	if button:
	  nameEntry.set_text(button.get_label())
	VBox=self.get_child()

	self.connect('response',self.response)

	nameEntry.connect('changed',self.validate_form)
	self.validate_form(None)

	HBox=gtk.HBox()
	HBox.pack_start(gtk.Label('Name'))
	HBox.pack_start(nameEntry)
	VBox.pack_start(HBox)
	VBox.show_all()
	

  def validate_form(self,*args):
	if len(	self.nameEntry.get_text())==0:
	  self.set_response_sensitive(gtk.RESPONSE_ACCEPT, False)
	else:
	  self.set_response_sensitive(gtk.RESPONSE_ACCEPT, True)
	  
	  

  def response(self,widget,response):
	if response==gtk.RESPONSE_NO:
	  db=self.soundBoard.db
	  boardItem=db.select('boardItems','board_id',"boardItem_id=%s"%self.button.item_id)

	  db.remove('boardItems',"board_id=%s"%boardItem[0]['board_id'])
	  db.remove('boardItems',"soundBoard_id=%s"%boardItem[0]['board_id'])
	  db.remove('soundBoards',"board_id=%s"%boardItem[0]['board_id'])
	  self.soundBoard.load_table()
	if response==gtk.RESPONSE_ACCEPT:
	  db=self.soundBoard.db
	  if(len(self.nameEntry.get_text())):
	    if self.button:
		boardItem=db.select('boardItems','board_id',"boardItem_id=%s"%self.button.item_id)
		db.update('soundBoards',{'name':self.nameEntry.get_text()},"board_id=%s"%boardItem[0]['board_id'])
	    else:
	    	db.insert('soundBoards',{'name':self.nameEntry.get_text()})
	    	db.insert('boardItems',{'soundBoard_id':self.soundBoard.board_id,'board_id':db.last_insert()})
	    self.soundBoard.load_table()
	self.destroy()

class jingle_editor(gtk.Dialog):
  soundBoard=None
  button=None
  formFields={}

  def __init__(self,soundBoard,button=None):
	gtk.Dialog.__init__(self,'Add Jingle',None,
			gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT,
                     (  gtk.STOCK_DELETE, gtk.RESPONSE_NO,
			gtk.STOCK_CANCEL, gtk.RESPONSE_REJECT,
                      gtk.STOCK_OK, gtk.RESPONSE_ACCEPT))
	if not button:
	  self.set_response_sensitive(gtk.RESPONSE_NO, False)
	################
	# Assignments
	self.button=button
	self.soundBoard=soundBoard
	self.set_skip_taskbar_hint(True)
	self.set_response_sensitive(gtk.RESPONSE_ACCEPT, False)
	self.connect('response',self.response)
	################

	self.formFields['itemChooser']=itemChooser = gtk.FileChooserButton("Select Item")
	self.formFields['labelEntry']=labelEntry=gtk.Entry()
	self.formFields['sampleButton']=sampleButton=button_jingle(self.soundBoard,itemChooser.get_filename(),-1)
	################
	# Item Chooser
	
	if button and button.filename:
	  itemChooser.set_filename(button.filename)
	fileFilter = gtk.FileFilter()
	fileFilter.set_name("Audio MP3/Ogg")
	fileFilter.add_pattern("*.[mM][pP]3")
	fileFilter.add_pattern("*.[oO][gG][gG]")
	itemChooser.add_filter(fileFilter)
	if soundBoard.current_path:
	  itemChooser.set_current_folder(soundBoard.current_path)
	itemChooser.connect('selection-changed',self.validate_form)
	################

	################
	# LabelEntry	
	
	if button and button.get_label() and len(button.get_label())>0:
	  label=button.get_label()
	  labelEntry.set_text(label)
	else:
	  labelEntry.set_text('Select a file first')
	  labelEntry.set_sensitive(False)
	  label=None

	labelEntry.connect('changed',self.validate_form)
	
	################

	################
	# Colour buttons	
	if self.button:
	  bg=button.bg
	  fg=button.fg
	else:
	  bg=soundBoard.pastelColours.get_colour()
	  fg=gtk.gdk.Color(65504,65504,65504)
	self.formFields['bgColour_select']=bgColour_select=gtk.ColorButton(bg)
	bgColour_select.connect('color-set',self.update_sample)
	bgColour_random=gtk.Button('Random')
	bgColour_random.connect('clicked',self.set_rand_bg)
	bgColour=gtk.HBox()
	bgColour.pack_start(bgColour_select)
	bgColour.pack_end(bgColour_random,False)

	self.formFields['fgColour']=fgColour=gtk.ColorButton(fg)
	fgColour.connect('color-set',self.update_sample)
	################
	labelEntry.connect('changed',self.update_sample)

	
	sampleButton.modify_bg(gtk.STATE_NORMAL,bgColour_select.get_color())
	sampleButton.set_size_request(-1,100)
	if label:
	  sampleButton.set_label(label)
	################
	################
	# Form Appendes	
	menuItems=[]
	menuItems.append({'label':'File','field':itemChooser})
	menuItems.append({'label':'Label','field':labelEntry})
	menuItems.append({'label':'Background colour','field':bgColour})
	menuItems.append({'label':'Text colour','field':fgColour})
	menuItems.append({'label':'Sample','field':sampleButton})
	################
	################
	# Add form items
	VBox=self.get_child()
	for i in menuItems:
	  HBox=gtk.HBox()
	  label=gtk.Label(i['label'])
	  label.set_size_request(150,-1)
	  HBox.pack_start(label,False)
	  HBox.pack_end( i['field'] )
	  VBox.pack_start(HBox)
	self.show_all()
	################

  def set_rand_bg(self,widget):
	bg=self.soundBoard.pastelColours.get_colour()
	self.formFields['bgColour_select'].set_color(bg)
	self.update_sample(self.formFields['bgColour_select'])
	
  def validate_form(self,widget):
	itemChooser=self.formFields['itemChooser']
	labelEntry=self.formFields['labelEntry']

	################
	# Label entry
	if not itemChooser.get_uri():
	  labelEntry.set_sensitive(False)
	else:
	  labelEntry.set_sensitive(True)
	  if labelEntry.get_text()=='Select a file first':
		title=self.soundBoard.refer.source.request_tag(itemChooser.get_filename(),self.update_labelEntry)
			  
	  	labelEntry.set_text(title)

	################

	################
	# OK Button
	if not itemChooser.get_uri() or len(labelEntry.get_text())==0:
	  self.set_response_sensitive(gtk.RESPONSE_ACCEPT, False)
	else:
	  self.set_response_sensitive(gtk.RESPONSE_ACCEPT, True)
	################
  def update_labelEntry(self,text):
	self.formFields['labelEntry'].set_text(text)

  def update_sample(self,widget):
	
	sam=self.formFields['sampleButton']
	if widget==self.formFields['bgColour_select']:
	  sam.modify_bg(gtk.STATE_NORMAL,widget.get_color())
	if widget==self.formFields['fgColour']:
	  sam.get_child().modify_fg(gtk.STATE_NORMAL,widget.get_color())
	if widget==self.formFields['labelEntry']:
	  sam.set_label(self.formFields['labelEntry'].get_text())
	

  def response(self,widget,response):
	if response==gtk.RESPONSE_NO:
	  db=self.soundBoard.db
	  db.remove('boardItems','boardItem_id='+str(self.button.item_id))
	  self.soundBoard.load_table()

	if response==gtk.RESPONSE_ACCEPT:
	  ################
	  # Path check
	  path=self.formFields['itemChooser'].get_current_folder()
	  filename=self.formFields['itemChooser'].get_filename().rsplit('/')
  	  if path and filename:
		self.soundBoard.current_path=path		
	  	filename=filename[len(filename)-1]
	  else:
		self.destroy()
		return False
	  ################

	  ################
	  # LabelEntry check
	  if len(self.formFields['labelEntry'].get_text())==0:
		self.destroy()
		return False
	  ################
	  db=self.soundBoard.db
	  file_data = {
		'path':path,
		'filename':filename,
		'name':self.formFields['labelEntry'].get_text()
	  }
	  boardItem_data = {				
		'bgColour':self.formFields['bgColour_select'].get_color().to_string(),
		'fgColour':self.formFields['fgColour'].get_color().to_string()
	  }
	  if self.button:
	    db.update('boardItems',boardItem_data,'boardItem_id='+str(self.button.item_id))
	    res=db.select('boardItems','file_id','boardItem_id='+str(self.button.item_id))
	    db.update('files',file_data,'file_id='+str(res[0]['file_id']))
	    
	  else:	  	    
	    db.insert("files",file_data)	
	    boardItem_data['file_id']=db.last_insert()
	    boardItem_data['soundboard_id']=self.soundBoard.board_id
	    db.insert("boardItems",boardItem_data)
	  self.soundBoard.load_table()
	self.destroy()


########################
# Buttons
class button_jingle(gtk.Button):
  '''
    Button to spawn jingle playout
  '''
  item_id=None #ID as stored in DB
  filename=None
  sound_board=None
  queue_rid=None
  highlight=False
  colour=None
  state=None
  running=False
  ready=False
  highlight_ready=False
  fg=None
  bg=None

  def __init__(self,sound_board,item_id,filename,l="",fg=None,bg=None):
	gtk.Button.__init__(self,l)
	self.sound_board=sound_board
	self.item_id=item_id
	self.filename=filename
	################
	# Colours	
	if fg and self.get_child():
	  self.fg=gtk.gdk.color_parse(fg)
	  self.get_child().modify_fg(gtk.STATE_NORMAL,gtk.gdk.color_parse(fg))
	  
	if bg:
	  self.bg=gtk.gdk.color_parse(bg)
	  self.modify_bg(gtk.STATE_NORMAL,gtk.gdk.color_parse(bg))
	  self.colour=gtk.gdk.color_parse(bg)	
	  self.modify_bg(gtk.STATE_PRELIGHT,gtk.gdk.color_parse(bg))
	################
	self.connect('clicked',self.clicked)
	#self.connect('enter',self.clicked) #Used for touchscreens only

  def clicked(self,widget):
	if self.sound_board.refer.edit:
	  jingle_editor(self.sound_board,self)
	else:
	  if self.item_id > 0 and self.state!='playing' and self.state!='ready':
	  	self.sound_board.enqueue(self)
	  if self.state=='playing':
	  	self.sound_board.skip()

  def start(self):
	if not self.running:
	  self.running=True
	  gobject.timeout_add(600,self.blinking)
	if not self.ready:
	  self.ready=True
	  gobject.timeout_add(750,self.blink_ready)
  def blinking(self):	
	if self.state!='playing':
	  self.modify_bg(gtk.STATE_NORMAL,self.colour)
	  self.modify_bg(gtk.STATE_PRELIGHT,self.colour)
	  self.highlight=False
	  self.running=False
	  return False	
	if self.highlight:
	  self.modify_bg(gtk.STATE_NORMAL,self.colour)
	  self.modify_bg(gtk.STATE_PRELIGHT,self.colour)
	  self.highlight=False
	else:
	  self.modify_bg(gtk.STATE_NORMAL,gtk.gdk.Color(00000,50000,00000))
	  self.modify_bg(gtk.STATE_PRELIGHT,gtk.gdk.Color(00000,50000,00000))
	  self.highlight=True
	return True

  def blink_ready(self):	
	if self.state!='ready':
	  self.modify_bg(gtk.STATE_NORMAL,self.colour)
	  self.modify_bg(gtk.STATE_PRELIGHT,self.colour)
	  self.highlight_ready=False
	  self.ready=False
	  return False	
	if self.highlight_ready:
	  self.modify_bg(gtk.STATE_NORMAL,self.colour)
	  self.modify_bg(gtk.STATE_PRELIGHT,self.colour)
	  self.highlight_ready=False
	else:
	  self.modify_bg(gtk.STATE_NORMAL,None)
	  self.modify_bg(gtk.STATE_PRELIGHT,None)
	  self.highlight_ready=True
	return True
  

class button_jingleBoard(gtk.Button):
  '''
    Button to naviage boards
  '''
  item_id=None
  label=None
  board_child=None

  def __init__(self,soundBoard,item_id,l):
	gtk.Button.__init__(self)
	self.item_id=item_id
	self.soundBoard=soundBoard
	res=self.soundBoard.db.select('boardItems','board_id','boardItem_id='+str(item_id))
	self.board_child=sound_board(soundBoard.refer,{'board_id':res[0]['board_id'],'name':l})
	self.board_child.parent_board=soundBoard

	################
	# Background Image
	buttonImg=gtk.Image()
	buttonImg.set_from_file('/usr/soapbox/images/button_soundBoard.png')
	#self.set_property("image-position",gtk.POS_BOTTOM)
	#self.set_image(buttonImg)
	################

	################
	# Appends
	VBox=gtk.VBox()
	self.label=gtk.Label(l)
	VBox.pack_start(self.label)
	VBox.pack_end(buttonImg)
	VBox.show_all()
	self.add(VBox)
	################

	self.connect('clicked',self.clicked)

  def set_label(self,l):
	self.label.set_label(l)
  def get_label(self):	
	return self.label.get_label()
	
  def clicked(self,widget):
	if widget.soundBoard.refer.edit:
	  board_editor(widget.soundBoard,self)
	else:	
	  self.soundBoard.refer.set_board(self.board_child)

################################################################

class boards_navigator(gtk.HBox):
  refer=None
  path_items=gtk.HBox()

  def __init__(self,refer):
	gtk.HBox.__init__(self)	

	self.refer=refer
	
	self.homeButton=homeButton=gtk.Button()
	homeImage=gtk.Image()
	homeImage.set_from_file('/usr/soapbox/images/button_home.png')
	homeButton.set_image(homeImage)
	homeButton.connect('clicked',self.set_home)

	self.pack_start(homeButton,False)
	self.pack_start(self.path_items,False)
	

  def set_home(self,widget):
	self.refer.set_board(self.refer.root)

  def set_sensitive(self,sensitive):
	self.homeButton.set_sensitive(sensitive)
	for i in self.path_items.get_children():
	  i.set_sensitive(sensitive)

  def update(self):
	for i in self.path_items.get_children():
	  self.path_items.remove(i)
	current=self.refer.current
	
	while current:
	  res=self.refer.db.select('soundBoards','name','board_id='+str(current.board_id))
	  name=res[0]['name']
	  
	  if current.parent_board:
	    if current==self.refer.current:
		button=gtk.ToggleButton(name)
		button.set_active(True)
		button.connect('clicked',lambda x:x.set_active(True))
	    else:
		button=self.board_change(self.refer,current,name)
		#button.connect('clicked',lambda x:self.refer.set_board(current))
	    
	    self.path_items.pack_end(button,False)
	  current=current.parent_board
	#self.path_items.pack_end(gtk.Button(self.refer.current),False)

	self.path_items.show_all()
  class board_change(gtk.Button):
	refer=None

	def __init__(self,refer,board,name):
	  gtk.Button.__init__(self,name)
	  self.refer=refer
	  
	  self.connect('clicked',lambda x:self.refer.set_board(board))
	  
	  


class items_navigator(gtk.HBox):
  def __init__(self,ref):
	gtk.HBox.__init__(self)

	self.ref=ref

	editButton=gtk.ToggleButton('Edit')
	editButton.set_size_request(150,-1)
	editButton.modify_bg(gtk.STATE_NORMAL,gtk.gdk.Color(42321,40690,12487))
	editButton.modify_bg(gtk.STATE_ACTIVE,gtk.gdk.Color(42321,13732,13005))
	editButton.connect('clicked',self.set_edit)
	
	prevButton=gtk.Button()
	prevImage=gtk.Image()
	prevImage.set_from_file('/usr/soapbox/images/button_arrow_left.png')
	prevButton.set_image(prevImage)
	prevButton.set_sensitive(False)

	nextButton=gtk.Button()
	nextImage=gtk.Image()
	nextImage.set_from_file('/usr/soapbox/images/button_arrow_right.png')
	nextButton.set_image(nextImage)
	nextButton.set_sensitive(False)

	################
	#Appends
	self.pack_start(editButton,False)
	self.pack_end(nextButton,False)
	self.pack_end(prevButton,False)

  def set_edit(self,widget):
	self.ref.edit=widget.get_active()
	self.ref.current.load_table()
	self.ref.boards_navigator.set_sensitive(not self.ref.edit)

class pastelColours:
    tempColours=[]

    def get_colour(self):
    	if len(self.tempColours)==0:
	    self.tempColours=[ gtk.gdk.Color(40000,20000,20000),#Red
		gtk.gdk.Color(40000,20000,2000),#Orange
		gtk.gdk.Color(20000,37000,20000),#Green
		gtk.gdk.Color(22000,22000,30000),#Blue
		gtk.gdk.Color(10352,22343,38333),#Blue2
		gtk.gdk.Color(42321,40690,19487),#Yellow
		gtk.gdk.Color(33000,22000,33000),#Purple
		gtk.gdk.Color(30583,34952,39321),
		gtk.gdk.Color(42321,13732,13005),#Red2
		gtk.gdk.Color(39540,25063,32471),#Pink 
		gtk.gdk.Color(24624,39669,15789),#Green2
		gtk.gdk.Color(19540,40759,14966),#Green3
		gtk.gdk.Color(48314,35559,8862),#Orange2
		gtk.gdk.Color(36347,15286,45668)#Purple2
	]

	r=random.randrange(0,len(self.tempColours))
	colour=self.tempColours[r]
	
	self.tempColours.remove(colour)
	return colour

######################################################################################################
######################################################################################################

class outsBox(gtk.VBox):
    def __init__(self):
	gtk.VBox.__init__(self)
	catalogues=[
		{'artist':'System of a Down','track':'Lost in Hollywood','duration':'05:19','remain':'00:40'},
		{'artist':'Foo Fighters','track':'Best of You','duration':'04:15'},
		{'artist':'Korn','track':'Word Up!','duration':'03:40'},
		{'artist':'Weezer','track':'Beverly Hills','duration':'03:16'},
		{'artist':'Bed','track':'Comedy capers 1','duration':'02:20'},
	]
	catalogues=[
	  {'artist':'Sample artist','track':'Sample Track','duration':'2:20','remain':'00:00'}
	]
	i=1
	for catalogue in catalogues:
	    self.pack_start(self.outMain(i,catalogue),False)
	    i=i+1

    class outMain(gtk.EventBox):
	def __init__(self,number,catalogue):
	    gtk.EventBox.__init__(self)
	    #########################
	    # Title		    #
	    #########################
	    # Song Info		    #
	    #			    #
	    #			    #
	    #########################
	    #   #   #  REMAIN   #   #
	    #CUE#EJT#	    	#QUE#
	    #########################
	
 	    ################
	    # Boxes
   	    vBox=gtk.VBox()
	    topBox=gtk.HBox()
	    middleBox=gtk.VBox()
	    bottomBox=gtk.HBox()

	    vBox.pack_start(topBox,False)
	    vBox.pack_start(middleBox)
	    vBox.pack_end(bottomBox)
	    self.add(vBox)
	    ################

	    ################
	    # Title
	    title=gtk.EventBox()
	    title.add(gtk.Label('Catalogue '+str(number)))
	    ################

	    ################
	    # Main
	    artistBox=gtk.EventBox()

	    artistLabel=gtk.Label(catalogue['artist'])
            artistFont=pango.FontDescription()
	    artistFont.set_size(18*pango.SCALE)
	    artistLabel.modify_font(artistFont)
	    
	    artistBox.add(artistLabel)
	    middleBox.pack_start(artistBox,False)

	    trackDetails=gtk.HBox()
	    trackName=gtk.Label(catalogue['track'])
	    trackLength=gtk.Label(catalogue['duration'])
	    trackDetails.pack_start(trackName,False)
	    trackDetails.pack_end(trackLength,False)
	
	    middleBox.pack_start(trackDetails)
	
	    fillBox=gtk.EventBox()
	    middleBox.pack_end(fillBox)
	    ################
	
	    ################
	    # Buttons
	    buttonBox=gtk.HButtonBox()

	    playButton=gtk.ToggleButton()
	    try:
	        l=catalogue['remain']
		l='PLAY'
		playButton.modify_bg(gtk.STATE_ACTIVE,gtk.gdk.Color(19540,40759,14966))
		playButton.set_active(True)
		
	    except KeyError:
		l="CUE"
		playButton.modify_bg(gtk.STATE_NORMAL,gtk.gdk.Color(40000,20000,2000))
	    playButton.set_label(l)	    
	    playButton.set_size_request(-1,int(pango.SCALE/20))	    

	    playButtonFont=pango.FontDescription()
	    playButtonFont.set_size(20*pango.SCALE)	
	    playButton.modify_font(playButtonFont)

	    ejectButton=gtk.Button("Eject")
	    ejectButton.modify_bg(gtk.STATE_NORMAL,gtk.gdk.Color(40000,20000,20000))	
	    buttonBox.add(playButton)
    	    buttonBox.add(ejectButton)

	    queueButton=gtk.Button("QUEUE")	    	
	    ################

	    ################
	    # Timer
	    timerBox=gtk.EventBox()
	    timerBox.set_size_request(100,-1)

	    timerFont=pango.FontDescription()
	    timerFont.set_size(22*pango.SCALE)	
	    try:
	        l=catalogue['remain']
	    except KeyError:
		l=catalogue['duration']
	    timerLabel=gtk.Label(l)
	    timerLabel.modify_font(timerFont)

	    timerBox.add(timerLabel)

	    ################
	    # Appends
	    topBox.pack_start(title,False)
	    bottomBox.pack_start(buttonBox,False)
	    bottomBox.pack_start(timerBox)
	    bottomBox.pack_dysty(queueButton,False)
	    ################

######################################################################################################
######################################################################################################

class infoBox(gtk.EventBox):
    def __init__(self):
	gtk.EventBox.__init__(self)

	self.modify_bg(gtk.STATE_NORMAL,gtk.gdk.Color(60554,60554,60554))
	self.set_size_request(-1,int(pango.SCALE/6))
	vBox=gtk.VBox()
	
	titleHBox=gtk.HBox()
	title=gtk.Label("Information")
	titleFont=pango.FontDescription()
	titleFont.set_size(20*pango.SCALE)
	title.modify_font(titleFont)
	title.modify_fg(gtk.STATE_NORMAL,gtk.gdk.Color(10000,10000,10000))
	titleHBox.pack_start(title,False)


	vBox.pack_start(titleHBox,False)

	self.add(vBox)

