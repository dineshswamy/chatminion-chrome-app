class @MessageView extends Backbone.View
        events :{
        	"click": "send_message" 		
        }
        initialize :(attributes)->
        
        render : ->
        	@$el.html HAML["message"](message_view_model:@model)
        	@
        send_message :(event)->
            chrome.extension.getBackgroundPage().sendMessage(window.relater_to_send,@model,false,"")
            window.close()        

            