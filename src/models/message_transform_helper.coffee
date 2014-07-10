class @MessageTransformation
	init : (transform_pattern,options...)->
		@pattern=transform_pattern
		@options=options

	setCustomMessage : (message)->
		@custom_message = message

	applyTransformation : ()->
		if @pattern != null
			for option,index in @options
				#indexes in arrays starts with 0 , so increment it to match pattern
				index = index+1
				str_to_search = new RegExp("@@#{index}",'g')
				@pattern=@pattern.replace str_to_search,option
		else
			console.log "went inside this"
			@pattern = @options[0]+" says "+@custom_message
			console.log @pattern

	getMessage : ()->
		@pattern