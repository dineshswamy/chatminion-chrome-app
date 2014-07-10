class @MessageCollectionView extends Backbone.View
	tagName:"div"
	className:"list-group messages_collection_div"
	events :{
		"click" : "remove_selection"
	}	
	
	render : ()->
			if @collection.models != null and @collection.models != undefined
				for message_models in @collection.models
					relater = new MessageView({"model":message_models})
					@$el.append relater.render().$el
				
			custom_message = new CustomMessageView()
			@$el.append custom_message.render().$el
			@

	remove_selection:(event)->
		 
