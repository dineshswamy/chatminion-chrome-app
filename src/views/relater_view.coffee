class @RelaterView extends Backbone.View
	events : {
		"click" : "loadMessages"
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
   
   $("#video_call_relater_name").html(@model.get("name"))
   
   window.peer_js_selected_relater = @model
   
   window.loadMessagesofRelater(@model.id)
   
		

		
    