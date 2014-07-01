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
            if @$el.hasClass("message_selected") 
                @$el.removeClass("message_selected")
                $("#custom_message").prop("disabled",false)
                window.message_to_send = null
            else
                @$el.addClass("message_selected")
                
                window.message_to_send = @model
                $("#custom_message").prop("disabled",true)


            #chrome.extension.getBackgroundPage().sendMessage(@model,false,"")
            #window.close()        

            