class @MessagesViewContainer  extends Backbone.View
    events:
        "click button#submit_new_contact":"send_message"
    render: ->
        @$el.html HAML["messages_container_view"] 
        @
    addcontact:(event)->
        event.preventDefault()
        console.log "handler to be written"
        # new_contact_email = $("#new_contact_email").val()
        # check_and_addRelator(new_contact_email)