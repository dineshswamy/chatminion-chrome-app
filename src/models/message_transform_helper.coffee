class @MessageTransformation
	init : (transform_pattern,options...)->
		@transform_pattern=transform_pattern
		@options=options

	applyTransformation : ()->
		for option,index in @options
			#indexes in arrays starts with 0 , so increment it to match pattern
			index = index+1
			str_to_search = new RegExp("@@#{index}",'g')
			@transform_pattern=@transform_pattern.replace str_to_search,option

	getMessage : ()->
		@transform_pattern