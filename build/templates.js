(function() {
  if (window.HAML == null) {
    window.HAML = {};
  }

  window.HAML['contacts'] = function(context) {
    return (function() {
      var $o;
      $o = [];
      $o.push("<div id='contacts_container'>\n  <ul id='available_contact'>\n    <li>first list item</li>\n    <li>second list item</li>\n  </ul>\n  <div id='add_contact_container'>\n    <input id='contact_email_id' type='email' placeholder='add to contact'>\n    <button id='submit_contact'>add</button>\n  </div>\n</div>");
      return $o.join("\n").replace(/\s(?:id|class)=(['"])(\1)/mg, "");
    }).call(context);
  };

}).call(this);
(function() {
  if (window.HAML == null) {
    window.HAML = {};
  }

  window.HAML['friend'] = function(context) {
    return (function() {
      var $o;
      $o = [];
      $o.push("@model.get(\"name\")");
      return $o.join("\n");
    }).call(context);
  };

}).call(this);
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
