#!/usr/bin/python
#*****************************************************************************
#
#  Liquidsoap, a programmable audio stream generator.
#  Copyright 2003-2007 Savonet team
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details, fully stated in the COPYING
#  file at the root of the liquidsoap distribution.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
#*****************************************************************************

#*******************************************************************************
#
# SQLite Functions for storing our data
# (SQLITE VER > 2.4 Req)
#
#*******************************************************************************


import sys
sys.path.append("libs")
from odict import *
from types import *
from pysqlite2 import dbapi2 as sqlite

class db:
	def __init__(self,path=None):
		if path == None:
			self.defaultDB()
		else:
			self.connect(path)


		

	def defaultDB(self):
		self.connect('data/main.db')
		syntax = OrderedDict()
		syntax['constants'] = 'CREATE TABLE constants ( value INTEGER,'\
			'name VARCHAR(255) NOT NULL,'\
			'type VARCHAR(255) NOT NULL'\
			')'

		syntax['groups'] = 'CREATE TABLE groups ( group_id INTEGER PRIMARY KEY, '\
			'name VARCHAR(100) NOT NULL'\
			')'
		syntax['users'] = 'CREATE TABLE users ( user_id INTEGER PRIMARY KEY,'\
			'name VARCHAR(100) NOT NULL,'\
			'group_id INTEGER NOT NULL CONSTRAINT group_id REFERENCES groups(group_id) ON DELETE CASCADE,'\
			'realname VARCHAR(100),'\
			'email VARCHAR(100),'\
			'password VARCHAR(255)'\
			' ) '
		syntax['groupMembers'] = 'CREATE TABLE groupMembers ( groupMember_id INTEGER PRIMARY KEY,'\
			'group_id INTEGER NOT NULL CONSTRAINT group_id REFERENCES groups(group_id) ON DELETE CASCADE,'\
			'user_id INTEGER NOT NULL CONSTRAINT user_id REFERENCES users(user_id) ON DELETE CASCADE'\
			')'
		syntax['streams'] = 'CREATE TABLE streams ( stream_id INTEGER PRIMARY KEY,'\
			'host VARCHAR(100) NOT NULL,'\
			'port  INTEGER(5) NOT NULL,'\
			'name VARCHART(255),'\
			'enabled BOOLEAN NOT NULL DEFAULT TRUE'\
			')'
		syntax['playlists'] = 'CREATE TABLE playlists ( playlist_id INTEGER PRIMARY KEY,'\
			'owner_id INTEGER NOT NULL CONSTRAINT owner_id REFERENCES users(user_id) ON DELETE CASCADE,'\
			'group_id INTEGER NOT NULL CONSTRAINT group_id REFERENCES groups(group_id) ON DELETE CASCADE,'\
			'permission INTEGER(3) NOT NULL DEFAULT 755'\
			');'
		syntax['playlistItems'] = 'CREATE TABLE playlistItems (playlistItem_id INTEGER PRIMARY KEY,'\
			'playlist_id INTEGER NOT NULL CONSTRAINT playlist_id REFERENCES playlists(playlist_id) ON DELETE CASCADE,'\
			'file_id INTEGER NOT NULL CONSTRAINT file_id REFERENCES files(files_id) ON DELETE CASCADE'\
			')'		
#			'owner_id INTEGER NOT NULL CONSTRAINT owner_id REFERENCES users(user_id) ON DELETE CASCADE,'\
		syntax['soundBoards'] = 'CREATE TABLE soundBoards ( board_id INTEGER PRIMARY KEY,'\
			'name VARCHAR(100),'\
			'created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,'\
			'sortBy INTEGER(1) NOT NULL DEFAULT 0,'\
			'type INTEGER(1) NOT NULL DEFAULT 0'\
			')'
		syntax['boardItems'] = 'CREATE TABLE boardItems ( boardItem_id INTEGER PRIMARY KEY,'\
			'soundBoard_id INTEGER NOT NULL CONSTRAINT soundBoard_id REFERENCES soundBoards(soundBoard_id) ON DELETE CASCADE,'\
			'file_id INTEGER NOT NULL CONSTRAINT file_id REFERENCES files(files_id) ON DELETE CASCADE,'\
			'bgColour VARCHAR(12)'\
			')'
	#		'owner_id INTEGER NOT NULL CONSTRAINT owner_id REFERENCES users(user_id) ON DELETE CASCADE,'\
	#		'group_id INTEGER NOT NULL CONSTRAINT group_id REFERENCES groups(group_id) ON DELETE CASCADE,'\
		syntax['files'] =  'CREATE TABLE files ( file_id INTEGER PRIMARY KEY,'\
			'path VARCHAR(255) NOT NULL,'\
			'filename VARCHAR(255) NOT NULL,'\
			'name VARCHAR(255) NOT NULL,'\
			'permission INTEGER(3) NOT NULL DEFAULT 755,'\
			'created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,'\
			'modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP'\
			')'
		syntax['mysqlServers'] = 'CREATE TABLE mysqlServers ( server_id INTEGER PRIMARY KEY,'\
			'host VARCHAR(255) NOT NULL,'\
			'port INT(6) NOT NULL DEFAULT 3306,'\
			'username VARCHAR(255) NOT NULL,'\
			'password VARCHART(255)'\
			')'
		syntax['txtMessages'] = 'CREATE TABLE txtMessages ( message_id INTEGER PRIMARY KEY,'\
			'name VARCHAR(255),'\
			'message VARCHAR(255) NOT NULL,'\
			'source INT(1) NOT NULL'\
			')'
		self.syntax=syntax
		self.tableCheck()	

	def select(self,table,select="*",where=None,order=None):
		sql="SELECT "+select+" FROM "+table
		if where!=None:
			sql+=" WHERE "+where
		if order!=None:
			sql+=" ORDER BY "+order
		
		self.cursor.execute(sql)
		results=[]

		columns=[]


		for col in self.cursor.description:	
			columns.append(col[0])
		
		for result in self.cursor:
			row = {}
			for col in columns:
				row[col]=result[columns.index(col)]
			results.append(row)
			
		return results

	def last_insert(self):
		sql="SELECT last_insert_rowid()"
		self.cursor.execute(sql)
		
		
		for result in self.cursor:
			return result[0]
	

	def insert(self,table,data,fromVar=None):
		sql='INSERT INTO '+table+' '
		fields = []
		values = []
		for field in data:
			fields.append(field)	
			values.append(str(data[field]))

		sql+='('		
		for i in range(len(fields)):
			sql+=fields[i]
			if i+1 != len(fields):
				sql+=","			
		sql+=') '
		
		

		if fromVar!=None:
			for i in range(len(values)):
				sql+=values[i]
				if i+1 != len(values):
					sql+=","

			sql+=" from "+fromVar		
		else:
			sql+='VALUES (	'	
			for i in range(len(values)):
				sql+="'"+values[i]+"'"
				if i+1 != len(values):
					sql+=","			
			sql+=');'
		self.cursor.execute(sql)	
		self.connection.commit()

	def update(self,table,data,where):
		if len(where)==0: 
			return		

		sql='UPDATE '+table+' SET '
		
		i=0
		for field in data:
			sql+=field+' = "'+str(data[field])+'" '
			if i+1 != len(data):
					sql+="," 
			i+=1
		sql+=' WHERE '+where+";"		

		self.cursor.execute(sql)	
		self.connection.commit()	

	def remove(self,table,where):
		sql='DELETE FROM '+table+' WHERE '+where
		self.cursor.execute(sql)
		self.connection.commit()		

	def connect(self,path):
		self.connection = sqlite.connect(path)
		self.cursor = self.connection.cursor()

	def tableCheck(self):
		tableNames = self.select("sqlite_master","name")

		tempTables=[]
		for table in tableNames:	
			tempTables.append(table["name"])
		tableNames = tempTables

		for table in self.syntax:
			if not table in tableNames:
				self.createTable(table)
		
	
	def disconnect(self):
		self.cursor.close()
		self.connection.close()

	def createTables(self):
		for table in self.syntax:
			if type(self.syntax[table]) is DictType:
				fKeySyntax = self.syntax[table]
				for dictTable in fKeySyntax:
					self.cursor.execute(fKeySyntax[dictTable])
			else:
				self.cursor.execute(self.syntax[table])
		self.connection.commit()
			
	def createTable(self,table):
		self.cursor.execute(self.syntax[table])	
		self.connection.commit()

	def dropTables(self):
		for table in self.syntax:
			self.cursor.execute('DROP TABLE '+table)
		self.connection.commit()

	
		
	
