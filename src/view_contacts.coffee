class @RelaterCollection extends Backbone.Collection
	model : User
	url : chrome.extension.getBackgroundPage().base_url

	initialize :(attributes) ->
		@url = chrome.extension.getBackgroundPage().base_url+"/user/"+attributes.user_id+"/contacts"


class @RelaterView extends Backbone.View
	tagName:'li'
	className:'available_contact'
	events : {
		'click li.available_contact' : 	'showMessages'
	}
	initialize:(attributes) ->


	render: ->
		@$el.html HAML["relater"](user_model:@model)
		@

	showMessages:(event) ->
		localStorage["relator_to_send"]=@model
		message_collection = new MessageCollection()
		message_collection.fetch
					success : ->
						message_collection_view = new MessageCollectionView({"collection":message_collection})
						message_collection_view.render()
						$("body").html message_collection_view.$el

class @RelatersCollectionView extends Backbone.View
	tagName:'ul'
	className:'friends_contacts_container'
	render : ->
		for users_model in @collection.models
			relater = new RelaterView({"model":users_model})
			@$el.append relater.render().$el
		@
class @Message extends Backbone.Model
	initialize :(attributes)->
		@msg_id=attributes.msg_id
		@user_message=attributes.user_message
		@transform_pattern=attributes.transform_pattern

class @MessageCollection extends Backbone.Collection
	model:Message
	url:chrome.extension.getBackgroundPage().base_url
	initialize : (attributes)->
		@url=@url+"/messages.json"

class @MessageView extends Backbone.View
	tagName:'li'

	className:'messages_li_element'

	events :{
		"click": "send_message" 		
	}

	

	initialize :(attributes)->

	render : ->
		@$el.html HAML["message"](message:@message_model)
		@

class @MessageCollectionView extends Backbone.View
	tagName:'ul'
	className:'messages_container'
	initialize :(attributes)->

	render : ->
		for message_model in @collection.models
			relater= new MessageView({"message_model":@message_model})
			@$el.append relater.render().$el
		@