'use-strict';
class @InfoView extends Backbone.View
    render:(message)->
        @$el.html HAML["info_view"]({"info":message})
        @

loadRelators = (user_id) ->
    contacts_view = new RelatersViewContainer()
    $(".container").html(contacts_view.render().$el)
    relater_collection = chrome.extension.getBackgroundPage().relater_collection
    if relater_collection.models.length > 0
        relater_collection_view = new RelatersCollectionView({"collection":relater_collection})
        $("#contacts_container").html relater_collection_view.render().el
    else
        $("#contacts_container").html new InfoView().render("You have no contacts!").$el
    
initialize_extension = ->
        logged_in_user = chrome.extension.getBackgroundPage().logged_in_user
        console.log logged_in_user
        if logged_in_user is null or logged_in_user.id is null
                sign_up_view = new SignupView(loadRelators)
                $(".container").html(sign_up_view.render().$el)
        else
            loadRelators logged_in_user.id

document.addEventListener("DOMContentLoaded",initialize_extension);