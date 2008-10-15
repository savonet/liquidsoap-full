#!/usr/bin/env python
from distutils.core import setup


import sys,os
from distutils.fancy_getopt import getopt
#print getopt.getopt(sys.argv[1:],   "", ["prefix="])
opts,args = getopt.getopt(sys.argv[2:],"",["prefix="])
try:
  prefix=opts[0][1]+'/'
except IndexError:
  prefix="/usr/"


soapbox_bin='#!/bin/bash'\
	+'\nexport PYTHONPATH='+prefix+'/lib/python2.5/site-packages/'\
	+'\nGTK2_RC_FILES='+prefix+'/soapbox/gtk/gtkrc python '+prefix+'bin/sbox.py'
f=open('bin/soapbox','w')
f.write(soapbox_bin)
f.close()
os.chmod('bin/soapbox',0755)



#sys.exit()
setup(	name='Soapbox',
	version='0.001',
	description='',
	author='Peter Brooks',
	author_email='theneb@users.sourceforge.net',
	url='http://savonet.sourceforge.net',

	packages=['soapbox','soapbox.liquidsoap',
			'soapbox.gui','soapbox.gui.pages','soapbox.widgets','xl','xl.metadata'],
	scripts=['sbox.py'],
	data_files=[
		('bin',['bin/soapbox']),
		('soapbox/gtk',['gtk/gtkrc']),
		('soapbox/images',['images/button_arrow_left.png','images/button_arrow_right.png','images/button_home.png','images/button_soundBoard.png']),
	]

)
