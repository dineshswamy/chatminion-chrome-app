// Generated by CoffeeScript 1.6.1
(function() {
  var loadMessages;

  loadMessages = function(event) {
    var message_collection_view, messages_container_view, options_for_messages;
    options_for_messages = chrome.extension.getBackgroundPage().options_for_message;
    console.log(options_for_messages);
    messages_container_view = new MessagesViewContainer();
    $(".container").html(messages_container_view.render().$el);
    message_collection_view = new MessageCollectionView({
      "collection": options_for_messages
    });
    $("#messages_container").html(message_collection_view.render().el);
    return $("#message_head").html(chrome.extension.getBackgroundPage().transformed_message);
  };

  document.addEventListener("DOMContentLoaded", loadMessages);

}).call(this);
