KUBE Radio
==========
Keele University Broadcasting Enterprise (KUBE) is an award winning student run radio station based at Keele University in Staffordshire, UK.

Production script
=================
```
#!/usr/bin/liquidsoap
#                    .                                       
#     .  ....   ~DMMMM$ .                                    
#     8MMMMMMMMMMMMMMMMMMMD. ..                              
#  .MMMMMMMMMMMMMMMMMMMMMMMMMM~ ..                           
# ..$MMMMMMMMMMMMMMMMMMMMMMMMM88M.                           
#  . MMMMM$MMMMMMMMMMMM?MMMMMMMMM                            
#   .MMMMMMM$MMM$MMMMMMMMMMMMMMM8.                           
#   .MMMMMMMMMMMMMMMMMMMMMMMMMMM?...  . ..   ...  ... . . .  
#    MMMMMMMMMMMMMMMMM. MMMM:~MM.D$   .MM..888M$ ..88D8888.  
#    MMMMMMMM8MMMMMMMM  MM$.MMMM.M$   .MM..M.. ~M. MM  .  .. 
#   .MMMMMMMM$MMMMMMMM. M .MMMMM M?.   MM..M. . M. MM.       
#    ~MMMMMMM$MMMMMMMM.. MMMMMMM.M?.  .MM .MMMMM:  MMMMMMM.. 
#   ..MMMMMMM$MMMMMMMM. M.?MMMMM.M$.   MM..M .. M8.MM .    . 
#     MMMMMMM$MMMMMMMM .MM  MMM$ MM..  M8  M.  .$M.MM.   .   
#   ...MMMMMM$MMMMMMMM  MMM. MM . MM ~MM. .M$$8MM .MM88888.  
#       MMMMM8MMMMMMMMMMMMMMMMM..   ~~ ..... . ..   .     .  
#       .~MMMMMMMMMMMMMMMMMM$ .       . . .     . .     ..   
#         .MMMMMMMMMMMMMM..                                  
#           MMMMMMMMM ....                                   
#          ..MMM?....                                        
#           . ...                                            
#
#       KUBERadio.com
set("log.file.path","/home/liquidsoap/logs/main.log")
set("frame.size",4704)

################
# Sources
studioInput = input.alsa(id="studioInput",bufferize=false)
sustainList = playlist("/home/kube/kube-music/sustain/play.m3u")
###############

################
# KUBE Settings
kubeHost="localhost"
kubePort=8000
kubeUser="source"
kubePassword="OMITTED FOR SECURITY"
kubeGenre="Student radio"
kubeUrl="kuberadio.com"
kubeDesc="Keele University student radio"
#################

studioInput=rewrite_metadata([("artist", "KUBE Radio"),
                        ("title","LIVE Stream,TEXT the studio from kuberadio.com OR TXT KUBE followed by your message to 60300")],studioInput)



#################
# Processing
sustain = nrj(sustainList)

radio = fallback.skip(strip_blank(threshold=-35.,length=15.,studioInput),sustain)
radio=mksafe(radio)

################

#################
# ICECAST MOUNTS
output.icecast(%mp3,radio,mount="kube",id="kubeMP3",name="KUBE Radio HIGH bandwidth",quality=8,bitrate=128,
                    host=kubeHost,port=kubePort,user=kubeUser,password=kubePassword,genre=kubeGenre,url=kubeUrl,description=kubeDesc)
output.icecast(%mp3,radio,mount="kube-low",id="kubeMP3Low",name="KUBE Radio LOW bandwidth",quality=5,bitrate=64,
                host=kubeHost,port=kubePort,user=kubeUser,password=kubePassword,genre=kubeGenre,url=kubeUrl,description=kubeDesc)
output.icecast(%vorbis, radio,mount="kube-low.ogg",id="kubeOggLow",name="KUBE Radio LOW bandwidth",quality=2.,
                    host=kubeHost,port=kubePort,user=kubeUser,password=kubePassword,genre=kubeGenre,url=kubeUrl,description=kubeDesc)
output.icecast(%vorbis, radio,mount="kube.ogg",id="kubeOggHigh",name="KUBE Radio HIGH bandwidth",quality=8.,
                    host=kubeHost,port=kubePort,user=kubeUser,password=kubePassword,genre=kubeGenre,url=kubeUrl,description=kubeDesc)
output.icecast(%vorbis, radio,mount="kube-archive.ogg",id="kubeOggLow",name="KUBE Radio Archive stream",quality=10.,public=false,
                    host=kubeHost,port=kubePort,user=kubeUser,password=kubePassword,genre=kubeGenre,url=kubeUrl,description=kubeDesc)
#################

output.alsa(id="officeOutput",bufferize=false,device="hw:0")
```

Development script
==================
```
#!/usr/bin/liquidsoap
# KUBERadio.com script

set("frame.size",4704)
set("log.file.path","/home/liquidsoap/new/log/kube.log")


###########################################
# SOURCES
jingle = single("/home/liquidsoap/new/media/jingles/main.mp3")
news = single("/home/liquidsoap/new/media/news/news-01.mp3")
jingleTop=single("/home/liquidsoap/new/media/jingles/top/week1.mp3")
advertFirst=single("/home/liquidsoap/new/media/adverts/firstBuses.mp3")
sustainList = playlist("/home/kube/kube-music/sustain/play.m3u")
input=input.alsa(bufferize=false)
input=rewrite_metadata([("artist","KUBE Radio"),
                            ("title","LIVE Stream"),
                        ("comment","http://kuberadio.com")],input)
news=rewrite_metadata([
                    ("artist","KUBE Radio"),
                    ("title","NEWS")
                    ],news)
topOfTheHour=sequence(merge=true,[
                            news,
                            advertFirst,
                            jingleTop
                    ])
sustain=sequence(merge=true,[
                        jingle,
                        sustainList
                ])
####


###########################################
# PROCESSING
topOfTheHour=smart_crossfade(fade_out=0.5,fade_in=0.5,topOfTheHour)
sustain=nrj(sustain)
#####

##########################################
# TRIGGERS

def isTopOfHour ()
            if 59m30s then
                    system("date >> /home/liquidsoap/new/triggers/topOfHour")
                    true
            else
                    false
            end
end

##########################################

inputTrigger=input
sustainTrigger=sustain


main=fallback.skip(
        strip_blank(threshold=-35.,length=15.,inputTrigger),
                sustainTrigger
)

def getTop()
        add([
        sequence(merge=true,
                [
                        blank(duration=30.),
                        topOfTheHour
                ]       
        )])
end

altSw=switch(track_sensitive=true,[(isTopOfHour,getTop())])
radio = fallback.skip(
                        strip_blank(threshold=-35.,length=0.2,altSw)
                        ,main)
radio = mksafe(radio)
##Outputs omitted for security
```


