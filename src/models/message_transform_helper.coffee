class @MessageTransformation
	init : (transform_pattern,options...)->
		@pattern=transform_pattern
		@options=options

	applyTransformation : ()->
		for option,index in @options
			#indexes in arrays starts with 0 , so increment it to match pattern
			index = index+1
			str_to_search = new RegExp("@@#{index}",'g')
			console.log @pattern
			@transformed_message=@pattern.replace str_to_search,option

	getMessage : ()->
		@transformed_message