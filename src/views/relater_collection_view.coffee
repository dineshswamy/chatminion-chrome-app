class @RelatersCollectionView extends Backbone.View
	tagName:"div"
	className:"list-group"
	initialize : ->
		@collection.on "add",@.render,@
		@collection.on "reset",@.render,@
	render : ->
		console.log "called once"
		for users_model in @collection.models
			relater = new RelaterView({"model":users_model})
			@$el.append relater.render().$el
		@
	add : (relater)->
		console.log "relater added"
		@collection.add(relater)

	find_and_set_checked : (relater_id)->
		
