class @CustomMessageView extends Backbone.View
   	events:
    	"click button#submit_custom_message":"send_message"
    	"click button#call_button":"call_relater"
    render: ->
        @$el.html HAML["custom_message"]() 
        @
    send_message:(event)->
        event.preventDefault()
        custom_message = $("#custom_message").val()