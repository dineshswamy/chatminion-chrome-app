class @Messages

	constructor : ->
		@version = 3
		@database=null
		@transaction=null
		#@base_url = "http://lit-refuge-2289.herokuapp.com"
		#@base_url = "http://10.0.0.6:3000"
		@base_url = window.base_url
		# chrome.runtime.getBackgroundPage((page)->
		# 		console.log @messages_url
		# 	)
		@messages_url = @base_url+"/messages.json"
		@message_options_url = @base_url+"/message_options.json"
		@db_name = "calltheteam"

	init : (callback)->
		@request = indexedDB.open(@db_name,@version)
		@request.onupgradeneeded = (event)->
			db = event.target.result
			if db.objectStoreNames.contains("messages") 
				db.deleteObjectStore("messages")
			if db.objectStoreNames.contains("message_options")
				db.deleteObjectStore("message_options")
			object_store_messages = db.createObjectStore("messages",{keyPath:"id"})
			object_store_message_options = db.createObjectStore("message_options",{keyPath:"id"})
		@request.onsuccess = (event) =>
			@database=event.target.result
			chrome.storage.local.get("last_updated",(result)=>@.fetchMessages(callback,result))
			#chrome.runtime.sendMessage({"messages_loaded":true},null)
		@request.onerror = (event)->
			console.log "database_logging_error" +event.value

	fetchMessages : (callback,result)=>
		now = new Date()
		console.log "Inside fetch messages"
		
		current_date = new Date(now.getYear(),now.getMonth(),now.getDate())
		current_date_string = now.getYear()+"/"+now.getMonth()+"/"+now.getDate()

		result_last_updated = result["last_updated"]
		console.log result_last_updated
		if result_last_updated.split("/") == null 
			@.fetch(current_date_string)
			@.getAllMessages(callback)

		else
			console.log "fetchMessages"
			last_updated = result_last_updated.split("/")
			last_updated_date = new Date(last_updated[0],last_updated[1],last_updated[2])
			if last_updated_date < current_date
				@.fetch(current_date_string) # date is updated inside fetch method
				@.getAllMessages(callback)
			else
				@.getAllMessages(callback)


	addMessage : (object_to_store)->
		if @database != null 
			@transaction=@database.transaction(["messages","message_options"],"readwrite")
			@store = @transaction.objectStore("messages");
			request = @store.put(object_to_store)
			request.onsuccess = (event)->
				console.log "message successfully written"
			request.onerror = (event)->
				console.log "insertion error"

	addMessageOptions : (object_to_store)->
		if @database != null 
			@transaction=@database.transaction(["messages","message_options"],"readwrite")
			@store = @transaction.objectStore("message_options");
			request = @store.put(object_to_store)
			request.onsuccess = (event)->
				console.log "message options successfully written"
			request.onerror = (event)->
				console.log "insertion error"
	fetch:(current_date) ->
		$.get(@messages_url,
        (data) =>
	        for messages in data
	        	@.addMessage {"id":messages.msg_id,"user_message":messages.user_message,"transform_pattern":messages.transform_pattern}
	        $.get(@message_options_url,
	        (data)	=>
	        	for message_option in data
	        	   @.addMessageOptions {"id":message_option.id,"message_id":message_option.message_id,"options_id":message_option.options_id}

	           console.log current_date
	           chrome.storage.local.set({"last_updated":current_date},()-> console.log "messages_updated")   
	           @.getAllMessages())
		)

	getAllMessages:(callback)->
        arr_messages_with_options = []
        message_transactions = @database.transaction(["message_options","messages"])
        objectstore = message_transactions.objectStore("message_options")
        messages_objectstore = message_transactions.objectStore("messages")
        objectstore.openCursor().onsuccess = (event)->
        	cursor = event.target.result
        	if cursor
        		messages_objectstore.openCursor(cursor.value.message_id).onsuccess = (event)->
        			messages_cursor = event.target.result
        			arr_messages_with_options.push(messages_cursor.value)	
        			cursor.continue()
        	else
        		window.messages_with_options = new MessageCollection(arr_messages_with_options)
        		if callback!=null and callback != undefined
        			callback()
                
    getMessageInfo:(message_id,callback)->
	    @request = indexedDB.open(@db_name,@version)
	    @request.onsuccess = (event)->
	        @database=event.target.result
	        message_transactions = @database.transaction(["messages"])
	        messages_objectstore = message_transactions.objectStore("messages")
	        messages_objectstore.openCursor(message_id).onsuccess = (event)->
	            cursor = event.target.result
	            if cursor
	            	console.log cursor.value
	            	callback(cursor.value)
	            

   loadOptionsforMessage:(message_id,callback)->
    options_for_message = []
    @request = indexedDB.open(@db_name,@version)
    @request.onsuccess = (event)->
        @database=event.target.result
        message_transactions = @database.transaction(["message_options","messages"])
        objectstore = message_transactions.objectStore("message_options")
        messages_objectstore = message_transactions.objectStore("messages")
        objectstore.openCursor().onsuccess = (event)->
            cursor = event.target.result
            if cursor 
                if cursor.value.message_id == message_id
                    options = cursor.value.options_id.split(";")
                    for msg_id in options
                     messages_objectstore.openCursor(Number(msg_id)).onsuccess = (event)->
                                    messages_cursor = event.target.result
                                    options_for_message.push(messages_cursor.value)
                cursor.continue()                	
            else if callback != null and callback != undefined
          				callback(options_for_message)	
                        
