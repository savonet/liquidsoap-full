# Our custom authentication
# Note: the ICY protocol 
# does not have any username and for 
# icecast, it is "source" most of the time
# thus, we discard it
def harbor_auth(port,_,password) = 
  # Alice connects on port 9000 between 20h and 21h
  # with password "rabbit"
  (port == 9000 and 20h-21h and password == "rabbit")
    or
  # Bob connection on port 7000 between 18h and 20h
  # with password "foo"
  (port == 7000 and 18h-20h and password == "foo")
end
