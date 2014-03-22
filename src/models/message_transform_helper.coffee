class @MessageTransformation
	init : (transform_pattern,options...)->
		@pattern=transform_pattern
		@options=options

	applyTransformation : ()->
		if @pattern != null
			for option,index in @options
				#indexes in arrays starts with 0 , so increment it to match pattern
				index = index+1
				str_to_search = new RegExp("@@#{index}",'g')
				@pattern=@pattern.replace str_to_search,option
		else
			@pattern = @options[0]+" says "+chrome.extension.getBackgroundPage().transformed_message

	getMessage : ()->
		@pattern