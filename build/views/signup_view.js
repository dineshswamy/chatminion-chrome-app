// Generated by CoffeeScript 1.6.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.SignupView = (function(_super) {
    var complete_registration, onauthorized, onresultcomplete;

    __extends(SignupView, _super);

    function SignupView() {
      return SignupView.__super__.constructor.apply(this, arguments);
    }

    SignupView.prototype.tagName = 'div';

    SignupView.prototype.className = 'sign_up';

    SignupView.prototype.events = {
      'click button#google_sign_in': 'register'
    };

    SignupView.prototype.initialize = function() {
      return console.log("signup view initialized");
    };

    SignupView.prototype.register = function(event) {
      event.preventDefault();
      console.log("Im clicked");
      this.email_id_value = this.$("#user_email_id").val();
      return chrome.pushMessaging.getChannelId(false, complete_registration);
    };

    complete_registration = function(google_chrome_channel_id) {
      var new_user;
      new_user = User["new"]({
        email_id: this.email_id_value,
        channel_id: google_chrome_channel_id
      });
      return new_user.save({}, {
        success: function(model) {
          if (model.get("status") === "success") {
            return $(".status").html("Success");
          } else {
            return $(".status").html("Failure");
          }
        }
      });
    };

    SignupView.prototype.render = function() {
      this.$el.html(HAML['signup']());
      return this;
    };

    onauthorized = function() {
      var REQUEST, URL;
      URL = "https://www.googleapis.com/auth/userinfo#email";
      REQUEST = {
        "method": "GET",
        "parameters": {
          "alt": "json"
        }
      };
      return oauth.sendSignedRequest(URL, onresultcomplete, REQUEST);
    };

    onresultcomplete = function(response, xhr) {
      console.log("response " + response);
      return console.log("xhr " + xhr);
    };

    return SignupView;

  })(Backbone.View);

}).call(this);