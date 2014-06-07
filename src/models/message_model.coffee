class @Message extends Backbone.Model
	initialize :(attributes)->
		@message_id=attributes.message_id
		@user_message=attributes.user_message
		@transform_pattern=attributes.transform_pattern