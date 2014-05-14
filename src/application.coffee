'use-strict';
class @InfoView extends Backbone.View
    render:(message)->
        @$el.html HAML["info_view"]({"info":message})
        @

window.loadRelaters = (user_id) ->
    add_relaters_view = new addRelatersView()
    #relater_collection = chrome.runtime.getBackgroundPage((page)-> page.relater_collection)
    base_url = chrome.runtime.getBackgroundPage((page)-> page.base_url)
    console.log "Base URL"
    console.log base_url 
    # window.relater_collection_view = new RelatersCollectionView({"collection":relater_collection})
    # if relater_collection.models.length > 0
    #     $("#relaters_of_the_user").html window.relater_collection_view.render().el
    # else
    #     $("#relaters_of_the_user").html new InfoView().render("You have no contacts!").$el
    # $("#relaters_of_the_user").append add_relaters_view.render().$el
    # message_collection = window.bpage.messages_with_options
    # message_collection_view = new MessageCollectionView({"collection":message_collection})
    # $("#thread_and_messages").html message_collection_view.render().$el
    

initialize_extension = ->
        #initialize background variables
        window.peer =  new Peer('fight_rigorously', {key: '2n9conp4vga2a9k9'})
        window.peer.on('call', (call)->
                    navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia;
                    navigator.getUserMedia({video: true, audio: true}, (stream)->
                        call.answer(stream)
                        call.on('stream',success_stream)
                    , (err)->console.log('Failed to get local stream' ,err)
                    )
        )
        
        $("#start_call").click((event)->
            event.preventDefault()
            navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia
            navigator.getUserMedia(video: true,audio: true,(stream)->
                            call = window.peer.call('fight_rigorously_2', stream)
                            call.on('stream',success_stream)
                        ,(err)->console.log('Failed to get local stream' ,err)))
        
        #chrome.extension.getBackgroundPage().initializeValues()
        
        #window.logged_in_user = chrome.extension.getBackgroundPage().logged_in_user
        # if logged_in_user is null or logged_in_user.id is null
        #         sign_up_view = new SignupView(loadRelaters)
        #         $(".container").html(sign_up_view.render().$el)
        # else
        #     window.loadRelaters logged_in_user.id
success_stream = (remoteStream)->
                $("#chat_video").attr("src",window.URL.createObjectURL(remoteStream))

document.addEventListener("DOMContentLoaded",initialize_extension);