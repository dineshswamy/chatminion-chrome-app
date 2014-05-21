class @Thread extends Backbone.Model
	
	initialize:(attributes)->
		@relater_id = attributes.relater_id if attributes.relater_id is not null or attributes.relater_id is not undefined
		
		@transformed_message = attributes.transformed_message if attributes.transformed_message is not null or attributes.transformed_message is not undefined

		@message_id = attributes.message_id if attributes.message_id is not null or attributes.message_id is not undefined
		
		@sent_by_relater = attributes.sent_by_relater if attributes.sent_by_relater is not null or attributes.sent_by_relater is not undefined