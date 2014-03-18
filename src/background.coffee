 # var oauth = ChromeExOAuth.initBackgroundPage({
 #   'request_url': 'https://www.google.com/accounts/OAuthGetRequestToken',
 #   'authorize_url': 'https://www.google.com/accounts/OAuthAuthorizeToken',
 #   'access_url': 'https://www.google.com/accounts/OAuthGetAccessToken',
 #   'consumer_key': 'anonymous',
 #   'consumer_secret': 'anonymous',
 #   'scope': 'https://www.googleapis.com/auth/userinfo#email',
 #  'app_name': 'Minion your team mate'
 # });

window.base_url = "http://localhost:3000"
window.user_to_send = null
window.message_to_send = null
relater_collections = null
sender = null
logged_in_user = null
sender_message = null
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

window.messages_with_options = []
window.options_for_message = []



chrome.browserAction.onClicked.addListener( (tab)-> chrome.windows.create( 
   url:'../popup.html'
   type:"popup"
   width:300
   height:600
   , null
))


sendMessage = ()->
    data =
      "sender":user_to_send.id
      "channel_id":user_to_send.channel_id
      "message":message_to_send.user_message
    $.post(base_url+"/calltheteam/sendmessage",data,null)


notificationandTTS = (notification_title,notification_message)->
  notification = webkitNotifications.createNotification(null,notification_title,notification_message)
  notification.show()
  # chrome.tts.speak  notification_message, null, -> if chrome.extension.lastError
  #   console.log('TTS Error: ' + chrome.extension.lastError.message)


#chrome.pushMessaging.onMessage.addListener(dissectRecievedMessage);



getTransformedMessage = (sender_name,reciever_name,transform_pattern)->
  message_transform_helper = new MessageTransformation()
  message_transform_helper.init(transform_pattern,sender_name,reciever_name)
  message_transform_helper.applyTransformation()
  message_transform_helper.getMessage()

openOptionsPopupwindow = ()->window.options_window_id = chrome.windows.create( 
    url:'../options_popup.html'
    type:"popup"
    width:300
    height:600
    , null)



dissectRecievedMessage = (payload)->
  if relater_collections != null
    sender = relater_collections.findWhere({"id":payload.user_id,"message_id":payload.message_id})
    sender_message = getTransformedMessage(sender.name,logged_in_user.name,payload.transform_pattern)
    messages = new Messages()
    messages.loadOptionsforMessage(message,openOptionsPopupwindow)
  
dissectRecievedMessage({"id":60,"message_id":9})mai
