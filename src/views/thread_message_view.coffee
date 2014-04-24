class ThreadMessageView extends Backbone.View
	initialize :(attributes)->
		@message = attributes.message
		@init_variable = 6
		console.log @init_variable

	render :()->
		@$el.html HAML["thread_message"]({"message":@message})
		@