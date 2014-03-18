class @RelaterCollection extends Backbone.Collection
	model : User
	url : chrome.extension.getBackgroundPage().base_url

	initialize :(attributes) ->
		@url = chrome.extension.getBackgroundPage().base_url+"/user/"+attributes.user_id+"/contacts"


class @MessageCollection extends Backbone.Collection
	model:Message
	url:chrome.extension.getBackgroundPage().base_url
	initialize : (attributes)->
		@url=@url+"/messages.json"