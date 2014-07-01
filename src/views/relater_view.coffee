class @RelaterView extends Backbone.View
	events : {
		"click" : "loadMessages",
		"click .video_call_icon" :"start_video_call"
	}
	tagName : "a"
	className : "list-group-item"
	initialize:(attributes) ->
		@listenTo Backbone,'loadMessages',@loadMessages 

	render: ->
		@$el.html HAML["relater"](user_model:@model)
		@

	loadMessages:(event) ->
   		@$el.siblings().removeClass("active")
   		@$el.addClass("active")   
   		window.peer_js_selected_relater = @model
   		window.loadMessagesofRelater(@model.id)
   	
   	start_video_call:(event)->
   		if event.target and event.target.nodeName == "SPAN"
   			window.launchVideoCall(event)
		

		
    