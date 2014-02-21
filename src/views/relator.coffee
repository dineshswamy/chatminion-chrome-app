class @FriendView extends Backbone.View
	tagName:'li'
	className:'available_contact'
	initialize:(attributes) ->


	render: ->
		@$el.html HAML["friend"](model:@model)
		@