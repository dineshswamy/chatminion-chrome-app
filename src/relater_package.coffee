class @RelatersViewContainer  extends Backbone.View
    events:
        "click button#submit_new_contact":"addcontact"
    render: ->
        @$el.html HAML["contacts_view"] 
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
		messages_container_view =  new MessagesViewContainer()
		$(".container").html messages_container_view.render().$el
		message_collection_view = new MessageCollectionView({"collection":window.message_collection})
		$("#messages_container").html message_collection_view.render().el


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
