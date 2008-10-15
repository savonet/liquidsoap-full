import gtk
from soapbox import gui
from soapbox.widgets import settings
from soapbox.gui import library
#odict

class mainMenu(gtk.EventBox):
    ui = '''<ui>
    <menubar name="MenuBar">
      <menu action="File">
        <menuitem action="Quit"/>
      </menu>
      <menu action="Tools">
	<menuitem action="library"/>
	<menuitem action="users_groups"/>
	
	<menuitem action="settings"/>
      </menu>
    </menubar>
    </ui>'''
    def __init__(self,sb):
	self.sb=sb
	gtk.EventBox.__init__(self)
	uimanager = gtk.UIManager()
	uimanager.add_ui_from_string(self.ui)
	actiongroup = gtk.ActionGroup('')
        actiongroup = actiongroup
	uimanager.insert_action_group(actiongroup, 0)

        # Create actions
        actiongroup.add_actions([('Quit', gtk.STOCK_QUIT, '_Quit', None,
                                  'Quit the Program', None),
				 ('library',None, '_Library settings', None, None,lambda x:library.library_settings(self.sb)),
				 ('users_groups',None, '_Users/Groups', None, None,lambda x:usersgroupsSettings(self.db)),
				 ('settings',None, '_Settings', None, None,lambda x:settings.content()),
                                 ('File', None, '_File'),
				 ('Tools', None, '_Tools')
				])

	menubar = uimanager.get_widget('/MenuBar')
	self.add(menubar)

class quickMenu(gtk.Notebook):
    def __init__(self,pages):
	gtk.Notebook.__init__(self)
	self.set_tab_pos(gtk.POS_LEFT)
	for item in pages:
	    page=pages[item]
	    label=gtk.Label(page.label)
	    label.set_size_request(100,60)
	    self.append_page(page,label)

