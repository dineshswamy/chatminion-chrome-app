class @SignupView extends Backbone.View
	
	tagName : 'div'
	
	className : 'sign_up'
	
	events : 
		'click button#google_sign_in' :'register'

	initialize : ->
		console.log "signup view initialized"

	register : (event) ->
		event.preventDefault()
		console.log("Im clicked");
		@email_id_value = @.$("#user_email_id").val()
		chrome.pushMessaging.getChannelId(false,complete_registration)
		#oauth=chrome.extension.getBackgroundPage().oauth
		#oauth.authorize(onauthorized)
	complete_registration = (google_chrome_channel_id) ->
		new_user = User.new({email_id:@email_id_value,channel_id:google_chrome_channel_id})
		new_user.save {} ,
			success : (model) ->
				if model.get("status")=="success"
					$(".status").html("Success")
				else
					$(".status").html("Failure")

	render : ->
		@$el.html HAML['signup']()
		@

	onauthorized = ->
		URL = "https://www.googleapis.com/auth/userinfo#email"
		REQUEST =
			"method" : "GET"
			"parameters" :
						"alt" : "json"
		oauth.sendSignedRequest(URL,onresultcomplete,REQUEST)						

	onresultcomplete = (response,xhr) ->
		console.log("response "+response);
		console.log("xhr "+xhr);
