var search_showed = false;
function show_search()
{
    if (search_showed)
        return;
    var search = document.getElementById("search_btn");
    var form = '<form action="//liquidsoap.info/search.html" id="cse-search-box"> \
<div> \
<input type="hidden" name="cx" value="partner-pub-4393423157723487:7k03ha-nv9n" /> \
<input type="hidden" name="cof" value="FORID:10" /> \
<input type="hidden" name="ie" value="UTF-8" /> \
<input type="text" name="q" size="25" /> \
<input type="submit" name="sa" value="Search" /> \
</div> \
</form>';
    search.innerHTML=form;
    search_showed = true;
}

var menu = document.getElementsByClassName("menu")[0].getElementsByTagName("ul")[0];
menu.innerHTML = '<li id="search_btn"><a href="#" onclick="show_search()">search</a></li>' + menu.innerHTML;
