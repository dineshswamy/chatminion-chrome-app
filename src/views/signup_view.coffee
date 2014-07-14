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
		@.$("#google_sign_in").hide()
		@.$("#sign_in_wrapper").css("background-image","url(../../images/loadinfo_net.gif)")
		$(@$el).off("click","#google_sign_in")
		chrome.identity.getAuthToken({ 'interactive': true },complete_registration)
		#oauth=window.bpageoauth
		#oauth.authorize(onauthorized)
	complete_registration = (token) ->
		console.log "complete_registration"
		chrome.pushMessaging.getChannelId((google_chrome_channel_id)->save_user(token,google_chrome_channel_id.channelId))

	render : ->
		@$el.html HAML['signup']()
		@

	save_user = (token,google_chrome_channel_id)->
		new_user = new User({channel_id:google_chrome_channel_id,oauth_token:token})
		new_user.save {} ,
			success : (model) ->
				if model.get("status")=="success"
					user_attributes = model.get("user")
					new_user.set_attributes(user_attributes)
					window.logged_in_user = new_user
					window.setProfileAttributes(window.logged_in_user.picture,window.logged_in_user.name)
					show_message("Registered successfully")
					chrome.storage.local.set {"registered":true,"registered_user":window.logged_in_user},null
					$("#sign_up_view_modal").modal('hide')	
					window.loadRelaters(window.logged_in_user.id)
				else if model.get("status")=="failure"
					@.$("#google_sign_in").show()
					@.$("#sign_in_wrapper").css("background-image"," ")
					show_message("For some reasons registration failed.Please try again later")
					chrome.storage.local.set {"registered":false,"registered_user":null},null
				else
					@.$("#google_sign_in").show()
					@.$("#sign_in_wrapper").css("background-image"," ")
					show_message(model.get("status"))
					chrome.storage.local.set {"registered":false,"registered_user":null},null
					
			error : ->
					@.$("#google_sign_in").show()
					@.$("#sign_in_wrapper").css("background-image"," ")
					$(".status").html("For some reasons registration failed.Please try again later")

		show_message = (message)->			
			@.$("#registration_status").html message
			@.$("#registration_status").show()

     