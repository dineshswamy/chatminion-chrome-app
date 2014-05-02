class @RelaterView extends Backbone.View
	events : {
		'click' : 	'sendRelaterModel'
	}
	initialize:(attributes) ->

	render: ->
		@$el.html HAML["relater"](user_model:@model)
		@
	sendRelaterModel:(event) ->
    getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia
    getUserMedia(video: true,audio: true,(stream)->
	                		call = window.peer.call('another-peers-id', stream)
	                		call.on('stream',(remoteStream)->$("#chat_video").src(remoteStream))
                		,null)
