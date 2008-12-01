from soapbox.gui.pages import page
from soapbox.gui import jingles

class jingles(page.page):
    def __init__(self):
	page.page.__init__(self,'Jingles')
	self.add(jingles.jingles())
