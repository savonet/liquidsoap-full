function update_radios(div)
{
    var div = document.getElementById(div);
    div.innerHTML = "<b>Loading...</b>";

    $.getJSON(
        "http://savonet.rastageeks.org/liqflows.py?fmt=json&cmd=radios",
        function(radios){
            div.innerHTML = "";
            content = "";
            content += "<table>\n";
            content += "<tr><th>Radio</th><th>Description</th><th>Artist</th><th>Title</th><th>Streams</th></tr>\n";
            line = '<tr><td><a href="WEBSITE">NAME</a></td><td>DESCRIPTION (GENRE)</td><td>ARTIST</td><td>TITLE</td><td>STREAMS</td></tr>';
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
                        streams += " -- ";
                    streams += '<a href="'+s.url+'">'+s.format+'</a>'
                }
                l = l.replace("STREAMS",streams);
                content += l + "\n";
            }
            content += "</table>\n";
            div.innerHTML = content;
        }
    );
}