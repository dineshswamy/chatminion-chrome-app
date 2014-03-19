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
window.relater_collection = null
sender = null
window.logged_in_user = null
sender_message = null
messages = null
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


window.sendMessage = ()->
    data =
      "sender_id":window.user_to_send.id
      "channel_id":window.user_to_send.channel_id
      "message_id":window.message_to_send.id
    $.post(base_url+"/calltheteam/sendmessage",data,null)


notificationandTTS = (notification_title,notification_message)->
  notification = webkitNotifications.createNotification(null,notification_title,notification_message)
  notification.show()
  # chrome.tts.speak  notification_message, null, -> if chrome.extension.lastError
  #   console.log('TTS Error: ' + chrome.extension.lastError.message)


#chrome.pushMessaging.onMessage.addListener(dissectRecievedMessage);



window.getTransformedMessage = (sender_name,reciever_name,transform_pattern)->
  message_transform_helper = new MessageTransformation()
  message_transform_helper.init(transform_pattern,sender_name,reciever_name)
  message_transform_helper.applyTransformation()
  window.transformed_message = message_transform_helper.getMessage()
  openOptionsPopupwindow()

window.openOptionsPopupwindow = ()->window.options_window_id = chrome.windows.create( 
    url:'../options_popup.html'
    type:"popup"
    width:300
    height:600
    , null)


window.dissectRecievedMessage = (payload)->
  if window.relater_collection != null
    sender = window.relater_collection.findWhere({"id":payload.user_id})
    window.user_to_send = sender
    window.messages_with_options = new MessageCollection(window.messages_with_options)
    payload.message = window.messages_with_options.findWhere({"id":payload.message_id})
    messages.loadOptionsforMessage(payload.message_id)
    sender_message = getTransformedMessage(sender.name,window.logged_in_user.name,payload.message.transform_pattern)



initialize_extension = ->
    chrome.storage.local.get ["registered","registered_user"],(result)->
        if result.registered is undefined or result.registered_user is undefined
                window.logged_in_user = null
        else
            window.logged_in_user = result.registered_user
            loadRelators(window.logged_in_user.id)
  

loadRelators = (user_id) ->
    window.relater_collection = new RelaterCollection({"user_id":user_id})
    window.relater_collection.fetch
                  success : -> 
                        messages = new Messages()
                        messages.init()
                        console.log "relaters retrieved"
                  error : ->
                        console.log "relaters retrieval error"



initialize_extension()