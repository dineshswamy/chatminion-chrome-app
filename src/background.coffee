 # var oauth = ChromeExOAuth.initBackgroundPage({
 #   'request_url': 'https://www.google.com/accounts/OAuthGetRequestToken',
 #   'authorize_url': 'https://www.google.com/accounts/OAuthAuthorizeToken',
 #   'access_url': 'https://www.google.com/accounts/OAuthGetAccessToken',
 #   'consumer_key': 'anonymous',
 #   'consumer_secret': 'anonymous',
 #   'scope': 'https://www.googleapis.com/auth/userinfo#email',
 #  'app_name': 'Minion your team mate'
 # });

base_url = "http://localhost:3000"
#window_id=null;
# var 
user_to_send = null
# var 
message_to_send = null
#  chrome.app.runtime.onLaunched.addListener(function() {
#    chrome.app.window.create('../popup.html', {
#      "bounds": {
#        "width": 500,
#        "height": 650
#     },
#    });
#  });

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

messages_with_options = []
chrome.app.runtime.onLaunched.addListener( ()-> 
  chrome.app.window.create("../popup.html",
      bounds: 
         width: 360
         height: 300
         left: 600
      minWidth: 220
      minHeight: 220
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



getTransformedMessage = ()->
  message_transform_helper = new MessageTransformation()
  transform_pattern = "@@1 is looking for you @@2 . @@1 he is always available @@3 . okay @@4 shut up"
  message_transform_helper.init(transform_pattern,"dinesh","ganesh","barath","kumar","could be replaced")
  message_transform_helper.applyTransformation()
  notificationandTTS "Dinesh",message_transform_helper.getMessage()
  

#getTransformedMessage()


# dissectRecievedMessage = (message)->
#   notification = webkitNotifications.createNotification(null,"Notification title","Notification Message")
#   notification.show()

    
  
