(function() {
  if (window.HAML == null) {
    window.HAML = {};
  }

  window.HAML['signup'] = function(context) {
    return (function() {
      var $o;
      $o = [];
      $o.push("<div id='email_sending_template'>\n  <input type='email' name='sign_up_email' placeholder='Your email ..'>\n    <button id='submit_email'>Sign up</button>\n</div>");
      return $o.join("\n").replace(/\s(?:id|class)=(['"])(\1)/mg, "");
    }).call(context);
  };

}).call(this);
