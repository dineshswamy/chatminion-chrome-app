'use strict';


var window_already_created=false;
chrome.runtime.onInstalled.addListener(function (details) {
    console.log('previousVersion', details.previousVersion);
});

chrome.tabs.onUpdated.addListener(function (tabId) {
    chrome.pageAction.show(tabId);
});

chrome.browserAction.onClicked.addListener(function(tabs.Tab tabs){
		var window_properties={
				url:"popup.html",
				type:"panel"
		};
		if(!window_already_created)
		chrome.windows.create(window_properties,onWindowCreated);
});

function onWindowCreated(window)
{
	window_already_created=true;
}
