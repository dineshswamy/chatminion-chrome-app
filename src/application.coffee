'use-strict';
initialize_extension = ->
	# if !localStorage["registered"] and localStorage["registered_user_id"]!=null
	# 	sign_up_view = new SignupView()
	# 	$("body").html(sign_up_view.render().$el)
	# else
		loadRelators(localStorage["registered_user_id"])

document.addEventListener("DOMContentLoaded",initialize_extension);


loadRelators = (user_id)->
				relater_collection = new RelaterCollection({"user_id":user_id})
				relater_collection.fetch
					success : -> 
							relater_collection_view = new RelatersCollectionView({"collection":relater_collection})
							$("#contacts_container").html relater_collection_view.render().el

				message_collection = new MessageCollection()
				message_collection.fetch
					success : ->
							 message_collection_view = new MessageCollectionView({"collection":message_collection})
							 $("#messages_container").html message_collection_view.render().el
					error :->
							console.log("Error occurred while parsing messages")
check_and_addRelator = (add_relator_id) ->
				data =
					relator_id:add_relator_id
				url	= chrome.extension.getBackgroundPage().base_url+"/calltheteam/addcontact"
				$.post(url,data,callback_check_and_addRelator);

callback_check_and_addRelator = (response_data)->
#				switch response_data.status 
#					when response_data.status=="success" then add_relator(response_data)
#					when response_data.status=="user_not_registered" then openGmailForRequest()
#					else display_response(response)


# set_alert = (alert_type,alert_message,alert_dom_id)->
# 		switch alert_type			
# 			when alert_type=="info" then 
# 				$("#"+alert_dom_id).addClass("")




