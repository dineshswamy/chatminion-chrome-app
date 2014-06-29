class @SignupView extends Backbone.View
	
	tagName : 'div'
	
	className : 'sign_up form-group'
	
	events : 
		'click button#google_sign_in' :'register'

	initialize :(attributes) ->
		@call_back=attributes
		console.log "signup view initialized"

	register : (event) ->
		event.preventDefault()		
		chrome.pushMessaging.getChannelId(false,complete_registration)
		#oauth=window.bpageoauth
		#oauth.authorize(onauthorized)
	complete_registration = (google_chrome_channel_id) ->
		#name_value = $("#user_name").val()
		#email_id_value = $("#user_email_id").val()
		##Need to be changed later
		chrome.identity.getAuthToken({ 'interactive': true },(token)->save_user(token))

	render : ->
		@$el.html HAML['signup']()
		@

	save_user = (token)->
		console.log token
		new_user = new User({email_id:token,channel_id:google_chrome_channel_id.channelId,name:token})
		new_user.save {} ,
			success : (model) ->
				if model.get("status")=="success"
					new_user.set({"id":model.get("user_id")})
					window.logged_in_user = new_user
					$(".status").html("Registered successfully")
					chrome.storage.local.set {"registered":true,"registered_user":model},null
					$("#sign_up_view_modal").modal('hide')	
					call_back(model.get("user_id"))
				else if model.get("status")=="failure"
					$(".status").html("For some reasons registration failed.Please try again later")
					chrome.storage.local.set {"registered":false,"registered_user":null},null
				else
					$(".status").html(model.get("status"))
					chrome.storage.local.set {"registered":false,"registered_user":null},null
					
			error : ->
					$(".status").html("For some reasons registration failed.Please try again later")
