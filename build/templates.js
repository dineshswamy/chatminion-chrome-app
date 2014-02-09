(function() {
  if (window.HAML == null) {
    window.HAML = {};
  }

  window.HAML['signup'] = function(context) {
    return (function() {
      var $o;
      $o = [];
      $o.push("<div class='status'></div>\n<div id='email_sending_template'>\n  <input id='user_email_id' placeholder='Your email ...'>\n    <button id='google_sign_in'>Google sign in</button>\n</div>");
      return $o.join("\n").replace(/\s(?:id|class)=(['"])(\1)/mg, "");
    }).call(context);
  };

}).call(this);
