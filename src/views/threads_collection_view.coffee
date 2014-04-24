class @ThreadsCollectionView extends Backbone.Collection
	tagName:"div"
	className:"list-group"
	initialize :(attributes)->
		@collection = attributes.collection if attributes != null or attributes != undefined
	render : ()->
			console.log "Collection"
			console.log @collection
			for message in @collection
				@$el.append "<li>#{message}</li>"
			@