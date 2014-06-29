class @Thread
	constructor:(attributes)->

		@relater = attributes.relater
		
		@transformed_message = attributes.transformed_message 

		@message_id = attributes.message_id 
		
		@sent_by_relater = attributes.sent_by_relater 

		@msg_time = attributes.msg_time

		@is_custom_message = attributes.is_custom_message