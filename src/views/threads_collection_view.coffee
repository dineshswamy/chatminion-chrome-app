class @ThreadsCollectionView extends Backbone.Collection
	tagName:"div"
	className:"list-group"
	initialize :(attributes)->
	
	render : ()->
			for message in @collection
				thread_message = new ThreadMessageView({"message":message})
				@$el.append thread_message.render().$el
			@