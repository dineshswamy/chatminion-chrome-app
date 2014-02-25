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
chrome.app.runtime.onLaunched.addListener(function() {
  chrome.app.window.create('../popup.html', {
    "bounds": {
      "width": 500,
      "height": 650
    },
  });
});

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

chrome.runtime.onMessage.addListener(function(request,sender,sendResponse){

	console.log("Message recieved "+request.close_window);
	if(request.close_window)
		if(chrome.app.window.current())
			chrome.app.window.current().close();

});

// function getWindowId(Window window)
// {
// 	window_id=window.id;
// }

