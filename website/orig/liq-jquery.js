/* Enhance reference presentation. */
function enhanceRef (ref) {
  /* Find all links that have attribute "name" */
  var links = ref.parent().find('a[name]');
  /* Hidding is expensive, therefore we store
   * all object to be hidden and hid them at once.. */
  var hide = [];
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
    /* Find each operator. */
    var operators = content.filter("h5");
    /* Initiate a list. */
    var section = $("<ul></ul>");
    /* For each of them do the following. */
    operators.each(function () {
      var elem = $(this);
      /* Get text content. */
      var text = elem.text();
      /* Initiate a link. */
      var link = $("<a href=\"#\">" + text + "</a>");
      /* Get all elements until next
       * operator. */
      var doc = elem.nextUntil("h5,h3,#footer");
      /* Move doc to section. */
      var li = $("<li></li>");
      li.append(link).append(doc.detach());
      section.append(li);
      /* Hide doc. */
      hide.push(doc);
      /* Toggle showing on links on click. */
      link.click(function () {
        doc.fadeToggle();
        return false;
      });
      /* Remove elem. */
      elem.remove();
    });
    /* Hide section */
    hide.push(section);
    /* Add click action. */
    target.click(function () {
      section.fadeToggle("fast");
      return false;
    });
    /* Append section. */
    target.after(section);
    /* Remove link. */
    link.remove();
  });
  jQuery.each(hide,function (index,elem) {
    elem.css('display', 'none');
  });
}

function enhanceSettings(root) {
  /* Hidding is expensive, therefore we store
   * all object to be hidden and hid them at once.. */
  var hide = [];
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
        var link = $("<a href=\"#\">" + text + "</a>");
        var content = elem.nextUntil("h4,h3,#footer");
        hide.push(content);
        link.click(function () { 
          content.fadeToggle("fast");
          return false;
        });
        var li = $("<li></li>");
        li.append(link).append(content.detach());
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
  jQuery.each(hide,function (index,elem) {
    elem.css('display', 'none');
  });
}

$(document).ready(function () {
  var ref = $("h2,h3:contains('Liquidsoap scripting language reference')");
  if (ref.length > 0) {
    enhanceRef(ref);
  }
  var root = $("h3:contains('Liquidsoap configuration')");
  if (root.length > 0) {
    enhanceSettings(root);
  }
});

