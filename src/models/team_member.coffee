class @User extends Backbone.Model
	initialize : ->
		@url = chrome.extension.getBackgroundPage().base_url+"/calltheteam/register"

	defaults :
			email_id : "sample@email.com"
			channel_id :"channel_id_sample"

