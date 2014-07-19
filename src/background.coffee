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
window.relater_send_queue = []
window.message_to_send = null
window.relater_collection = null
sender = null
window.logged_in_user = null
sender_message = null
window.messages = null
window.transformed_message = null
window.is_custom_message = false
window.custom_message = ""
window.opened_windows = {}
window.relater_threads = {}
 

window.messages_with_options   = []
window.options_for_message = []
window.popup_params = {}

window.background_message_recieved = null

# chrome.browserAction.onClicked.addListener((tab)->
#     chrome.windows.create(
#         url:'../popup.html' 
#         width:1300
#         height:300
#         type:"popup"
#         ,null
#     ))




window.openWindow = (attributes)->
  if attributes != null
    window.background_message_recieved = {"recieved_message":attributes}
  console.log "recieved_message"
  console.log attributes
  chrome.runtime.sendMessage({"recieved_message":attributes},null)
  #if !window.is_window_opened 
  chrome.app.window.create('../popup.html', {
    id: 'app-window',
    bounds: {
      width: 600,
      height: 600,
      left: 100,
      top: 100
    },
    minWidth: 800,
    minHeight: 600
  },null)


chrome.app.runtime.onLaunched.addListener(()->window.openWindow(null))

chrome.app.window.onClosed.addListener( ()->
     console.log "reset the values"
     window.is_window_opened = false)
  

chrome.pushMessaging.onMessage.addListener((recieved_message)-> 
  console.log recieved_message
  #chrome.storage.local.get("registered",(result)->  
    #if(result["registered"] != null and result["registered"] )
  window.openWindow(recieved_message)
   #   )
  )

# (message)->
#                                         chrome.app.window.create('../popup.html', {
#                                             id: 'MyWindowID',
#                                             bounds: {
#                                               width: 800,
#                                               height: 600,
#                                               left: 100,
#                                               top: 100
#                                             },
#                                             minWidth: 800,
#                                             minHeight: 600
#                                           });

window.addSenderToQueue = (relater)->
  window.relater_send_queue.push(relater)

notificationandTTS = (notification_title,notification_message)->
  notification = webkitNotifications.createNotification(null,notification_title,notification_message)
  notification.show()
  # chrome.tts.speak  notification_message, null, -> if chrome.extension.lastError
  #   console.log('TTS Error: ' + chrome.extension.lastError.message)



window.openOptionsPopupwindow =  (sender) -> 
    if opened_windows[sender.id] == null or opened_windows[sender.id] == undefined
        options = 
            url:'../options_popup.html' 
            type:"popup" 
            frame :"none"
            width:300  
            height:600
        window.options_window_id = chrome.windows.create(options,(this_window)->
          setMessageOptions(this_window,sender))
    else
        setMessageOptions(null,sender)
    #chrome.runtime.sendMessage(window.message,null)

window.sendBroadcastMessage = ()->
  chrome.runtime.sendMessage(window.broadcast_message,null)

    
