class @Thread
	constructor:(attributes)->
		@relater_id = attributes.relater_id 
		
		@transformed_message = attributes.transformed_message 

		@message_id = attributes.message_id 
		
		@sent_by_relater = attributes.sent_by_relater 

		@msg_time = attributes.msg_time