'use-strict';
class @ContactsView  extends Backbone.View
    events:
        "click button#submit_new_contact":"addcontact"
    render: ->
        @$el.html HAML["contacts_view"] 
        @
    addcontact:(event)->
        event.preventDefault()
        new_contact_email = $("#new_contact_email").val()
        check_and_addRelator(new_contact_email)


class @InfoView extends Backbone.View
    render:->
        @$el.html HAML["info_view"]
        @


loadRelators = (user_id) ->
    contacts_view = new ContactsView()
    $(".container").html(contacts_view.render().$el)
    window.relater_collection = new RelaterCollection({"user_id":user_id})
    window.relater_collection.fetch
        success : -> 
            if relater_collection.models.length > 0
                relater_collection_view = new RelatersCollectionView({"collection":relater_collection})
                $("#contacts_container").html relater_collection_view.render().el
            else
                $("#contacts_container").html 
    messages = new Messages()
    messages.init()

check_and_addRelator = (add_relater) ->
                    data =
                        relater_email:add_relater
                        user_id: window.logged_in_user.id
                    url = chrome.extension.getBackgroundPage().base_url+"/calltheteam/addcontact"
                    $.post(url,data,callback_check_and_addRelator);

callback_check_and_addRelator = (response_data)->
    response_json = $.parseJSON(response_data)
    switch response_json.status 
        when response_json.status=="success" then window.relater_collection.add(response)
        when response_json.status=="user_not_registered" then openGmailForRequest()
        else display_response(response_json)
    

# set_alert = (alert_type,alert_message,alert_dom_id)->
# 		switch alert_type			
# 			when alert_type=="info" then 
# 				$("#"+alert_dom_id).addClass("")

openGmailForRequest = ()->
    ##to be filled with gmail


initialize_extension = ->
    chrome.storage.local.get ["registered","registered_user"],(result)->
        if result.registered is undefined or result.registered_user is undefined
                sign_up_view = new SignupView(loadRelators)
                $(".container").html(sign_up_view.render().$el)
        else
            window.logged_in_user = result.registered_user
            loadRelators result.registered_user.id

document.addEventListener("DOMContentLoaded",initialize_extension);