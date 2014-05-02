'use-strict';
class @InfoView extends Backbone.View
    render:(message)->
        @$el.html HAML["info_view"]({"info":message})
        @

window.loadRelaters = (user_id) ->
    add_relaters_view = new addRelatersView()
    relater_collection = chrome.extension.getBackgroundPage().relater_collection
    window.relater_collection_view = new RelatersCollectionView({"collection":relater_collection})
    if relater_collection.models.length > 0
        $("#relaters_of_the_user").html window.relater_collection_view.render().el
    else
        $("#relaters_of_the_user").html new InfoView().render("You have no contacts!").$el
    $("#relaters_of_the_user").append add_relaters_view.render().$el
    message_collection = chrome.extension.getBackgroundPage().messages_with_options
    message_collection_view = new MessageCollectionView({"collection":message_collection})
    $("#thread_and_messages").html message_collection_view.render().$el
    

initialize_extension = ->
        #initialize background variables
        window.peer = new Peer("fight_rigorously",key:"2n9conp4vga2a9k9")
        getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia
        # window.peer.on('call', (call)->
        # getUserMedia({video: true, audio: true}, (stream)->
        #     call.answer(stream)
        #     call.on('stream', (remoteStream)-> $("#chat_video").src(remoteStream))
        # , (err)->console.log('Failed to get local stream' ,err)
        # ))
        chrome.extension.getBackgroundPage().initializeValues()
        logged_in_user = chrome.extension.getBackgroundPage().logged_in_user
        chrome.extension.getBackgroundPage().popup_window_opened = true
        if logged_in_user is null or logged_in_user.id is null
                sign_up_view = new SignupView(loadRelaters)
                $(".container").html(sign_up_view.render().$el)
        else
            window.loadRelaters logged_in_user.id

document.addEventListener("DOMContentLoaded",initialize_extension);