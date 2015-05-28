function selectSearch(event,ui) {
  if (ui.item) {
    var id = ui.item.value.replace(/[^\w]/g,"_");
    var op = $("#" + id);
    var doc = op.next().clone().css('display','none');
    var header = $("<div id=\"liq-search-header\">\
                    <h4>" + op.text() + "\
                    <a href=\"#\" class=\"liq-search-hide\">(hide)</a>\
                    </h4></div>")
                 .css('display','none');
    var target = $('#liq-search-result');
    target.empty().append(header).append(doc);
    document.location.hash = id;
    target.children().fadeIn("fast");
    header.find("a").click(function () {
      target.children().fadeOut("fast");
      document.location.hash = "";
      return false;
    });
  }
}

function searchBox(source) {
  var search = $("<div id=\"liq-div-search\">\
                  <label for=\"liq-search\">Search: </label>\
                  <input id=\"liq-search\"/>\
                  </div>\
                  <div id=\"liq-search-result\"></div>");
  search.filter("#liq-search").css('display','none');
  search.find("#liq-search")
        .autocomplete({ source: source,
                        select: selectSearch });
  return search;
}

/* Enhance reference presentation. */
function enhanceRef (ref) {
  /* Find all links that have attribute "name" */
  var links = ref.parent().find('h3').find('a[name]');
  /* Hidding is expensive, therefore we store
   * all object to be hidden and hid them at once.. */
  var hide = [];
  /* List all operator names. */
  var op_names = [];
  /* For each of them, detach them and move 
   * them to their counter part. */
  links.each(function () {
    var link = $(this);
    /* Move up and get all siblings until a 
     * h3 is found.. */
    var content = link.parent().nextUntil("h3,#footer");
    /* Find target. */
    var anchor = link.attr("name");
    var target = $("a[href=#" + anchor + "]");
    target.attr("id",anchor);
    /* Initiate a list. */
    var section = $("<ul class=\"liq-api-sec\"></ul>");
    /* Hide section */
    hide.push(section);
    /* Add click action. */
    var open = false;
    var complete = function () {
      if (open) {
        document.location.hash = "";
      } else {
        document.location.hash = anchor;
      }
      open = !open;
    };
    target.click(function () {
      section.fadeToggle({duration: "fast", complete: complete});
      return false;
    });
    /* Append section. */
    target.after(section);
    /* Remove link. */
    link.parent().remove();
    /* Find each operator. */
    var operators = content.filter("h5");
    /* For each of them do the following. */
    operators.each(function () {
      var elem = $(this);
      /* Get text content. */
      var text = elem.text();
      /* Add in op_names. */
      op_names.push(text);
      /* Initiate a link. */
      var id = text.replace(/[^\w]/g,"_");
      var link = $("<a href=\"#" + id + "\" id=\"" + id + "\">" + text + "</a>");
      /* Get all elements until next
       * operator. */
      var doc = elem.nextUntil("h5,h3,#footer");
      /* Move doc to section. */
      var li = $("<li class=\"liq-api-elem\"></li>");
      var div = $("<div class=\"liq-api-content\"></div>");
      div.append(doc.detach());
      li.append(link).append(div);
      section.append(li);
      /* Hide doc. */
      hide.push(div);
      /* Toggle showing on links on click. */
      var open;
      var complete = function () {
          if (open) {
            document.location.hash = "";
          } else {
            document.location.hash = id;
          }
          open = !open;
      };
      link.click(function () {
        div.fadeToggle({complete: complete});
        return false;
      });
      /* Remove elem. */
      elem.remove();
    });
  });

  /* Add a search box. */
  ref.nextAll("ul").before(searchBox(op_names));

  /* Hide elements. */
  jQuery.each(hide,function (index,elem) {
    elem.css('display', 'none');
  });
}

function enhanceSettings(root) {
  /* Hidding is expensive, therefore we store
   * all object to be hidden and hid them at once.. */
  var hide = [];
  /* List all settings. */
  var set_names = [];
  /* Initiate a list. */
  var doc = $("<ul></ul>");
  /* Find all subsequent h3. */
  var sections = root.nextAll("h3");
  /* Move them into the new list. */
  sections.each(function () {
    var elem = $(this);
    var section = $("<ul></ul>");
    var part = elem.nextUntil("h3,#footer").filter("h4");
    if (part.length > 0) {
      part.each(function () {
        var elem = $(this);
        var text = elem.text();
        set_names.push(text);
        var id = text.replace(/[^\w]/g,"_");
        var link = $("<a href=\"#\" id=\"" + id + "\">" + text + "</a>");
        var content = elem.nextUntil("h4,h3,#footer");
        var div = $("<div class=\"liq-setings-content\"></div>");
        div.append(content.detach());
        hide.push(div);
        link.click(function () { 
          div.fadeToggle("fast");
          return false;
        });
        var li = $("<li></li>");
        li.append(link).append(div);
        section.append(li);
        elem.remove();
      });
      hide.push(section);
      var text = elem.text();
      var link = $("<a href=\"#\">" + text + "</a>");
      link.click(function () {
        section.fadeToggle("fast");
        return false;
      });
      var li = $("<li></li>");
      li.append(link).append(section);
      doc.append(li);
    }
    elem.remove();
  });
  root.after(doc);
  doc.before(searchBox(set_names));
  jQuery.each(hide,function (index,elem) {
    elem.css('display', 'none');
  });
}

function enhanceFaq(root) {
  var hide = [];
  var set_names = [];
  var doc = $("<ul></ul>");
  var sections = root.nextAll("h4");
  sections.each(function () {
    var elem = $(this);
    var section = $("<ul></ul>");
    var part = elem.nextUntil("h4,#footer").filter("h5");
    if (part.length > 0) {
      part.each(function () {
        var elem = $(this);
        var text = elem.text();
        set_names.push(text);
        var id = text.replace(/[^\w]/g,"_");
        var link = $("<a href=\"#\" id=\"" + id + "\">" + text + "</a>");
        var content = elem.nextUntil("h5,h4,#footer");
        var div = $("<div class=\"liq-faq-content\"></div>");
        div.append(content.detach());
        hide.push(div);
        link.click(function () {
          // Now THAT's a winner!
          var ui = {};
          ui.item = {};
          ui.item.value = text ;
          selectSearch('click', ui); 
          return false;
        });
        var li = $("<li></li>");
        li.append(link).append(div);
        section.append(li);
        elem.remove();
      });
      hide.push(section);
      var text = elem.text();
      var link = $("<a href=\"#\">" + text + "</a>");
      link.click(function () {
        section.fadeToggle("fast");
        return false;
      });
      var li = $("<li></li>");
      li.append(link).append(section);
      doc.append(li);
    }
    elem.remove();
  });
  root.after(doc);
  doc.before(searchBox(set_names));
  jQuery.each(hide,function (index,elem) {
    elem.css('display', 'none');
  });
}

function enhanceDownloads(ref) { 
  var list = ref.siblings('ul').first();
  list.children().each(function (id,el) {
    var link = $(el).children();
    var name = link.attr('href').replace(/^#/,'');
    var target = $('a:[name="' + name + '"]'); 
    var hide_link = $('<a class="liq-search-hide" href="#">(hide)</a>');
    target.after(hide_link);

    var content = target.parent().nextUntil('h3,#footer').andSelf();
    content.hide();
    link.click(function () {
      var content = target.parent().nextUntil('h3,#footer').andSelf();
      content.fadeToggle('slow');
      $('html, body').animate({ scrollTop: target.offset().top }, 500); 
      return false;
    });

    hide_link.click(function () {
      var content = target.parent().nextUntil('h3,#footer').andSelf();
      content.fadeOut('slow');
      $('html, body').animate({ scrollTop: $('body').offset().top }, 500);
      return false;
    });
  });
}

$(document).ready(function () {
  var ref = $("h2:contains('Liquidsoap scripting language reference')");
  if (ref.length > 0) {
    enhanceRef(ref);
  }
  var root = $("h2:contains('Liquidsoap configuration')");
  if (root.length > 0) {
    enhanceSettings(root);
  }
  var dl = $("h2:contains('Installing Savonet')");
  if (dl.length > 0) {
    enhanceDownloads(dl);
  }
  var faq = $("h3:contains('Frequently Asked Questions')");
  if (faq.length > 0) {
    enhanceFaq(faq);
  }

  var parts=document.URL.split("#");
  if (parts.length>1 && parts[1].length > 0){
    var id="#"+parts[1];
    var target = $(id);
    target.parent().parent().show();
    target.siblings().show();
    $('html, body').animate({ scrollTop: target.offset().top }, 500);
  }

  // Replace all "liq" classes by ruby
  $(".syntax,.liq").removeClass("liq").addClass("ruby");
  // Render syntax, making sure that hidden
  // one remain hidden..
  $.syntax({blockLayout: 'plain', theme: 'modern', replace: true},
      function (options, html, container) {
        html = $(html);
        if (container.css("display") == "none")
          html.hide();
        return html;
      }
    );
});

