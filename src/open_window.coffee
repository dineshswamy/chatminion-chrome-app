chrome.app.runtime.onLaunched.addListener( ()-> 
  chrome.app.window.create("../popup.html",
      bounds: 
         width: 360
         height: 300
         left: 600
      minWidth: 220
      minHeight: 220
  ))