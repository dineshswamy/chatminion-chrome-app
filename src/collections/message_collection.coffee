class @MessageCollection extends Backbone.Collection
	model:Message
	#url:chrome.extension.getBackgroundPage().base_url
	initialize : (attributes)->
		@url="http://lit-refuge-2289.herokuapp.com"+"/messages.json"