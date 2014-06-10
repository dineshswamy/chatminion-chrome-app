class @ThreadMessageView extends Backbone.View
	initialize :(attributes)->
		@model = attributes.model
	
	render : ->
		@$el.html HAML["thread_message"]({"thread_messages":@collection})
		@