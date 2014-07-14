class @RelaterCollection extends Backbone.Collection
	model : User

	initialize :(attributes) ->
		@url = window.base_url+"/user/"+attributes.user_id+"/contacts"


