class @CustomMessageView extends Backbone.View
   	events:
    	"click button#submit_custom_message":"send_message"
    render: ->
        @$el.html HAML["custom_message"]() 
        @
    send_message:(event)->
        event.preventDefault()
        window.sendMessage(event);

