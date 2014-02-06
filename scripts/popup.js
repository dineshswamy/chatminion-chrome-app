'use strict';

document.addEventListener("DOMContentLoaded",function()
{
	//$("#submit_email").click(register);
	
	//chrome.storage.local.get("registered",function(result){
		console.log("LocalStorage "+localStorage["registered"]);
		if(localStorage["registered"]!=undefined)
		{
				$("#add_friends_view").show();
				$("#friends_view_submit_email").click(addFriends);
				
				//get all contacts lists
				data={email:"dinesh@cheenilabs.com"};
				CONTACTS_URL="";
				$.post(CONTACTS_URL,data,getAllContacts);

		}
		else
		{
				$("#sign_up_view").show();
				$("#submit_email").click(register);
		}
	//});

});

function register(event)
{
	event.preventDefault();
	console.log("Successfully form is submitted");
	register_with_server("slkdfljlkkjakdjkajdkjakdjksdkjdkjaksjdkjsjdkjsdj");
	//Hiding the sign up form and show friends list
	$("#sign_up_view").hide();
	$("#add_friends_view").show();
	$("#friends_view_submit_email").click(addFriends);
	//chrome.pushMessaging.getChannelId(true,register_with_server);
}

function addFriends(event)
{
	event.preventDefault();
	var URL="http://192.168.1.160:3000/jarviz/register";
	//var channelId=call_back_params.channelId;
	var data={email:"email_id",friends_email:$("#friends_email").val()};
	$.post(URL,data,showSuccess);
	
}

function register_with_server(call_back_params)
{
	console.log(call_back_params);
	var URL="http://192.168.1.160:3000/jarviz/register";
	var email_id=$("#user_email").val();
	//var channelId=call_back_params.channelId;
	var data={email:email_id,channel_id:call_back_params};
	console.log("Completed storage");
	localStorage["registered"]=true;
	$.post(URL,data,showSuccess);
}

function showSuccess(status)
{
	// chrome.storage.sync.set({"registered":true},function(){
	// 	console.log("value stored");
	// });
	$("#form_to_submit").empty();
	$("#form_to_submit").html("<h3>"+status+"<h3>");
}

function getAllContacts(response)
{
	contacts_array=jQuery.parseJSON(response);
	html_to_attach="";
	for(var i=0;i<contacts_array.length;i++)
	{
		html_to_attach+="<li data-email='"+contacts_array[i]+"'>"+contacts_array[i]+"</li>";
	}
	$("#available_friends_view").html(html_to_attach);
	$("#available_friends_view li").click(function(){
		
	});
}

