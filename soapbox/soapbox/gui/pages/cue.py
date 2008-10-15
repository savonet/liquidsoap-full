from soapbox import widgets
from soapbox.gui.pages import page

class cue(page.page):
    def __init__(self):
	page.page.__init__(self,'CUE')
	self.add(widgets.library.__init__())
