class @RelaterView extends Backbone.View
	events : {
		'click' : 	'sendRelaterModel'
	}
	initialize:(attributes) ->

	render: ->
		@$el.html HAML["relater"](user_model:@model)
		@

	sendRelaterModel:(event) ->
		$("body").animate({"background-position-x":"90%",10000,'linear'})
		window.relater_to_send = @model
		message_collection = chrome.extension.getBackgroundPage().messages_with_options
		messages_container_view =  new MessagesViewContainer()
		$(".container").html messages_container_view.render().$el
		message_collection_view = new MessageCollectionView({"collection":message_collection})
		$("#messages_container").html message_collection_view.render().el