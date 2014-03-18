class @RelatersCollectionView extends Backbone.View
	tagName:"div"
	className:"list-group"
	initialize : ->
		@collection.on "add",@.render,@
		@collection.on "reset",@.render,@
	render : ->
		console.log "rendering views"
		for users_model in @collection.models
			relater = new RelaterView({"model":users_model})
			@$el.append relater.render().$el
		@
