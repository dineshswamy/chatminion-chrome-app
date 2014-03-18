class @Message extends Backbone.Model
	initialize :(attributes)->
		@msg_id=attributes.msg_id
		@user_message=attributes.user_message
		@transform_pattern=attributes.transform_pattern