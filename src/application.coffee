'use-strict';





class @ContactsView  extends Backbone.View
    events:
        "click #submit_new_contact":"addContact"
	render: ->
		@$el.html HAML["contacts_view"]	
		@
    addcontact:()->
        new_contact_email = $("#new_contact_email").val()
        check_and_addRelator(new_contact_email)        

loadRelators = (user_id) ->
    contacts_message_view = new ContactsView()
    $(".container").html(contacts_message_view.render().$el)
    relater_collection = new RelaterCollection({"user_id":user_id})
    relater_collection.fetch
        success : -> 
            relater_collection_view = new RelatersCollectionView({"collection":relater_collection})
            $("#contacts_container").html relater_collection_view.render().el
    messages = new Messages()
    messages.init()

check_and_addRelator = (add_relator_id) ->
				data =
					relator_id:add_relator_id
				url	= chrome.extension.getBackgroundPage().base_url+"/calltheteam/addcontact"
				$.post(url,data,callback_check_and_addRelator);

callback_check_and_addRelator = (response_data)->
#				switch response_data.status 
#					when response_data.status=="success" then add_relator(response_data)
#					when response_data.status=="user_not_registered" then openGmailForRequest()
#					else display_response(response)


# set_alert = (alert_type,alert_message,alert_dom_id)->
# 		switch alert_type			
# 			when alert_type=="info" then 
# 				$("#"+alert_dom_id).addClass("")


initialize_extension = ->
    chrome.storage.local.get ["registered","registered_user_id"],(result)->
        console.log result
        if result.registered is undefined and result.registered_user_id is undefined
                sign_up_view = new SignupView(loadRelators)
                $(".container").html(sign_up_view.render().$el)
        else
            console.log "registered id"+result.registered_user_id
            loadRelators result.registered_user_id

document.addEventListener("DOMContentLoaded",initialize_extension);