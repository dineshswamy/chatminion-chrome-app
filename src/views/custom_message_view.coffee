class @CustomMessageView extends Backbone.View
	events :{
		"click #custom_message_submit_btn": "send_message" 		
	}

	initialize :(attributes)->

	render : ->
		@$el.html HAML["custom_message"]()
		@
	send_message :(event)->
		custom_message = new Message({"msg_id":3537,"user_message":$("#custom_message").val(),"transform_pattern":""})
		chrome.extension.getBackgroundPage().message_to_send = custom_message
		chrome.extension.getBackgroundPage().sendMessage()