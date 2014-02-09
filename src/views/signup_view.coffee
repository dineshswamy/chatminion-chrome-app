class @SignupView extends Backbone.View
	
	tagName : 'div'
	
	className : 'sign_up'
	
	events : 
		'click#submit_email' :'register'

	initialize : ->
		console.log "signup view initialized"

	register : (event) ->
		event.preventDefault()
		console.log("Registered successfully")
	
	render : ->
		@$el.html HAML['signup']()
		@

