class @MessagesViewContainer  extends Backbone.View
    events:
        "click button#submit_custom_message":"send_message"
    render: ->
        @$el.html HAML["messages_container_view"] 
        @
    send_message:(event)->
        event.preventDefault()
        custom_message = $("#custom_message").val()
        if custom_message.length > 0
            console.log custom_message
            chrome.extension.getBackgroundPage().is_custom_message = true
            chrome.extension.getBackgroundPage().custom_message = custom_message
            chrome.extension.getBackgroundPage().sendMessage()
            window.close()

        # new_contact_email = $("#new_contact_email").val()
        # check_and_addRelator(new_contact_email)