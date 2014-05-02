class @MessageView extends Backbone.View
        events :{
        	"click": "send_message" 		
        }
        tagName :"div"
        className : "messages_list"
        initialize :(attributes)->
        
        render : ->
        	@$el.html HAML["message"](message_view_model:@model)
        	@
        send_message :(event)->
            @$el.siblings().removeClass("message_selected")
            @$el.addClass("message_selected")
            #chrome.extension.getBackgroundPage().sendMessage(@model,false,"")
            #window.close()        

            