#!/usr/bin/python

import threads

def __init__(*args):
  return ClientThreadManager(*args)

class ClientThreadManager:
    def __init__(self,port, maxConcurrentThreads):
	self.port=port
        self.maxConcurrentThreads = maxConcurrentThreads
        self.threads = {}
	self.threads={}
	self.pendingThreads=[]
	self.watcher=None
	self.commands={}

    def _register_thread_completed(self, thread):
	name=thread.getName()
        self.stop_thread(thread.getName())
        running = len(self.threads) - len(self.pendingThreads)

        if running < self.maxConcurrentThreads:
            try:
                args = self.pendingThreads.pop()
                self.threads[args].start()
            except IndexError: pass

    def register_thread(self,thread):
	running = len(self.threads) - len(self.pendingThreads)
	self.threads[thread.getName()]=thread
	if running < self.maxConcurrentThreads:
		thread.start()
	else:
		self.pendingThreads.append(thread.getName())

    def stop_thread(self,name,block=False):
	if name not in self.threads:
	    return
	thread=self.threads[name]
	thread.cancel()
	if block:
	    if thread.isAlive():
		thread.join()

	del self.threads[name]	

    def stop_all_threads(self, block=False):
        for thread in self.threads.values():
	    thread.cancel()
            if block:
            	if thread.isAlive():
       	    	    thread.join()

    ##############
    #
    def null_callback(self,sender,*args):
	None

    def make_command_thread(self,s):	
	if s not in self.commands:
		thread = threads._commandThread(self.port,s)
		self.commands[s]=thread.getName()
		thread.connect("completed",self._register_command_thread_completed)
		self.register_thread(thread)

    def make_response_thread(self,s,re,answerCb):
	thread=threads._responseThread(self.port,s,re)
	thread.connect("answer",answerCb)
	thread.connect("completed",self._register_thread_completed)
	self.register_thread(thread)

    def make_debug_response_thread(self,s,re,answerCb):
	thread=threads._debug_responseThread(self.port,s,re)
	thread.connect("answer",answerCb)
	thread.connect("completed",self._register_thread_completed)
	self.register_thread(thread)

    def make_countdown_thread(self,t,statusCb,warningCb):
#	self.make_response_thread(s,re,self.
	thread=threads._countdownThread(t)
	thread.connect("status",statusCb)
	thread.connect("warning",warningCb)
	thread.connect("completed",self._register_thread_completed)
	self.register_thread(thread)
	return thread

    def get_watcher(self):
	if not self.watcher:
	    self.watcher=w=threads._watcherThread(self.port)
	    w.connect("connectionError",self.stop_watcher)
	    self.register_thread(w)
	return self.watcher

    def stop_watcher(self,sender,*args):
	if not self.watcher: #Already stopped
		return
	w=self.watcher
	w.stop_watchers()
	self._register_thread_completed(w)
	self.watcher=None

    def make_metaWatcher_thread(self, statusCb, errorCb, emptyCb, source):	
	w=self.get_watcher()
	metaWatcher=threads._metaWatcher(source)
	metaWatcher.connect("status",statusCb)
	metaWatcher.connect("stopped",errorCb)
	metaWatcher.connect("emptyQueue",emptyCb)
	w.register_watcher(metaWatcher,source,"metadata")

    def stop_metaWatcher_thread(self,source,block=False):
	if self.watcher:
		self.watcher.delete_watcher(source,"metadata")

    def make_commandWatcher(self,s,answerCb,errorCb,re):
	w=self.get_watcher()
	c=threads._commandWatcher(s,re)
	c.connect("answer",answerCb)
	c.connect("stopped",errorCb)
	w.register_watcher(c,'nosource',s+re)


    def _register_command_thread_completed(self,thread):
	self._register_thread_completed(thread)
	try:
	    del self.commands[thread.s]
	except KeyError: pass

    #
    ##############
