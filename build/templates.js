(function() {
  if (window.HAML == null) {
    window.HAML = {};
  }

  window.HAML['contacts_view'] = function(context) {
    return (function() {
      var $o;
      $o = [];
      $o.push("<div class='container'>\n  <div class='row'>\n    <div class='col-md-4 col-xs-4'>\n      <h1 >Contacts</h1>\n    </div>\n  </div>\n  <div class='row'>\n    <div class='col-md-4 col-xs-4' id='contacts_container'></div>\n  </div>\n  <footer>\n    <div class='row add_contact'>\n      <form class='form-inline' role='form'>\n        <input class='form-group form-control' id='new_contact_email' placeholder='enter email id' type='email'>\n        <button class='btn btn-default' id='submit_new_contact'>Add</button>\n      </form>\n    </div>\n    <div class='row' id='friend_request_join' style='display:none'>\n      <p class='text-primary'>It seems , your friend not yet joined\n        <button class='btn-square btn-success' type='submit'>ask him</button>\n      </p>\n    </div>\n  </footer>\n</div>");
      return $o.join("\n").replace(/\s(?:id|class)=(['"])(\1)/mg, "");
    }).call(context);
  };

}).call(this);
(function() {
  if (window.HAML == null) {
    window.HAML = {};
  }

  window.HAML['message'] = function(context) {
    return (function() {
      var $c, $e, $o;
      $e = function(text, escape) {
        return ("" + text).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/'/g, '&#39;').replace(/\//g, '&#47;').replace(/"/g, '&quot;');
      };
      $c = function(text) {
        switch (text) {
          case null:
          case void 0:
            return '';
          case true:
          case false:
            return '' + text;
          default:
            return text;
        }
      };
      $o = [];
      $o.push("" + $e($c(this.message_view_model.user_message)));
      return $o.join("\n").replace(/\s([\w-]+)='true'/mg, ' $1').replace(/\s([\w-]+)='false'/mg, '');
    }).call(context);
  };

}).call(this);
(function() {
  if (window.HAML == null) {
    window.HAML = {};
  }

  window.HAML['messages_view'] = function(context) {
    return (function() {
      var $o;
      $o = [];
      $o.push("<div class='container'>\n  <div class='row'>\n    <div class='col-md-4 col-xs-4'>\n      Messages\n    </div>\n  </div>\n  <div class='row'>\n    <div class=' col-md-4 col-xs-4' id='messages_container'></div>\n  </div>\n</div>");
      return $o.join("\n").replace(/\s(?:id|class)=(['"])(\1)/mg, "");
    }).call(context);
  };

}).call(this);
(function() {
  if (window.HAML == null) {
    window.HAML = {};
  }

  window.HAML['relater'] = function(context) {
    return (function() {
      var $c, $e, $o;
      $e = function(text, escape) {
        return ("" + text).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/'/g, '&#39;').replace(/\//g, '&#47;').replace(/"/g, '&quot;');
      };
      $c = function(text) {
        switch (text) {
          case null:
          case void 0:
            return '';
          case true:
          case false:
            return '' + text;
          default:
            return text;
        }
      };
      $o = [];
      $o.push("<div class='todo-icon fui-time'></div>\n<div class='todo-content'>\n  <h4 class='todo-name'>");
      $o.push("    " + $e($c(this.user_model.get("name"))));
      $o.push("  </h4>\n</div>");
      return $o.join("\n").replace(/\s([\w-]+)='true'/mg, ' $1').replace(/\s([\w-]+)='false'/mg, '').replace(/\s(?:id|class)=(['"])(\1)/mg, "");
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
      $o.push("<center>\n  <div class='status'></div>\n  <div id='email_sending_template'></div>\n  <input class='form-control form-group' id='user_email_id' placeholder='Your email ...'>\n  <input class='form-control form-group' id='user_name' placeholder='Your name ...'>\n  <button class='btn btn-default' id='google_sign_in'>Signup</button>\n</center>");
      return $o.join("\n").replace(/\s(?:id|class)=(['"])(\1)/mg, "");
    }).call(context);
  };

}).call(this);
