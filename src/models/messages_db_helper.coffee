class @Messages

	constructor : ->
		@version = 3
		@database=null
		@transaction=null
		@messages_url=chrome.extension.getBackgroundPage().base_url+"/messages.json"
		@message_options_url=chrome.extension.getBackgroundPage().base_url+"/message_options.json"
		@db_name="calltheteam"

	init : ->
		@request = indexedDB.open(@db_name,@version)
		@request.onupgradeneeded = (event)->
			db = event.target.result
			if db.objectStoreNames.contains("messages") 
				db.deleteObjectStore("messages")
			if db.objectStoreNames.contains("message_options")
				db.deleteObjectStore("message_options")
			object_store_messages = db.createObjectStore("messages",{keyPath:"id"})
			object_store_message_options = db.createObjectStore("message_options",{keyPath:"id"})
		@request.onsuccess = (event)=>
			@database=event.target.result
			@.fetch()
			@.getAllMessages()
			#chrome.runtime.sendMessage({"messages_loaded":true},null)
		@request.onerror = (event)->
			console.log "database_logging_error" +event.value

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

	fetch :()->
    	$.get(@messages_url,(data) => @.addMessage {"id":messages.msg_id,"user_message":messages.user_message,"transform_pattern":messages.transform_pattern} for messages in data)
    	$.get(@message_options_url,(data) => @.addMessageOptions {"id":message_option.id,"message_id":message_option.message_id,"options_id":message_option.options_id} for message_option in data)

    getAllMessages:()->
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
        		chrome.extension.getBackgroundPage().messages_with_options = new MessageCollection(arr_messages_with_options)
                
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
    chrome.extension.getBackgroundPage().options_for_message = []
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
                                    chrome.extension.getBackgroundPage().options_for_message.push(messages_cursor.value);
                cursor.continue()                	
            else if callback != null and callback != undefined then callback()	
                        
