window.relater_to_send = null

chrome.runtime.onMessage.addListener((request, sender, sendResponse)->
	console.log "request received"
	if window.relater_to_send==null or window.relater_to_send == undefined
		window.relater_to_send = new User(request.relater_to_send)
	if window.relater_to_send.id == request.relater_id
		window.options_for_messages = chrome.extension.getBackgroundPage().options_for_message
		window.transformed_message = request.transformed_message
		loadMessages()
)
window.loadMessages = () ->
	relater_threads = chrome.extension.getBackgroundPage().getRelaterThread(window.relater_to_send.id)
	messages_container_view =  new MessagesViewContainer()
	$(".container").html messages_container_view.render().$el
	relater_threads_view = new ThreadsCollectionView({"collection":relater_threads})
	message_collection_view = new MessageCollectionView({"collection":window.options_for_messages})
	$("#messages_container").html message_collection_view.render().el
	$("#threads_container").html relater_threads_view.render().el
	$("#message_head").html window.transformed_message
	$("title").html window.transformed_message
	#chrome.extension.getBackgroundPage().speakMessage(window.transformed_message)

window.initializeWindow = ()->
	chrome.extension.getBackgroundPage().sendBroadcastMessage()

window.addEventListener("DOMContentLoaded",initializeWindow,false)