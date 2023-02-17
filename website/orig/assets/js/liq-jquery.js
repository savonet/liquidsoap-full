/* -*- Mode: javascript; js-indent-level : 2  -*- */

/* Enhance reference presentation. */
function enhanceRef(ref) {
  /* Operators */
  var operators = ref.parent().find('h3');
  /* Autocompletion source. */
  var source = [];
  /* Fill the list. */
  operators.each(function () {
    var link = $(this);
    var name = link.text();
    var id = link.attr("id");
    source.push({label: name, value: id});
  });
  /* Construct the search box. */
  var search = $("<p><div id=\"liq-div-search\">\
                  <label for=\"liq-search\">Search: </label>\
                  <input id=\"liq-search\"/>\
                  </div></p>");
  search.find("#liq-search").autocomplete({
    source: source,
    select: function( event, ui ) {
      window.location.href = "#"+ui.item.value;
    }
  });
  /* Add the search box. */
  ref.nextAll("ul").first().before(search);
}

$(document).ready(function () {
  // Add the search box to the API reference
  var ref = $("h1:contains('Liquidsoap scripting language reference')");
  if (ref.length > 0) {
    enhanceRef(ref);
  }

  // Add all versions to dropdown
  var versions = $("#liq-version").data("versions").trim().split(/\n+|\s+/);
  var currentVersion = $("#liq-version").data("version");
  jQuery.each(versions, function (idx, version) {
    var el = $("<a class='dropdown-item' href='/doc-" + version + "'>" + version + "</a>");
    if (currentVersion === version) el.addClass("active");
    $("#liq-versions").prepend(el);
  });
});

