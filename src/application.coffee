'use-strict';
class @InfoView extends Backbone.View
    render:(message)->
        @$el.html HAML["info_view"]({"info":message})
        @

loadRelators = (user_id) ->
    contacts_view = new RelatersViewContainer()
    $(".container").html(contacts_view.render().$el)
    window.relater_collection = new RelaterCollection({"user_id":user_id})
    window.relater_collection.fetch
        success : -> 
            chrome.extension.getBackgroundPage().relater_collections = relater_collection
            if window.relater_collection.models.length > 0
                relater_collection_view = new RelatersCollectionView({"collection":window.relater_collection})
                $("#contacts_container").html relater_collection_view.render().el
            else
                $("#contacts_container").html new InfoView().render("You have no contacts!").$el
    messages = new Messages()
    messages.init()




initialize_extension = ->
    chrome.storage.local.get ["registered","registered_user"],(result)->
        if result.registered is undefined or result.registered_user is undefined
                sign_up_view = new SignupView(loadRelators)
                $(".container").html(sign_up_view.render().$el)
        else
            window.logged_in_user = result.registered_user
            chrome.extension.getBackgroundPage().logged_in_user = result.registered_user
            loadRelators result.registered_user.id

document.addEventListener("DOMContentLoaded",initialize_extension);