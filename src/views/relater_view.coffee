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
   		window.message_to_send = null
   		@$el.addClass("active")
   		@$el.siblings().find(".video_call_icon").css("visibility","hidden")
   		@$el.find(".video_call_icon").css("visibility","visible")
   		window.peer_js_selected_relater = @model
   		window.loadMessagesofRelater(@model.id)

   	start_video_call:(event)->
   		if event.target and event.target.nodeName == "SPAN"
   			alert_view = new AlertView()
   			message = "Connecting ..."
   			$("#sign_up_view").html(alert_view.render(message).$el)
   			alert_view.hide_okay_button()
   			$("#sign_up_view_modal").modal({keyboard:false})
   			$("#sign_up_view_modal").modal('show')
   			window.launchVideoCall(event)
		

		
    