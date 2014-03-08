// var oauth = ChromeExOAuth.initBackgroundPage({
//   'request_url': 'https://www.google.com/accounts/OAuthGetRequestToken',
//   'authorize_url': 'https://www.google.com/accounts/OAuthAuthorizeToken',
//   'access_url': 'https://www.google.com/accounts/OAuthGetAccessToken',
//   'consumer_key': 'anonymous',
//   'consumer_secret': 'anonymous',
//   'scope': 'https://www.googleapis.com/auth/userinfo#email',
//   'app_name': 'Minion your team mate'
// });

var base_url="http://localhost:3000";
  var window_id=null;
var user_to_send=null;
var message_to_send=null;
// chrome.app.runtime.onLaunched.addListener(function() {
//   chrome.app.window.create('../popup.html', {
//     "bounds": {
//       "width": 500,
//       "height": 650
//     },
//   });
// });

// function openPanel()
// {
// 	console.log("Inside opening panel");
// 	chrome.app.window.create('../popup.html',{
// 		"bounds":{
// 			"width":560,
// 			"height":730
// 		}

// 	});
// }

var messages_with_options=[]



function sendMessage()
{
    console.log("sending request");
    data={
      "sender":user_to_send.id,
      "channel_id":user_to_send.channel_id,
      "message":message_to_send.user_message
    };
    $.post(base_url+"/calltheteam/sendmessage",data,null);
} 



//chrome.pushMessaging.onMessage.addListener(show_notification);

function show_notification(message)
{
    
     var notification = window.webkitNotifications.createNotification(
    '', 'New notification', message.payload + " [" + message.subchannelId + "]");
     
       notification.show();
    // chrome.tts.speak(message.payload,null,function(){
    //   if(chrome.extension.lastError)
    //   {
    //     console.log("TTS error "+ chrome.extension.lastError.message);
    //   }
    // });
}

// function getWindowId(Window window)
// {
// 	window_id=window.id;
// }

