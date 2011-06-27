function update_radios(div)
{
    var div = document.getElementById(div);
    div.innerHTML = "<b>Loading...</b>";

    $.getJSON(
        "http://savonet.rastageeks.org/liqflows.py?fmt=json&cmd=radios",
        function(radios){
            div.innerHTML = "";
            if (radios.length == 0)
            {
                div.innerHTML += "<b>No registered radio is currently broadcasting!</b>";
                return;
            }
            content = "";
            content += "<ul>\n";
            line = '<li><div class="radio"><a href="WEBSITE" target="_blank">NAME</a> <span class="streams">[STREAMS]</span></div><div class="description">DESCRIPTION (GENRE)</div><div class="metadata">ARTIST &mdash; <span class="title">TITLE</span></div></li>';
            for (i=0; i < radios.length; i++)
            {
                r = radios[i];
                l = line;
                l = l.replace("NAME",r.name);
                l = l.replace("WEBSITE",r.website);
                l = l.replace("DESCRIPTION",r.description);
                l = l.replace("GENRE",r.genre);
                l = l.replace("ARTIST",r.artist);
                l = l.replace("TITLE",r.title);
                streams = "";
                for (j = 0; j < r.streams.length; j++)
                {
                    s = r.streams[j];
                    if (j != 0)
                        streams += " &ndash; ";
                    streams += '<a href="'+s.url+'">'+s.format+'</a>'
                }
                l = l.replace("STREAMS",streams);
                content += l + "\n";
            }
            content += "</ul>\n";
            div.innerHTML = content;
        }
    );
}