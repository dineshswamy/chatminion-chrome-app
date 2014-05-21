'use-strict';
window.base_url = "http://lit-refuge-2289.herokuapp.com"
#window.base_url = "http://localhost:3000"
window.relater_send_queue = []
window.message_to_send = null
window.relater_collection = null
sender = null
window.logged_in_user = null
sender_message = null
window.messages = null
window.transformed_message = null
window.popup_window_opened = false
window.is_custom_message = false
window.custom_message = ""
window.messages_with_options = null

class @InfoView extends Backbone.View
    render:(message)->
        @$el.html HAML["info_view"]({"info":message})
        @

# window.loadRelaters = (user_id) ->

window.loadViews = ()->
        #initialize background variables
        chrome.runtime.onMessage.addListener((message,sender,sendResponse)->window.dissectRecievedMessage(message))
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
        
        #add_relaters_view = new addRelatersView()    
        window.relater_collection_view = new RelatersCollectionView({"collection":window.relater_collection})
        if window.relater_collection.models.length > 0
            $("#relaters_of_the_user").html window.relater_collection_view.render().el
        else
            $("#relaters_of_the_user").html new InfoView().render("You have no contacts!").$el
        
        #$("#relaters_of_the_user").append add_relaters_view.render().$el
        
        message_collection_view = new MessageCollectionView({"collection":window.messages_with_options})
        $("#thread_and_messages").html message_collection_view.render().$el

        $("#submit_custom_message").click(sendMessage)

        initializeValues()


success_stream = (remoteStream)->
                $("#chat_video").attr("src",window.URL.createObjectURL(remoteStream))

window.dissectRecievedMessage = (recieved_message)->
  ## initialize values 
  if window.relater_collection != null
    payload = JSON.parse(recieved_message.payload)
    sender = window.relater_collection.findWhere({"id":Number(payload.user_id)})
    $("input[data-relater-id='#{sender.id}']").prop("checked",true)
    #Nested call backs
    console.log payload.is_custom_message                                     
    if payload.is_custom_message == "false"
      window.messages.getMessageInfo(Number(payload.message_id),(payload_message)->
        window.messages.loadOptionsforMessage(Number(payload.message_id),
        ()->
          window.getTransformedMessage(sender,window.logged_in_user.name,payload_message.transform_pattern)
        ))
    else
       window.transformed_message = payload.custom_message
       window.getTransformedMessage(sender,window.logged_in_user.name,null)

loadRelaters = (user_id,call_back) ->
    window.relater_collection = new RelaterCollection({"user_id":user_id})
    window.relater_collection.fetch
                  success : ->  
                        # if call_back != null and call_back != undefined
                        #   call_back()
                        window.loadViews()  
                        console.log "relaters retrieved"
                  error : ->
                        window.loadViews()
                        console.log "relaters retrieval error"

window.initialize_extension = (call_back)->
    window.messages = new Messages()
    window.messages.init()
    chrome.storage.local.get ["registered","registered_user"],(result)->
        if result.registered is undefined or result.registered_user is undefined
                sign_up_view = new SignupView(loadRelaters)
                $("#sign_up_view").html(sign_up_view.render().$el)
                $("#sign_up_view_modal").modal({keyboard:false})
                $("#sign_up_view_modal").modal('show')
        else
            window.logged_in_user = result.registered_user
            loadRelaters(window.logged_in_user.id,call_back)
                
window.getTransformedMessage = (sender,reciever_name,transform_pattern)->
  message_transform_helper = new MessageTransformation()
  message_transform_helper.init(transform_pattern,sender.name,reciever_name)
  message_transform_helper.applyTransformation()
  transformed_message = message_transform_helper.getMessage()
  window.putMessageinThread(relater,message,message_id,sent_by_relater)  
  #openOptionsPopupwindow(sender)

window.initializeValues = ()->
  window.user_to_send = null
  window.message_to_send = null
  window.transformed_message = null
  window.is_custom_message = false
  window.custom_message = ""
  window.options_for_message = []




window.setMessageOptions = (sender_window,sender)->
    window.broadcast_message =
        "relater_id":sender.id
        "relater_to_send":sender.toJSON()
        "transformed_message":window.transformed_message
    window.sendBroadcastMessage()

window.sendMessage = (message,is_custom_message,custom_message)->
  for relater_to_send in window.relater_send_queue
    data =
      "sender_id":window.logged_in_user.id
      "channel_id":relater_to_send.channel_id
      "is_custom_message":is_custom_message
      "custom_message": custom_message 

    if !is_custom_message 
      data["message_id"] = message.msg_id
      #window.putMessageinThread(relater_to_send,message.user_message,,message.msg_id)
    else
      #window.putMessageinThread(relater_to_send,custom_message,false)
      data["message_id"] = " "
    $.post(base_url+"/calltheteam/sendmessage",data,null)

window.putMessageinThread = (relater,message,message_id,sent_by_relater)->  
  
  thread_params =
    "relater_id":sent_by.id
    "transformed_message":message
    "message_id":message_id
    "sent_by_relater":sent_by_relater
  
  thread = new Thread(thread_params)
  relater_thread_key = String(relater.id)

  chrome.storage.local.set({relater_thread_key:thread},()->console.log "thread message saved")


window.openOptionsPopup = (collection)->
  options_collection = new MessageCollectionView({"collection":collection})
  $("#some_selector")



window.addRelaterToCollection = (relater,call_back)->
  window.relater_collection.add(relater)
  if call_back != null and call_back != undefined
    call_back(relater)

window.getRelaterThread = (sender_id)->
  window.relater_threads[sender_id]

document.addEventListener("DOMContentLoaded",initialize_extension);