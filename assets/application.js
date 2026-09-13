var addLoadEvent, externalLinks;

addLoadEvent = function(func) {
  var oldonload;
  oldonload = window.onload;
  if (typeof window.onload !== "function") {
    return window.onload = func;
  } else {
    return window.onload = function() {
      if (oldonload) {
        oldonload();
      }
      return func();
    };
  }
};

externalLinks = function() {
  var anchor, external, i, len, ref, rel, results;
  if (!document.getElementsByTagName || !String.prototype.indexOf) {
    return;
  }
  ref = document.getElementsByTagName("a");
  results = [];
  for (i = 0, len = ref.length; i < len; i++) {
    anchor = ref[i];
    rel = anchor.getAttribute("rel");
    external = rel && rel.indexOf("external") >= 0;
    if (anchor.getAttribute("href") && external === true) {
      results.push(anchor.target = "_blank");
    } else {
      results.push(void 0);
    }
  }
  return results;
};

addLoadEvent(externalLinks);
