-'use-strict';
window.base_url = "http://lit-refuge-2289.herokuapp.com"
#window.base_url = "http://localhost:3000"
#window.base_url = "http://localhost:3000"
#window.base_url = "http://192.168.1.53:3000"
#window.base_url = "http://192.168.1.25:3000"
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
window.incoming_message = false

class @InfoView extends Backbone.View
    render:(message)->
        @$el.html HAML["info_view"]({"info":message})
        @

# window.loadRelaters = (user_id) ->


window.loadViews = ()->
        #initialize scroll

          
        # #initialize peer js
        # #peerJSInit()

        chrome.runtime.onMessage.addListener((message,sender,sendResponse)->window.dissectRecievedMessage(message))

        $("#start_call").click((event)->
            event.preventDefault()
            window.launchVideoCall(relater)
            )
        $("#logout_btn").click((event)->
            event.preventDefault()
            window.logOutUser()
            $(this).removeClass("glyphicon-log-out").addClass("glyphicon glyphicon-log-in")
            )
        add_relaters_view = new addRelatersView()    
        
        window.relater_collection_view = new RelatersCollectionView({"collection":window.relater_collection})
        if window.relater_collection.models.length > 0
            $("#relaters_of_the_user").html window.relater_collection_view.render().el
        else
            relater_bot = new User({"id":90009,"channel_id":window.logged_in_user.channel_id,"name":"Chatminion"})
            window.relater_collection.models.push(relater_bot)
            $("#relaters_of_the_user").html window.relater_collection_view.render().el
            $("#relaters_of_the_user").append new InfoView().render("You have no contacts!").$el

        $("#relaters_of_the_user").prepend add_relaters_view.render().$el

        $("#video_call_btn").click(launchVideoCall)
        $("#video_call_stop_btn").click(stopVideoCall)
        $("#all_messages_btn").click((event)->
          event.preventDefault()
          flipMessageCards(false)
          )
        #$("#submit_custom_message").click(sendMessage)            
        $("#relaters_of_the_user").jScrollPane();

        chrome.runtime.getBackgroundPage((page)->
          if page.window.background_message_recieved!=null 
            window.dissectRecievedMessage(page.window.background_message_recieved)
            page.window.background_message_recieved = null
          )

        initializeValues()


success_stream = (remoteStream)->
          $(".transparent-background").hide(500)
          video_call_view = new VideoCallView()
          $(".video_call_container").html(video_call_view.render().$el)
          $("#chat_video").attr("src",window.URL.createObjectURL(remoteStream))
          $(".video_call_container").show()
          #$("#video_call_modal").modal({keyboard:false})
          #$("#video_call_modal").modal('show')
          # $("#video_call_relater_name").html window.peer_js_selected_relater.name
          

success_relater_stream = (remoteStream)->
                console.log "success relater stream"
                $("#chat_video_relater").attr("src",window.URL.createObjectURL(remoteStream))

window.stopVideoCall = ()->
  event.preventDefault()
  if window.call!=null or window.call!=undefined 
     window.call.close()
  $(".video_call_container").hide(500)
  $(".transparent-background").show(500)
  $(".video_call_container").html("")

window.getPeerJSId = (id)->
  date = new Date()
  return date.getMonth()+"_"+date.getYear()+"_"+date.getDay()+"_"+id+"_peervendor"+"_"+date.getHours()

window.launchVideoCall = (event)->
  event.preventDefault()
  console.log "Trying to launch video"
  navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia
  relater_peer_js_id = window.getPeerJSId(window.peer_js_selected_relater.id)
  console.log relater_peer_js_id
  navigator.getUserMedia(video: true,audio: true,(stream)->
                              window.call = window.peer.call(relater_peer_js_id,stream)
                            window.call.on('stream',success_stream)
                        ,(err)->console.log('Failed to get local stream' ,err))

window.peerJSInit = () ->
  #peer-js id
  window.peer_js_id = window.getPeerJSId(window.logged_in_user.id)
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
  window.peer.on('close',()->
    console.log "connection closed"
    )
  window.peer.on('error',(error)->console.log("error type"+error.type))
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
    window.peer_js_selected_relater = sender
    window.incoming_message = true 
    $("a[data-relater-id='#{sender.id}']").trigger("click")
    #Nested call backs
    if payload.is_custom_message == "false"
      window.messages.getMessageInfo(Number(payload.message_id),(payload_message)->
        window.messages.loadOptionsforMessage(Number(payload.message_id),
        (options_for_message)->
          messages_collection = new MessageCollection(options_for_message)
          if payload.expect_reply == "true"
            window.openMessages(messages_collection,true)
          window.getTransformedMessage(sender,window.logged_in_user.name,payload_message.user_message,payload_message.transform_pattern,payload.message_id,payload.time,payload.read_out)
        ))
    else
        options_for_message = []
        messages_collection = new MessageCollection(options_for_message)
        if payload.expect_reply == "true"
            window.openMessages(messages_collection,true)
       window.getTransformedMessage(sender,window.logged_in_user.name,payload.custom_message,payload.custom_message,null,payload.time,payload.read_out)

window.loadRelaters = (user_id) ->
  key = "fetched_relaters_key"
  chrome.storage.local.get(key,(result)->
    #if result["fetched_relaters_key"] is null
    window.relater_collection = new RelaterCollection({"user_id":window.logged_in_user.id})
    window.relater_collection.fetch
            success : ->  
                  window.loadViews()
                  window.cacheRelaterCollection()
                  console.log "relaters retrieved"
            error : ->
    #              window.loadViews()
                  console.log "relaters retrieval error"
    # else
    #     window.relater_collection = new RelaterCollection(result["fetched_relaters_key"].models)
    #     window.loadViews()
    )



sendVideoStreampermission = (data_to_send)->
  relater_peer_js_id = "video_call_124"
  conn = window.peer.connect(relater_peer_js_id)
  conn.on('open', ()->conn.send(relater_peer_js_id))
  # conn.on('open', ()-> conn.on('data', (data)-> {
  #   console.log('Received', data);
  # });
  

window.initialize_extension = (call_back)->
    $("#option_messages").hide()
    window.messages = new Messages()
    window.messages.init(()->
      chrome.runtime.getBackgroundPage((page)-> 
        if page.window.background_message_recieved == null
          window.openMessages(window.messages_with_options,true)))

    chrome.storage.local.get ["registered","registered_user"],(result)->
        if result.registered is undefined or result.registered_user is undefined or result.registered is false or result.registered_user is null
          sign_up_view = new SignupView(window.loadRelaters)
          $("#sign_up_view").html(sign_up_view.render().$el)
          $("#sign_up_view_modal").modal({keyboard:false})
          $("#sign_up_view_modal").modal('show')
        else
            window.logged_in_user = result.registered_user
            window.setProfileAttributes(window.logged_in_user.picture,window.logged_in_user.name)
            window.loadRelaters(window.logged_in_user.id)
            
window.getTransformedMessage = (sender,reciever_name,user_message,transform_pattern,message_id,time,read_out)->
  message_transform_helper = new MessageTransformation()
  message_transform_helper.init(transform_pattern,sender.name,reciever_name)
  
  if message_id != null 
    message_transform_helper.applyTransformation()
    helper_transformed_message = message_transform_helper.getMessage()
    thread_params =
        relater:sender
        is_custom_message:false
        transformed_message:helper_transformed_message
        message_id:message_id
        sent_by_relater:true
        msg_time:time
  else
    message_transform_helper.pattern = null
    message_transform_helper.setCustomMessage(transform_pattern)
    message_transform_helper.applyTransformation()
    helper_transformed_message = message_transform_helper.getMessage()
    thread_params =
        "relater":sender
        "is_custom_message":true
        "transformed_message":user_message
        "message_id":message_id
        "sent_by_relater":true
        "msg_time":time

  if read_out=="true"
    window.speakMessage(helper_transformed_message) 
  window.putMessageinThread(thread_params)

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
    expect_reply = $("#expect_reply").prop("checked")
    read_out = $("#read_out").prop("checked")

    data =
      "sender_id":window.logged_in_user.id
      "channel_id":relater_to_send.channel_id
      "is_custom_message":is_custom_message
      "custom_message":custom_message 
      "expect_reply":expect_reply
      "read_out":read_out
      "time": time
    
    if relater_to_send.id == 90009
      data["bot_message"] = true
      # ...

    if !is_custom_message 
      data["message_id"] = message.get("id")
      thread_params =
        "relater":relater_to_send
        "transformed_message":message.get("user_message")
        "message_id":message.msg_id
        "sent_by_relater":false
        "is_custom_message":false
        "msg_time":time      
    else
      thread_params =
        "relater":relater_to_send
        "transformed_message":custom_message
        "message_id":-970
        "sent_by_relater":false
        "is_custom_message":true
        "msg_time":time
      data["message_id"] = " "

    console.log "threads"
    console.log thread_params
    
    window.putMessageinThread(thread_params)
    window.animateMessagesForSending(true)
    $.post(base_url+"/calltheteam/sendmessage",data,()-> console.log "complete")

window.putMessageinThread = (thread_params)->  
  new_thread = new Thread(thread_params)
  relater_thread_key = String("thread_"+String(thread_params["relater"].id))
  chrome.storage.local.get(relater_thread_key , (result)->
    thread = result[relater_thread_key]
    if thread == null or thread ==undefined or thread.length > 2 
      thread = []
    #The ordering of the instructions differs
    if !new_thread.sent_by_relater  
      $("#transformed_message").fadeOut(500)
      $("#thread_messages").fadeOut(500)
      thread.push(new_thread)
      result[relater_thread_key] = thread
      thread_message_view = new ThreadMessageView({collection:thread})
      $("#thread_messages").html thread_message_view.render().$el
      $("abbr.timeago").timeago()
      $("#thread_messages").fadeIn(500)    
    else
      thread_message_view = new ThreadMessageView({collection:thread})
      $("#thread_messages").html thread_message_view.render().$el
      $("abbr.timeago").timeago()
      
      if new_thread.is_custom_message
        transformed_message = new_thread.relater.name + " says "+new_thread.transformed_message
      else
        transformed_message = new_thread.transformed_message

      $("#transformed_message").html(transformed_message)
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
        console.log 
        thread_message_view = new ThreadMessageView({collection:thread})
        $("#thread_messages").html thread_message_view.render().$el
        $("abbr.timeago").timeago()
        
        if !window.incoming_message 
          setMessageOptionsFromThread(thread[thread.length-1]);        
        # checks w  
        window.incoming_message = false  
    )
window.logOutUser = ()->
        window.removeProfileAttributes()
        sign_up_view = new SignupView(window.loadRelaters)
        chrome.identity.getAuthToken({ 'interactive': true },(token)-> chrome.identity.removeCachedAuthToken({"token":token},()->))
        chrome.storage.local.set({"registered":false,"registered_user":null},null)
        key = "fetched_relaters_key"
        chrome.storage.local.set({key:null},null)
        $("#sign_up_view").html(sign_up_view.render().$el)
        $("#sign_up_view_modal").modal({keyboard:false})
        $("#sign_up_view_modal").modal('show')

window.setMessageOptionsFromThread = (last_thread_message)->
  openMessages(window.messages_with_options,false)
  # if last_thread_message == null || last_thread_message.is_custom_message
  #   openMessages(window.messages_with_options,false)
  # else 
  #   if !last_thread_message.is_custom_message and last_thread_message.message_id!=null
  #     window.messages.getMessageInfo(Number(last_thread_message.message_id),(payload_message)->
  #       window.messages.loadOptionsforMessage(Number(last_thread_message.message_id),
  #       (options_for_message)->
  #         messages_collection = new MessageCollection(options_for_message)
  #         window.openMessages(messages_collection,true)))
  #   else

window.setProfileAttributes = (profile_picture,profile_name)->
      #set profile name
       $("#profile_name").html("<h2>#{profile_name}</h2>")
       #set profile image
       xhr = new XMLHttpRequest()
       xhr.onreadystatechange = ()->
          if (this.readyState == 4 && this.status == 200)
              img = document.createElement('img')
              url = window.URL || window.webkitURL
              img.src = url.createObjectURL(this.response)
              $("#profile_image_container").html(img)
        xhr.open('GET', profile_picture)
        xhr.responseType = 'blob'
        xhr.send()

window.removeProfileAttributes = ()->
    $("#profile_name").html("")
    $("#profile_image_container").html("")


window.animateMessagesForSending = (send_status)->
  if(send_status)
    if $("#option_messages").is(':visible')
        #slide down
        $("#option_messages").animate({bottom:-320},{duration:'fast',easing:'easeOutBack'})
        $("#option_messages").html("Sending ...")
        #slide up
        $("#option_messages").animate({bottom:0},{duration:'fast',easing:'easeOutBack'});
    else if $("#messages").is(':visible') 
        $("#messages").animate({bottom:-320},{duration:'fast',easing:'easeOutBack'})
        $("#messages").html("Sending ...")
        #slide up
        $("#messages").animate({bottom:0},{duration:'fast',easing:'easeOutBack'});
  else
      window.openMessages(window.messages_with_options,false)

      

window.animateMessages = ()->
  if $("#option_messages").is(':visible')
      $("#option_messages").animate({bottom:-320},{duration:'fast',easing:'easeOutBack'}).animate({bottom:0},{duration:'fast',easing:'easeOutBack'});
  else if $("#messages").is(':visible') 
      $("#messages").animate({bottom:-320},{duration:'fast',easing:'easeOutBack'}).animate({bottom:0},{duration:'fast',easing:'easeOutBack'});

window.addRelaterToCollection = (relater)->
  window.relater_collection.add(relater)
  window.cacheRelaterCollection()
  # if call_back != null and call_back != undefined
  #   call_back(relater)
window.cacheRelaterCollection = ()->
  key = "fetched_relaters_key"
  chrome.storage.local.set({"fetched_relaters_key":window.relater_collection},()->console.log "relaters cached")

window.getRelaterThread = (sender_id)->
  window.relater_threads[sender_id]


window.speakMessage = (transformed_message)->
  chrome.tts.speak(String(transformed_message))

document.addEventListener("DOMContentLoaded",initialize_extension);