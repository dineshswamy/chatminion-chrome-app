class @FriendsCollectionView extends Backbone.View
	tagName:'ul'
	className:'friends_contacts_container'
	render : ->
		@.collection.each (model) =>
			new_friend=new FriendView({"model":model})
			@$el.append new_friend.render().$el
		@
