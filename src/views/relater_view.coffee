class @RelaterView extends Backbone.View
	events : {
		"click" : "loadMessages",
		"click .video_call_icon" :"start_video_call"
	}
	tagName : "a"
	className : "list-group-item"

	attributes: ()-> 'data-relater-id' : @.model.id

	initialize:(attributes) ->
		@listenTo Backbone,'loadMessages',@loadMessages 

	render: ->
		@$el.html HAML["relater"](user_model:@model)
		@

	loadMessages:(event) ->
   		@$el.siblings().removeClass("active")
   		console.log "I m the one who closed options"
   		@$el.addClass("active")
   		@$el.siblings().find(".video_call_icon").css("visibility","hidden")
   		@$el.find(".video_call_icon").css("visibility","visible")
   		window.peer_js_selected_relater = @model
   		window.loadMessagesofRelater(@model.id)

   	start_video_call:(event)->
   		if event.target and event.target.nodeName == "SPAN"
   			window.launchVideoCall(event)
		

		
    