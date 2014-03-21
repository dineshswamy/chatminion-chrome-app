class @MessageView extends Backbone.View
	events :{
		"click": "send_message" 		
	}

	initialize :(attributes)->

	render : ->
		@$el.html HAML["message"](message_view_model:@model)
		@
	send_message :(event)->
		chrome.extension.getBackgroundPage().message_to_send = @model
		chrome.extension.getBackgroundPage().sendMessage()
		window.close()