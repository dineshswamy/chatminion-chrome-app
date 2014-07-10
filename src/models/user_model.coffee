class @User extends Backbone.Model
	initialize :(attributes) ->
		@url = window.base_url+"/calltheteam/register"
		if attributes.channel_id
			@channel_id=attributes.channel_id
		if attributes.name
			@name=attributes.name
		if attributes.id
			@id = attributes.id
	# parse :(response)->
	# 	return response

	set_attributes: (attributes)->		
		@channel_id = attributes.channel_id
		@email = attributes.email
		@gender = attributes.gender
		@given_name = attributes.given_name
		@google_oauth_token = attributes.google_oauth_token
		@gplus_link = attributes.gplus_link
		@id = attributes.id
		@name = attributes.name
		@picture = attributes.picture



