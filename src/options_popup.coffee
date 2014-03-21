loadMessages = (event)->
	options_for_messages = chrome.extension.getBackgroundPage().options_for_message
	messages_container_view =  new MessagesViewContainer()
	$(".container").html messages_container_view.render().$el
	message_collection_view = new MessageCollectionView({"collection":options_for_messages})
	$("#messages_container").html message_collection_view.render().el
	$("#message_head").html chrome.extension.getBackgroundPage().transformed_message
	$("title").html chrome.extension.getBackgroundPage().transformed_message
	chrome.tts.speak(String(chrome.extension.getBackgroundPage().transformed_message))



document.addEventListener("DOMContentLoaded",loadMessages)
