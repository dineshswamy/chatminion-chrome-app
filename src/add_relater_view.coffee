class @addRelatersView  extends Backbone.View
    events:
        "click a#submit_new_contact":"addcontact"
    render: ->
        @$el.html HAML["contacts_view"] 
        @
    addcontact:(event)->
        event.preventDefault()
        new_contact_email = $("#new_contact_email").val()
        if new_contact_email != ""
            check_and_addRelator(new_contact_email)

    check_and_addRelator = (add_relater) ->
                    data =
                        relater_email:add_relater
                        user_id: window.logged_in_user.id
                    url = window.base_url+"/calltheteam/addcontact"
                    $("#submit_new_contact").addClass("loader-logo-background")
                    $("#submit_new_contact").off()
                    $.post(url,data,callback_check_and_addRelator);

    callback_check_and_addRelator = (response_json)->
        $("#submit_new_contact").removeClass("loader-logo-background")
        $("#submit_new_contact").on("click",@addcontact)
        switch response_json.status
            when "success"
                    new_relater = {}
                    new_relater["id"] = response_json.new_relater.id
                    new_relater["name"] = response_json.new_relater.name
                    new_relater["channel_id"] = response_json.new_relater.channel_id
                    new_relater["gender"] = response_json.new_relater.gender
                    add_new_relater_and_render(new_relater)
            when "user_not_registered" 
                    openGmailForRequest($("#new_contact_email").val())


    add_new_relater_and_render = (relater)->
            window.addRelaterToCollection(relater)
            add_relaters_view = new addRelatersView()
            relater_collection_view = new RelatersCollectionView({"collection":window.relater_collection})
            $("#relaters_of_the_user").html relater_collection_view.render().el
            $("#relaters_of_the_user").prepend add_relaters_view.render().$el
            # if relater != null
            #     message = "Please ask "+relater.name+", to add you to his contacts"
            #     window.showAlert(message)


    openGmailForRequest = (email)->
        $("#relater_request_join").show()
        mail_to = email
        mail_subject = "Try this chrome app . its totally cool"
        mail_body = "Hi ! try this chrome app called Chatminion . Using this , its totally cool to chat inside an office. 

Installation details are here   http://goo.gl/YPZy73  .Install this and add me as your contact. 

My EMAIL-ID is #{window.logged_in_user.email} . Dont forget , bye.

Chatminion -  http://goo.gl/YPZy73"

        $("#send_relater_request").click((event)->
            event.preventDefault()
            #new_tab_options = 
            url = "https://mail.google.com/mail/?ui=2&view=cm&fs=1&tf=1&shva=2&to=#{mail_to}&su=#{mail_subject}&body=#{mail_body}"
            window.open(url)
            #chrome.tabs.create(new_tab_options,(tab)->
            $("#relater_request_join").hide()
            $("#new_contact_email").val("")
            #    )
            )