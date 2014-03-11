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
chrome.browserAction.onClicked.addListener( (tab)-> chrome.windows.create( 
   url:'../popup.html'
   type:"popup"
   , null
))


window.sendMessage = ()->
    data =
      "sender":user_to_send.id
      "channel_id":user_to_send.channel_id
      "message":message_to_send.user_message
    $.post(base_url+"/calltheteam/sendmessage",data,null)


window.notificationandTTS = (notification_title,notification_message)->
  notification = webkitNotifications.createNotification(null,notification_title,notification_message)
  notification.show()
  # chrome.tts.speak  notification_message, null, -> if chrome.extension.lastError
  #   console.log('TTS Error: ' + chrome.extension.lastError.message)


#chrome.pushMessaging.onMessage.addListener(dissectRecievedMessage);



window.getTransformedMessage = ()->
  message_transform_helper = new MessageTransformation()
  transform_pattern = "@@1 is looking for you @@2 . @@1 he is always available @@3 . okay @@4 shut up"
  message_transform_helper.init(transform_pattern,"dinesh","ganesh","barath","kumar","could be replaced")
  message_transform_helper.applyTransformation()
  notificationandTTS "Dinesh",message_transform_helper.getMessage()
  

#getTransformedMessage()


# dissectRecievedMessage = (message)->
#   notification = webkitNotifications.createNotification(null,"Notification title","Notification Message")
#   notification.show()

    
  
