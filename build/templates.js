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
      $o.push("<div class='panel-body'>\n  <div class='search-form'>\n    <div class='row'>\n      <div class='col-xs-9'>\n        <div class='form-group'>\n          <input class='form-control' id='new_contact_email' placeholder='Add your relater ...' type='email'>\n        </div>\n      </div>\n      <div class='col-xs-3'>\n        <a class='btn btn-block btn-primary' id='submit_new_contact'>\n          <i class='fa fa-plus'></i>\n          <span>Add</span>\n        </a>\n      </div>\n    </div>\n    <div class='row' id='relater_request_join' style='display:none'>\n      <div class='col-xs-9'>\n        <p class='text-primary'>It seems , your friend is not using Chatminion</p>\n      </div>\n      <div class='col-xs-3'>\n        <button class='btn-square btn-success' id='send_relater_request' type='submit'>ask him</button>\n      </div>\n    </div>\n  </div>\n</div>");
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
      $o.push("<div class='custom_message_container'>\n  <form class='form-horiz' role='form'>\n    <textarea class='form-group form-control' id='custom_message' placeholder='Your message ....' type='text' rows='2'></textarea>\n    <input id='expect_reply' type='checkbox' checked='checked'>Expect a reply</input>\n    <input id='read_out' type='checkbox' checked='checked'>Read out</input>\n  </form>\n</div>\n<button class='btn btn-default' id='submit_custom_message'>Send</button>");
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
      $o.push("" + $e($c(this.message_view_model.user_message)));
      return $o.join("\n").replace(/\s([\w-]+)='true'/mg, ' $1').replace(/\s([\w-]+)='false'/mg, '');
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
      $o.push("<div class='container'>\n  <div class='row'>\n    <div >\n      <h1 id='message_head'>Message</h1>\n    </div>\n  </div>\n  <div class='row'>\n    <div id='threads_container'></div>\n    <div id='messages_container'></div>\n  </div>\n  <footer>\n    <div class='row custom_message_container'>\n      <form class='form-inline' role='form'>\n        <input class='form-group form-control' id='custom_message' placeholder='Your message ....' type='text'>\n        <button class='btn btn-default' id='submit_custom_message'>Send</button>\n        <button class='btn btn-default' id='call_button'>Call</button>\n      </form>\n    </div>\n  </footer>\n</div>");
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
      $o.push("<h4 class='list-group-item-heading'>" + ($e($c(this.user_model.get("name")))) + "</h4>\n<p class='list-group-item-text'>Status</p>");
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
      $o.push("<button class='btn btn-default' id='google_sign_in'>Google+ signIn</button>");
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
      var $c, $e, $o, thread_message, _i, _len, _ref;
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
      _ref = this.thread_messages;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        thread_message = _ref[_i];
        if (thread_message.sent_by_relater) {
          $o.push("<div class='right thread'>\n  <img src='../images/dinesh40x40.jpg'>");
          $o.push("  " + $e($c(thread_message.transformed_message)));
          $o.push("  <abbr class='timeago' title='" + ($c(thread_message.msg_time)) + "'></abbr>\n</div>");
        } else {
          $o.push("<div class='left thread'>\n  <img src='../images/dinesh40x40.jpg'>	</img>");
          $o.push("  " + $e($c(thread_message.transformed_message)));
          $o.push("  <abbr class='timeago' title='" + ($c(thread_message.msg_time)) + "'>				</abbr>\n</div>");
        }
      }
      $o.push("<h2 class='current_message' id='transformed_message'></h2>");
      return $o.join("\n").replace(/\s([\w-]+)='true'/mg, ' $1').replace(/\s([\w-]+)='false'/mg, '').replace(/\s(?:id|class)=(['"])(\1)/mg, "");
    }).call(context);
  };

}).call(this);
(function() {
  if (window.HAML == null) {
    window.HAML = {};
  }

  window.HAML['video_call_view'] = function(context) {
    return (function() {
      var $o;
      $o = [];
      $o.push("<video id='chat_video' autoplay=''></video>\n<button id='show_face'>show</button>");
      return $o.join("\n").replace(/\s(?:id|class)=(['"])(\1)/mg, "");
    }).call(context);
  };

}).call(this);
