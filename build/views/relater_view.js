// Generated by CoffeeScript 1.6.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.RelaterView = (function(_super) {

    __extends(RelaterView, _super);

    function RelaterView() {
      return RelaterView.__super__.constructor.apply(this, arguments);
    }

    RelaterView.prototype.events = {
      "click": "loadMessages",
      "click .video_call_icon": "start_video_call"
    };

    RelaterView.prototype.tagName = "a";

    RelaterView.prototype.className = "list-group-item";

    RelaterView.prototype.initialize = function(attributes) {
      return this.listenTo(Backbone, 'loadMessages', this.loadMessages);
    };

    RelaterView.prototype.render = function() {
      this.$el.html(HAML["relater"]({
        user_model: this.model
      }));
      return this;
    };

    RelaterView.prototype.loadMessages = function(event) {
      this.$el.siblings().removeClass("active");
      this.$el.addClass("active");
      window.peer_js_selected_relater = this.model;
      return window.loadMessagesofRelater(this.model.id);
    };

    RelaterView.prototype.start_video_call = function(event) {
      if (event.target && event.target.nodeName === "SPAN") {
        return window.launchVideoCall(event);
      }
    };

    return RelaterView;

  })(Backbone.View);

}).call(this);
