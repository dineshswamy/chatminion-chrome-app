class @CustomMessageView extends Backbone.View
   	events:
    	"click button#submit_custom_message":"send_message"
    	"click div#reveal_message_properties":"open_message_properties"
    render: ->
        @$el.html HAML["custom_message"]() 
        @
    send_message:(event)->
        event.preventDefault()        
        window.sendMessage(event);

    open_message_properties:(event)->
    	$(".message_properties").toggle()
