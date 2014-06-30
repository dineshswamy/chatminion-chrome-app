class @SignupView extends Backbone.View
	
	tagName : 'div'
	
	className : 'sign_up form-group'
	
	events : 
		'click a#google_sign_in' :'register'

	initialize :(attributes) ->
		@call_back=attributes
		console.log "signup view initialized"

	register : (event) ->
		event.preventDefault()		
		console.log "register clicked"
		chrome.pushMessaging.getChannelId(false,complete_registration)
		#oauth=window.bpageoauth
		#oauth.authorize(onauthorized)
	complete_registration = (google_chrome_channel_id) ->
		console.log google_chrome_channel_id
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
					#$("#profile_image_container").html("<img src = '#{window.logged_in_user.picture}'/>")
					set_profile_image(window.logged_in_user.picture)
					$("#profile_name").html("<h2>#{window.logged_in_user.name}</h2>")
					$(".status").html("Registered successfully")
					chrome.storage.local.set {"registered":true,"registered_user":model},null
					$("#sign_up_view_modal").modal('hide')	
					#@call_back(model.get("user_id"))
				else if model.get("status")=="failure"
					$(".status").html("For some reasons registration failed.Please try again later")
					chrome.storage.local.set {"registered":false,"registered_user":null},null
				else
					$(".status").html(model.get("status"))
					chrome.storage.local.set {"registered":false,"registered_user":null},null
					
			error : ->
					$(".status").html("For some reasons registration failed.Please try again later")

	set_profile_image = (image_url)->
			 xhr = new XMLHttpRequest()
		 
			 xhr.onreadystatechange = ()->
	    		if (this.readyState == 4 && this.status == 200)
	        		handler(this.response)
	        		console.log(this.response, typeof this.response)
	        		img = document.getElementById('img')
	        		url = window.URL || window.webkitURL
	        		img.src = url.createObjectURL(this.response)
	        		$("#profile_image_container").html(img)

				xhr.open('GET', image_url)
				xhr.responseType = 'blob'
				xhr.send()     