class @RelaterCollection extends Backbone.Collection
	model : User
	#url : chrome.extension.getBackgroundPage().base_url

	initialize :(attributes) ->
		@url = "http://lit-refuge-2289.herokuapp.com"+"/user/"+attributes.user_id+"/contacts"


