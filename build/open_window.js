// Generated by CoffeeScript 1.6.1
(function() {

  chrome.app.runtime.onLaunched.addListener(function() {
    return chrome.app.window.create("../popup.html", {
      bounds: {
        width: 360,
        height: 300,
        left: 600
      },
      minWidth: 220,
      minHeight: 220
    });
  });

}).call(this);
