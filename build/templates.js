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

  window.HAML['contacts_message_view'] = function(context) {
    return (function() {
      var $o;
      $o = [];
      $o.push("<div class='container'>\n  <div class='row'>\n    <div class='col-md-4 col-xs-4'>\n      <div class='panel panel-default'>\n        Contacts\n      </div>\n    </div>\n  </div>\n  <div class='row'>\n    <div class='col-md-4 col-xs-4' id='contacts_container'></div>\n    <div class='col-md-4 col-xs-4' id='messages_container'></div>\n  </div>\n</div>");
      return $o.join("\n").replace(/\s(?:id|class)=(['"])(\1)/mg, "");
    }).call(context);
  };

}).call(this);
(function() {
  if (window.HAML == null) {
    window.HAML = {};
  }

  window.HAML['contacts_view'] = function(context) {
    return (function() {
      var $o;
      $o = [];
      $o.push("<div class='container'>\n  <div class='row'>\n    <div >\n      <h1 class='contacts_header'>Contacts</h1>\n    </div>\n  </div>\n  <div class='row'>\n    <div id='contacts_container'></div>\n  </div>\n  <footer>\n    <div class='row add_contact'>\n      <form class='form-inline' role='form'>\n        <input class='form-group form-control' id='new_contact_email' placeholder='enter email id' type='email'>\n        <button class='btn btn-default' id='submit_new_contact'>Add</button>\n      </form>\n    </div>\n    <div class='row' id='relater_request_join' style='display:none'>\n      <p class='text-primary'>It seems , your friend is not using Chatminion\n        <button class='btn-square btn-success' id='send_relater_request' type='submit'>ask him</button>\n      </p>\n    </div>\n  </footer>\n</div>");
      return $o.join("\n").replace(/\s(?:id|class)=(['"])(\1)/mg, "");
    }).call(context);
  };

}).call(this);
(function() {
  if (window.HAML == null) {
    window.HAML = {};
  }

  window.HAML['custom_message'] = function(context) {
    return (function() {
      var $o;
      $o = [];
      $o.push("<div class='form-group'>\n  <textarea class='form-control' id='custom_message' rows='5' cols='5'></textarea>\n  <button class='btn btn-default' id='custom_message_submit_btn'></button>\n</div>");
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

  window.HAML['info_view'] = function(context) {
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
      $o.push("<div class='text-primary'>\n  <h3>");
      $o.push("    " + $e($c(this.info)));
      $o.push("  </h3>\n</div>");
      return $o.join("\n").replace(/\s([\w-]+)='true'/mg, ' $1').replace(/\s([\w-]+)='false'/mg, '').replace(/\s(?:id|class)=(['"])(\1)/mg, "");
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
      $o.push("<h3 class='messages_list'>");
      $o.push("  " + $e($c(this.message_view_model.user_message)));
      $o.push("</h3>");
      return $o.join("\n").replace(/\s([\w-]+)='true'/mg, ' $1').replace(/\s([\w-]+)='false'/mg, '').replace(/\s(?:id|class)=(['"])(\1)/mg, "");
    }).call(context);
  };

}).call(this);
(function() {
  if (window.HAML == null) {
    window.HAML = {};
  }

  window.HAML['messages_container_view'] = function(context) {
    return (function() {
      var $o;
      $o = [];
      $o.push("<div class='container'>\n  <div class='row'>\n    <div >\n      <h1 id='message_head'>Message</h1>\n    </div>\n  </div>\n  <div class='row'>\n    <div id='messages_container'></div>\n  </div>\n  <footer>\n    <div class='row custom_message_container'>\n      <form class='form-inline' role='form'>\n        <input class='form-group form-control' id='custom_message' placeholder='Your message ....' type='text'>\n        <button class='btn btn-default' id='submit_custom_message'>Send</button>\n        <button class='btn btn-default' id='call_button'>Call</button>\n      </form>\n    </div>\n  </footer>\n</div>");
      return $o.join("\n").replace(/\s(?:id|class)=(['"])(\1)/mg, "");
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
      $o.push("<h3 class='contact_names'>");
      $o.push("  " + $e($c(this.user_model.get("name"))));
      $o.push("</h3>");
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
      $o.push("<center>\n  <div class='status'></div>\n  <br>\n  <br>\n  <br>\n  <div id='email_sending_template'></div>\n  <input class='form-control form-group' id='user_email_id' placeholder='email ...'>\n  <input class='form-control form-group' id='user_name' placeholder='name ...'>\n  <button class='btn btn-default' id='google_sign_in'>Count me in</button>\n</center>");
      return $o.join("\n").replace(/\s(?:id|class)=(['"])(\1)/mg, "");
    }).call(context);
  };

}).call(this);
(function() {
  if (window.HAML == null) {
    window.HAML = {};
  }

  window.HAML['thread_message'] = function(context) {
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
      $o.push("<h3 class='thread_message'>");
      $o.push("  " + $e($c(this.message)));
      $o.push("</h3>");
      return $o.join("\n").replace(/\s([\w-]+)='true'/mg, ' $1').replace(/\s([\w-]+)='false'/mg, '').replace(/\s(?:id|class)=(['"])(\1)/mg, "");
    }).call(context);
  };

}).call(this);
