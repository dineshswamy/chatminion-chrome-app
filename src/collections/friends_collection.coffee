class @FriendCollection extends Backbone.Collection
	
	model : FriendModel
	url : chrome.extension.getBackgroundPage().base_url

	initialize :(attributes) ->
		@url = chrome.extension.getBackgroundPage().base_url+"/"+attributes.user_id+"/contacts"


