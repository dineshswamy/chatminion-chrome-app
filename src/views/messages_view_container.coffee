class @CustomMessageView  extends Backbone.View
    events:
        "click button#submit_custom_message":"send_message"
        "click button#call_button":"call_relater"
    render: ->
        @$el.html HAML["messages_container_view"] 
        @
    send_message:(event)->
        event.preventDefault()
        custom_message = $("#custom_message").val()
        if custom_message.length > 0
            chrome.extension.getBackgroundPage().sendMessage("",true,custom_message)
            window.close()
    # call_relater:(event)->
    #     event.preventDefault()
    #     peer = new Peer(window.logged_in_user.id,{"key":})
    #     getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia
    #     # new_contact_email = $("#new_contact_email").val()
    #     # check_and_addRelator(new_contact_email)