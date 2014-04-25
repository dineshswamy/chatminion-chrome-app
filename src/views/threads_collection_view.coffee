class @ThreadsCollectionView extends Backbone.View
	tagName:"div"
	className:"list-group"
	initialize :(attributes)->
		@collection = attributes.collection if attributes != null or attributes != undefined
	render : ()->
			for message in @collection
				thread = new ThreadMessageView({"message":message})
				@$el.append thread.render().$el
			@