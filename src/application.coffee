'use-strict';
initialize_extension = ->
	sign_up_view = new SignupView()
	$("body").html(sign_up_view.render().$el)
	console.log("extension init called")	
document.addEventListener("DOMContentLoaded",initialize_extension);



	