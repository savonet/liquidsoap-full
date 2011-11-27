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
        "http://savonet-flows.herokuapp.com/?fmt=json&cmd=radios",
        function(radios){
            if (radios.length == 0)
            {
                div.innerHTML = "<b>No registered radio currently broadcasting!</b>";
                return;
            }
            clear_markers();
            content = "";
            content += "<ul>\n";
            line = '<li><div class="radio"><a href="WEBSITE" target="_blank">NAME</a> <span class="streams">STREAMS</span></div><div class="genre">GENRE</div><div class="description">DESCRIPTION</div><div class="metadata" id="metadata-ID">METADATA</div></li>';
            for (i=0; i < radios.length; i++)
            {
                r = radios[i];
                l = line;
                l = l.replace("NAME",r.name);
                l = l.replace("WEBSITE",r.website);
                l = l.replace("DESCRIPTION",r.description);
                l = l.replace("GENRE",r.genre);
                l = l.replace("ID",r.id);
                function get_meta(r) {
                  var metadata = "";
                  if (r.artist != null)
                  {
                      metadata += r.artist;
                      metadata += " ";
                      if (r.title != null)
                          metadata += "&mdash; ";
                  }
                  if (r.title != null)
                      metadata += '<span class="title">'+r.title+'</span>';

                  return metadata;
                }
                l = l.replace("METADATA",get_meta(r));
                var socket = io.connect("http://savonet-flows-socket.herokuapp.com/");
                socket.emit('join',"" + r.id);
                socket.on("" + r.id, function (data) {
                  var r = JSON.parse(data);
                  if (r.cmd === "metadata") {
                    $("#metadata-" + r.data.id).html(get_meta(r.data));
                  }
                });
                streams = "";
                for (j = 0; j < r.streams.length; j++)
                {
                    s = r.streams[j];
                    var mime = getMime(s.format);
                    streams += '<div class="stream">';
                    if (soundManager.canPlayMIME(mime) || soundManager.canPlayURL(s.url)) {
                      streams += '<a href="' + s.url + '" type="' + mime + '" class="sm2_button"></a><br/>';
                    }
                    streams += '<a href="'+s.url+'">'+s.format+'</a>';
                    streams += '</div>';
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
        }
    );
}
