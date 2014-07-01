class @VideoCallView extends Backbone.View
   	events:
    	"click button#video_call_btn":"stop_video_call"
    render: ->
        @$el.html HAML["video_call"]() 
        @
    stop_video_call:(event)->
        event.preventDefault()
        window.stopVideoCall()
        

