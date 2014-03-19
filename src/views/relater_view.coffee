class @RelaterView extends Backbone.View
	events : {
		'click' : 	'sendRelaterModel'
	}
	initialize:(attributes) ->

	render: ->
		@$el.html HAML["relater"](user_model:@model)
		@

	sendRelaterModel:(event) ->
		message_collection = chrome.extension.getBackgroundPage().messages_with_options
		chrome.extension.getBackgroundPage().user_to_send = @model
		messages_container_view =  new MessagesViewContainer()
		$(".container").html messages_container_view.render().$el
		message_collection_view = new MessageCollectionView({"collection":message_collection})
		$("#messages_container").html message_collection_view.render().el