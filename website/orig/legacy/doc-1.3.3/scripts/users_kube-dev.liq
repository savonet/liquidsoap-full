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
