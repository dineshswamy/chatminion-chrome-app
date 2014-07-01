class @SignupView extends Backbone.View
	
	tagName : 'div'
	
	className : 'sign_up form-group'
	
	events : 
		'click #google_sign_in' :'register'

	initialize :(attributes) ->
		@call_back = attributes
		console.log "signup view initialized"

	register : (event) ->
		event.preventDefault()		
		chrome.pushMessaging.getChannelId(false,complete_registration)
		#oauth=window.bpageoauth
		#oauth.authorize(onauthorized)
	complete_registration = (google_chrome_channel_id) ->
		console.log "complete_registration"
		chrome.identity.getAuthToken({ 'interactive': true },(token)->save_user(token,google_chrome_channel_id.channelId))

	render : ->
		@$el.html HAML['signup']()
		@

	save_user = (token,google_chrome_channel_id)->
		new_user = new User({channel_id:google_chrome_channel_id,oauth_token:token})
		new_user.save {} ,
			success : (model) ->
				if model.get("status")=="success"
					user_attributes = model.get("user")
					console.log model.get("user")
					new_user.set_attributes(user_attributes)
					window.logged_in_user = new_user
					window.setProfileAttributes(window.logged_in_user.picture,window.logged_in_user.name)
					$(".status").html("Registered successfully")
					chrome.storage.local.set {"registered":true,"registered_user":window.logged_in_user},null
					$("#sign_up_view_modal").modal('hide')	
					window.loadRelaters(window.logged_in_user.id,null)
				else if model.get("status")=="failure"
					$(".status").html("For some reasons registration failed.Please try again later")
					chrome.storage.local.set {"registered":false,"registered_user":null},null
				else
					$(".status").html(model.get("status"))
					chrome.storage.local.set {"registered":false,"registered_user":null},null
					
			error : ->
					$(".status").html("For some reasons registration failed.Please try again later")

     