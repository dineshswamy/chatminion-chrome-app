class @ThreadMessageView extends Backbone.View
	initialize :(attributes)->
		@message = attributes.message if attributes isnt null and attributes isnt undefined
	render : ->
		@$el.html HAML["thread_message"]({"message":@message.message})
		@