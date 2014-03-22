'use-strict';
class @InfoView extends Backbone.View
    render:(message)->
        @$el.html HAML["info_view"]({"info":message})
        @

window.loadRelaters = (user_id) ->
    contacts_view = new RelatersViewContainer()
    $(".container").html(contacts_view.render().$el)
    relater_collection = chrome.extension.getBackgroundPage().relater_collection
    window.relater_collection_view = new RelatersCollectionView({"collection":relater_collection})
    if relater_collection.models.length > 0
        $("#contacts_container").html window.relater_collection_view.render().el
    else
        $("#contacts_container").html new InfoView().render("You have no contacts!").$el
    
initialize_extension = ->
        #initialize background variables
        chrome.extension.getBackgroundPage().initializeValues()
        logged_in_user = chrome.extension.getBackgroundPage().logged_in_user
        chrome.extension.getBackgroundPage().popup_window_opened = true
        if logged_in_user is null or logged_in_user.id is null
                sign_up_view = new SignupView(loadRelaters)
                $(".container").html(sign_up_view.render().$el)
        else
            window.loadRelaters logged_in_user.id

document.addEventListener("DOMContentLoaded",initialize_extension);