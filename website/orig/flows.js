var map = null;
var infowindow = null;
var map_markers = [];

function clear_markers()
{
    for (i=0; i<map_markers.length; i++)
        map_markers[i].setMap(null);
    map_markers = [];
}

function getMime(format) {
    var first = format.split("/").shift().toLowerCase();
    if (first === "mp3") {
      return "audio/mp3";
    } else if (first === "ogg") {
      return "application/ogg";
    } else if ((first === "aac") || (first === "aacplus") || (first === "he-aac") || (first === "aac+")) {
      return "audio/aac";
    } else {
      return "";
    }
}

function update_radios(div)
{
    var div = document.getElementById(div);

    var latlng = new google.maps.LatLng(48.86, 2.33);
    var options = {
        zoom: 1,
        center: latlng,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        streetViewControl: false,
        mapTypeControl: false
    };
    if (!infowindow) infowindow = new google.maps.InfoWindow({disableAutoPan: true, content: "Content..."});
    if (!map) map = new google.maps.Map(document.getElementById('map'), options);

    $.getJSON(
        "http://flows.liquidsoap.fm/radios",
        function(radios){
            if (radios.length == 0)
            {
                div.innerHTML = "<b>No registered radio currently broadcasting!</b>";
                return;
            }
            clear_markers();
            content = "<ul>\n";
            line = '<li><table border="0"><tr><td class="info"><div class="name"><a href="WEBSITE" target="_blank">NAME</a></div><div class="genre">GENRE</div><div class="description">DESCRIPTION</div><div class="metadata" id="metadata-TOKEN">METADATA</div></td><td class="streams"><ul>STREAMS</ul></td></tr></table></li>';
            for (i=0; i < radios.length; i++) {
                r = radios[i];
                if (r.streams.length == 0)
                  continue;
                l = line;
                l = l.replace("NAME",r.name);
                l = l.replace("WEBSITE",r.website);
                var descr = r.description;
                if (!descr) { descr = ""; }
                l = l.replace("DESCRIPTION",descr);
                var genre = r.genre;
                if (!genre) { genre = ""; }
                l = l.replace("GENRE",genre);
                l = l.replace("TOKEN",r.token);
                function get_meta(r) {
                  var metadata = "";
                  if (r.artist)
                  {
                      metadata += r.artist;
                      metadata += " ";
                      if (r.title != null)
                          metadata += "&mdash; ";
                  }
                  if (r.title)
                      metadata += '<span class="title">'+r.title+'</span>';

                  return metadata;
                }
                l = l.replace("METADATA",get_meta(r));
                streams = '';
                for (j = 0; j < r.streams.length; j++)
                {
                    streams += '<li>';
                    s = r.streams[j];
                    var url = 'http://flows.liquidsoap.fm/radio/' + r.token + '/' + s.format;
                    var mime = getMime(s.format);
                    var link = '<a href="' + url + '" type="' + mime + '">' + s.format + '</a>';
                    var player_link = '<a href="' + url + '" type="' + mime + '" class="sm2_button"></a>';
                    if (soundManager.canPlayLink($(link).get(0)) && mime != "audio/aac") {
                      streams += player_link;
                    }
                    streams += link;
                    streams += '</li>';
                }
                l = l.replace("STREAMS",streams);
                content += l + "\n";
                if ((r.latitude != null) && (r.longitude != null))
                {
                    c = '<b><a href="WEBSITE" target="_blank" style="text-decoration: none">NAME</a></b><br/>DESCRIPTION';
                    c = c.replace("NAME",r.name);
                    c = c.replace("WEBSITE",r.website);
                    c = c.replace("DESCRIPTION",r.description);
                    marker = new google.maps.Marker({
			position: new google.maps.LatLng(r.latitude, r.longitude),
			map: map,
			title: r.name,
                        content: c
		    });
                    map_markers.push(marker);
                    google.maps.event.addListener(marker, 'click', function(){
                        infowindow.setContent(this.content);
                        infowindow.open(map, this);
                    });
                }
            }
            content += "</ul>\n";
            div.innerHTML = content;
            
            // Setup notifications
            var socket = io.connect("http://flows.liquidsoap.fm/");
            socket.emit("join","flows");
            socket.on("flows", function (r) {
              if (r.cmd === "metadata") {
                var el = $("#metadata-" + r.radio.token);
                 el.fadeOut("slow", function () {
                   el.html(get_meta(r.radio));
                   el.fadeIn("slow");
                 });
              }
            });
        }
    );
}
