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

    check_and_addRelator = (add_relater) ->
                    data =
                        relater_email:add_relater
                        user_id: chrome.extension.getBackgroundPage().logged_in_user.id
                    url = chrome.extension.getBackgroundPage().base_url+"/calltheteam/addcontact"
                    $.post(url,data,callback_check_and_addRelator);

    callback_check_and_addRelator = (response_json)->
	    console.log response_json.status
	    new_relater = 
	        "id": response_json.new_relater.id
	        "name":  response_json.new_relater.name
	        "channel_id": response_json.new_relater.channel_id
	    switch response_json.status 
	        when "success" then add_new_relater_and_render(new_relater)    
	        when "user_not_registered" then openGmailForRequest()

    add_new_relater_and_render = (relater)->
            chrome.extension.getBackgroundPage().addRelaterToCollection(relater,window.loadRelaters)
            console.log "refreshing views"
            
            #relater_collection_view = new RelatersCollectionView({"collection":chrome.extension.getBackgroundPage().relater_collection})
            #$("#contacts_container").html relater_collection_view.render().el
            

    openGmailForRequest = ()->
    ##to be filled with gmail