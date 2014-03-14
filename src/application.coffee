'use-strict';
class @InfoView extends Backbone.View
    render:(message)->
        @$el.html HAML["info_view"]({"info":message})
        @

loadRelators = (user_id) ->
    contacts_view = new RelatersViewContainer()
    $(".container").html(contacts_view.render().$el)
    window.relater_collection = new RelaterCollection({"user_id":user_id})
    window.relater_collection.fetch
        success : -> 
            console.log "Models length "+window.relater_collection.models.length
            if window.relater_collection.models.length > 0
                relater_collection_view = new RelatersCollectionView({"collection":window.relater_collection})
                $("#contacts_container").html relater_collection_view.render().el
            else
                $("#contacts_container").html new InfoView().render("You have no contacts!").$el
    messages = new Messages()
    messages.init()

check_and_addRelator = (add_relater) ->
                    data =
                        relater_email:add_relater
                        user_id: window.logged_in_user.id
                    url = chrome.extension.getBackgroundPage().base_url+"/calltheteam/addcontact"
                    $.post(url,data,callback_check_and_addRelator);

callback_check_and_addRelator = (response_json)->
    console.log response_json.status
    new_relater = 
        "id": response_json.new_relater.id
        "name":  response_json.new_relater.name
        "channel_id": response_json.new_relater.channel_id
    switch response_json.status 
        when response_json.status=="success" then add_new_relater_and_render(new_relater)
        when response_json.status=="user_not_registered" then openGmailForRequest()

add_new_relater_and_render = (relater)->
                window.relater_collection.add(new_relater)
                console.log "adding the new relater"
                relater_collection_view = new RelatersCollectionView({"collection":window.relater_collection})
                $("#contacts_container").html relater_collection_view.render().el
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