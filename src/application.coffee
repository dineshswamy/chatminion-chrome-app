-'use-strict';
#window.base_url = "http://lit-refuge-2289.herokuapp.com"
#window.base_url = "http://10.0.0.6:3000"
#window.base_url = "http://192.168.1.53:3000"
window.base_url = "http://localhost:3000"
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
window.bool = true
#peer js relater selected
window.peer_js_selected_relater = null


class @InfoView extends Backbone.View
    render:(message)->
        @$el.html HAML["info_view"]({"info":message})
        @

# window.loadRelaters = (user_id) ->

window.loadViews = ()->
        #initialize scroll

        
        #initialize peer js
        peerJSInit()

        chrome.runtime.onMessage.addListener((message,sender,sendResponse)->window.dissectRecievedMessage(message))
        
        $("#start_call").click((event)->
            event.preventDefault()
            window.launchVideoCall(relater)
            )
        
        add_relaters_view = new addRelatersView()    
        
        window.relater_collection_view = new RelatersCollectionView({"collection":window.relater_collection})
        if window.relater_collection.models.length > 0
            $("#relaters_of_the_user").html window.relater_collection_view.render().el
        else
            $("#relaters_of_the_user").html new InfoView().render("You have no contacts!").$el
        
        $("#relaters_of_the_user").prepend add_relaters_view.render().$el
        
        window.messages = new Messages()
        window.messages.init(()->
                  window.openMessages(window.messages_with_options,true)
                  )

        $("#video_call_btn").click(launchVideoCall)
        $("#video_call_stop_btn").click(stopVideoCall)
        $("#all_messages_btn").click((event)->
          event.preventDefault()
          console.log "messages btn pressed"
          flipMessageCards(false)
          )
        #$("#submit_custom_message").click(sendMessage)
            
        $("#relaters_of_the_user").jScrollPane();
        initializeValues()


success_stream = (remoteStream)->
                $("#text_messages").hide()
                $("#video_container").show()
                $("#chat_video").attr("src",window.URL.createObjectURL(remoteStream))

success_relater_stream = (remoteStream)->
                console.log "success relater stream"
                $("#chat_video_relater").attr("src",window.URL.createObjectURL(remoteStream))

window.stopVideoCall = (event)->
  event.preventDefault()
  if window.call!=null or window.call!=undefined 
     window.call.close()
  $("#video_container").hide()
  $("#text_messages").show()

window.launchVideoCall = (event)->
  event.preventDefault()
  $("#text_messages").hide()
  $("#video_container").show()
  console.log "Trying to launch video"
  navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia
  relater_peer_js_id = window.peer_js_selected_relater.id+"_peervendor"
  console.log relater_peer_js_id
  navigator.getUserMedia(video: true,audio: true,(stream)->
                            window.call = window.peer.call(relater_peer_js_id,stream)
                            window.call.on('stream',success_stream)
                        ,(err)->console.log('Failed to get local stream' ,err))


window.peerJSInit = () ->
  #peer-js id
  window.peer_js_id = logged_in_user.id+"_peervendor"
  window.peer =  new Peer(window.peer_js_id,key:'2n9conp4vga2a9k9')
  window.peer.on('call', (call)->
                    console.log "You have a video call"
                    navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia;
                    navigator.getUserMedia(video: true, audio: true, (stream)->
                        call.answer(stream)
                        call.on('stream',success_stream)
                    , (err)->console.log('Failed to get local stream' ,err)
                    )
        )
  # window.peer.on('connection', (conn)->conn.on('data',(data)->
  #                                                             console.log "data recieved" 
  #                                                             console.log data
  #                                                             show_or_hide_video_stream(data))) 


show_or_hide_video_stream = (data)->
  console.log "data"
  console.log data
  if data == null or data == undefined or data == "no_video_stream"
    $("#chat_video_relater").hide()
  else if data == "yes_video_stream"
    $("#chat_video_relater").show()


window.dissectRecievedMessage = (message)->
  ## initialize values 
  recieved_message = message.recieved_message
  if window.relater_collection != null
    payload = JSON.parse(recieved_message.payload)
    console.log payload
    sender = window.relater_collection.findWhere({"id":Number(payload.user_id)})
    $("div[data-relater-id='#{sender.id}']").trigger("click")
    #Nested call backs
    if payload.is_custom_message == "false"
      window.messages.getMessageInfo(Number(payload.message_id),(payload_message)->
        window.messages.loadOptionsforMessage(Number(payload.message_id),
        (options_for_message)->
          messages_collection = new MessageCollection(options_for_message)
          window.openMessages(messages_collection,true)
          window.getTransformedMessage(sender,window.logged_in_user.name,payload_message.transform_pattern,payload.message_id,payload.time)
        ))
    else
       window.getTransformedMessage(sender,window.logged_in_user.name,payload.custom_message,null,payload.time)

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

sendVideoStreampermission = (data_to_send)->
  relater_peer_js_id = "video_call_124"
  conn = window.peer.connect(relater_peer_js_id)
  conn.on('open', ()->conn.send(relater_peer_js_id))
  # conn.on('open', ()-> conn.on('data', (data)-> {
  #   console.log('Received', data);
  # });
  

window.initialize_extension = (call_back)->
    $("#option_messages").hide()
    window.logged_in_user = new User({id:50,email_id:"dinesh@jekyll.com",channel_id:"10479555667324687884/lglphigimhjobmiebamlihaadifjdcck",name:"dineshswamy"})
    loadRelaters(window.logged_in_user.id,call_back)
    # chrome.storage.local.get ["registered","registered_user"],(result)->
    #     if result.registered is undefined or result.registered_user is undefined
    #             sign_up_view = new SignupView(loadRelaters)
    #             $("#sign_up_view").html(sign_up_view.render().$el)
    #             $("#sign_up_view_modal").modal({keyboard:false})
    #             $("#sign_up_view_modal").modal('show')
    #     else
    #         window.logged_in_user = result.registered_user
            
                
window.getTransformedMessage = (sender,reciever_name,transform_pattern,message_id,time)->
  message_transform_helper = new MessageTransformation()
  message_transform_helper.init(transform_pattern,sender.name,reciever_name)
  
  if message_id != null or message_id != undefined
    message_transform_helper.applyTransformation()
  else
    message_transform_helper.pattern = null
    message_transform_helper.setCustomMessage(transform_pattern)
    message_transform_helper.applyTransformation()

  transformed_message = message_transform_helper.getMessage()
  window.speakMessage(transformed_message)
  window.putMessageinThread(sender,transformed_message,message_id,true,time)  

window.initializeValues = ()->
  window.user_to_send = null
  window.message_to_send = null
  window.transformed_message = null
  window.is_custom_message = false
  window.custom_message = ""
  window.options_for_message = []

window.flipMessageCards = (show_options_messages)->
  if(show_options_messages)
      $("#messages").hide()
      $("#messages").empty()
      $("#option_messages").show()
  else
      $("#option_messages").hide()
      $("#option_messages").empty()
      $("#messages").show()

      
      



window.setMessageOptions = (sender_window,sender)->
    window.broadcast_message =
        "relater_id":window.logged_in_user.id
        "relater_to_send":sender.toJSON()
        "transformed_message":window.transformed_message
    window.sendBroadcastMessage()

window.sendMessage = ()->
  #for relater_to_send in window.relater_send_queue
    is_custom_message =  !$("#custom_message").prop("disabled")
    custom_message = $("#custom_message").val()
    relater_to_send = window.peer_js_selected_relater
    message = window.message_to_send
    time = String(new Date())
    data =
      "sender_id":window.logged_in_user.id
      "channel_id":relater_to_send.channel_id
      "is_custom_message":is_custom_message
      "custom_message": custom_message 
      "time": time

    if !is_custom_message 
      data["message_id"] = message.get("id")
      console.log data["message_id"]
      window.putMessageinThread(relater_to_send,message.user_message,true,message.msg_id,time)
    else
      window.putMessageinThread(relater_to_send,custom_message,false,time)
      data["message_id"] = " "

    $.post(base_url+"/calltheteam/sendmessage",data,()->console.log "call the team")

window.putMessageinThread = (relater,message,message_id,sent_by_relater,time)->  
  console.log "Message at"
  console.log time
  thread_params =
    relater_id:relater.id
    transformed_message:message
    message_id:message_id
    sent_by_relater:sent_by_relater
    msg_time:time
  new_thread = new Thread(thread_params)
  relater_thread_key = String("thread_"+String(relater.id))
  chrome.storage.local.get(relater_thread_key , (result)->
    thread = result[relater_thread_key]
    if thread == null or thread ==undefined or thread.length > 2 
      thread = []
    thread.push(new_thread)
    result[relater_thread_key] = thread
    chrome.storage.local.set(result,()->console.log "thread message saved")
    )



window.openMessages = (message_collection,is_option_message)->
  messages_collection_view = new MessageCollectionView({"collection":message_collection})
  if(is_option_message)
    $("#option_messages").html messages_collection_view.render().$el
  else
    $("#messages").html messages_collection_view.render().$el
  flipMessageCards(is_option_message)
  animateMessages()
  

window.loadMessagesofRelater = (relater_id)->
  relater_thread_key = String("thread_"+String(relater_id))
  thread = null
  chrome.storage.local.get(relater_thread_key,(result)->
      thread = result[relater_thread_key]
      if thread != null and thread != undefined 
        thread_message_view = new ThreadMessageView({collection:thread})
        $("#thread_messages").html thread_message_view.render().$el
        $("abbr.timeago").timeago()
        animateMessages();
    )

window.animateMessages= ()->
  $("#option_messages").animate({bottom:-320},{duration:'fast',easing:'easeOutBack'}).animate( {bottom:0},{duration:'fast',easing:'easeOutBack'});

window.addRelaterToCollection = (relater,call_back)->
  window.relater_collection.add(relater)
  if call_back != null and call_back != undefined
    call_back(relater)

window.getRelaterThread = (sender_id)->
  window.relater_threads[sender_id]


window.speakMessage = (transformed_message)->
  chrome.tts.speak(String(transformed_message))

document.addEventListener("DOMContentLoaded",initialize_extension);