'use-strict';
initialize_extension = ->
	if !localStorage["registered"] and localStorage["registered_user_id"]!=null
		sign_up_view = new SignupView()
		$("body").html(sign_up_view.render().$el)
	else
		loadRelators(localStorage["registered_user_id"])

document.addEventListener("DOMContentLoaded",initialize_extension);


loadRelators = (user_id)->
				relater_collection = new RelaterCollection({"user_id":user_id})
				relater_collection.fetch
					success : -> 
							relater_collection_view = new RelatersCollectionView({"collection":relater_collection})
							$("body").html relater_collection_view.render().el