 # var oauth = ChromeExOAuth.initBackgroundPage({
 #   'request_url': 'https://www.google.com/accounts/OAuthGetRequestToken',
 #   'authorize_url': 'https://www.google.com/accounts/OAuthAuthorizeToken',
 #   'access_url': 'https://www.google.com/accounts/OAuthGetAccessToken',
 #   'consumer_key': 'anonymous',
 #   'consumer_secret': 'anonymous',
 #   'scope': 'https://www.googleapis.com/auth/userinfo#email',
 #  'app_name': 'Minion your team mate'
 # });




#window.base_url = "http://localhost:3000"
window.base_url = "http://lit-refuge-2289.herokuapp.com"
window.user_to_send = null
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
window.opened_windows = {}
 # function openPanel()
 # {
 #     console.log("Inside opening panel");
 #  chrome.app.window.create('../popup.html',{
 #    "bounds":{
 #      "width":560,
 #      "height":730
 #    }

 #  });
 # }

window.messages_with_options   = []
window.options_for_message = []



# chrome.browserAction.onClicked.addListener( (tab)->
#     chrome.windows.create(
#         url:'../popup.html' 
#         type:"popup" 
#         width:300 
#         height:600 , null
#     ))

#if !window.popup_window_opened


window.sendMessage = (channel_id,message_id,is_custom_message,custom_message)->
    data =
      "sender_id":window.logged_in_user.id
      "channel_id":channel_id
      "is_custom_message":is_custom_message
      "custom_message": custom_message 

    if !is_custom_message 
      data["message_id"] = message_id
    else
      data["message_id"] = " "

    console.log "Data"
    console.log data
    $.post(base_url+"/calltheteam/sendmessage",data,null)


notificationandTTS = (notification_title,notification_message)->
  notification = webkitNotifications.createNotification(null,notification_title,notification_message)
  notification.show()
  # chrome.tts.speak  notification_message, null, -> if chrome.extension.lastError
  #   console.log('TTS Error: ' + chrome.extension.lastError.message)






window.getTransformedMessage = (sender,reciever_name,transform_pattern)->
  message_transform_helper = new MessageTransformation()
  message_transform_helper.init(transform_pattern,sender.name,reciever_name)
  message_transform_helper.applyTransformation()
  window.transformed_message = message_transform_helper.getMessage()
  openOptionsPopupwindow(sender)

window.openOptionsPopupwindow =  (sender) -> 
    if opened_windows[sender_id] == null
        options = 
            url:'../options_popup.html' 
            type:"popup" 
            width:300  
            height:600
        window.options_window_id = chrome.windows.create(options,(this_window)->
          opened_windows[sender.id] = this_window.id
          setWindowOptions(opened_window,sender))
    else
      chrome.windows.get(opened_windows[sender.id],null,(sender)->setWindowOptions(sender))

setWindowOptions = (sender_window,sender)->
  sender_window.relater_to_send = sender


window.dissectRecievedMessage = (recieved_message)->
  ## initialize values 
  console.log recieved_message
  window.initializeValues()
  if window.relater_collection != null
    payload = JSON.parse(recieved_message.payload)
    sender = window.relater_collection.findWhere({"id":Number(payload.user_id)})
    console.log sender    
    window.user_to_send = sender
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


window.initialize_extension = (call_back)->
    window.messages = new Messages()
    window.messages.init()
    chrome.storage.local.get ["registered","registered_user"],(result)->
        if result.registered is undefined or result.registered_user is undefined
                window.logged_in_user = null
        else
            window.logged_in_user = result.registered_user
            loadRelaters(window.logged_in_user.id,call_back)
            chrome.pushMessaging.onMessage.addListener(dissectRecievedMessage);
  

loadRelaters = (user_id,call_back) ->
    window.relater_collection = new RelaterCollection({"user_id":user_id})
    window.relater_collection.fetch
                  success : -> 
                        if call_back != null and call_back != undefined
                          call_back()
                        console.log "relaters retrieved"
                  error : ->
                        console.log "relaters retrieval error"

window.addRelaterToCollection = (relater,call_back)->
  window.relater_collection.add(relater)
  if call_back != null and call_back != undefined
    call_back(relater)

window.initializeValues = ()->
  window.user_to_send = null
  window.message_to_send = null
  window.transformed_message = null
  window.is_custom_message = false
  window.custom_message = ""
  window.options_for_message = []

initialize_extension()
