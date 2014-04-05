class ThreadMessageView extends Backbone.View
	initialize :(attributes)->
		@message=attributes.message

	render :()->
		@$el.html HAML["thread_message"]({"message":@message})
		@