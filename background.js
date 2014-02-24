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

chrome.browserAction.onClicked.addListener(openPanel);

function openPanel()
{
	console.log("Inside opening panel");
	chrome.windows.create({url:'../popup.html',type:'panel'});
}