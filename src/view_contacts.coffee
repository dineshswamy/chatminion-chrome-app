class @MessagesViewContainer  extends Backbone.View
    events:
        "click button#submit_new_contact":"send_message"
    render: ->
        @$el.html HAML["messages_container_view"] 
        @
    addcontact:(event)->
        event.preventDefault()
        new_contact_email = $("#new_contact_email").val()
        check_and_addRelator(new_contact_email)


class @RelaterCollection extends Backbone.Collection
	model : User
	url : chrome.extension.getBackgroundPage().base_url

	initialize :(attributes) ->
		@url = chrome.extension.getBackgroundPage().base_url+"/user/"+attributes.user_id+"/contacts"

class @RelaterView extends Backbone.View
	events : {
		'click' : 	'sendRelaterModel'
	}
	initialize:(attributes) ->

	render: ->
		@$el.html HAML["relater"](user_model:@model)
		@

	sendRelaterModel:(event) ->
		chrome.extension.getBackgroundPage().user_to_send = @model
		#messages_container_view =  new MessagesViewContainer()
		#$(".container").html messages_container_view.render().$el
		message_collection_view = new MessageCollectionView({"collection":window.message_collection})
		$(".container").html message_collection_view.render().el


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
	events :{
		"click": "send_message" 		
	}

	initialize :(attributes)->

	render : ->
		@$el.html HAML["message"](message_view_model:@model)
		@
	send_message :(event)->
		console.log "message clicked"
		chrome.extension.getBackgroundPage().message_to_send = @model
		chrome.extension.getBackgroundPage().sendMessage()
		

class @MessageCollectionView extends Backbone.View
	tagName:"div"
	className:"list-group"
	initialize :(attributes)->
	
	render : ()->
		for message_models in @collection
			relater= new MessageView({"model":message_models})
			@$el.append relater.render().$el
		@