class @User extends Backbone.Model
	initialize :(attributes) ->
		@url = window.base_url+"/calltheteam/register"
		if attributes.email_id
			@email_id=attributes.email_id
		if attributes.channel_id
			@channel_id=attributes.channel_id
		if attributes.name
			@name=attributes.name
		if attributes.id
			@id = attributes.id


	defaults :
			email_id : "sample@email.com"
			channel_id :"channel_id_sample"
	# parse :(response)->
	# 	return response



