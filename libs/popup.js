'use strict';

document.addEventListener("DOMContentLoaded",function()
{

			window.addEventListener("keyup",keyUpListener,false);
			var sign_up_view = new SignupView;
			console.log(sign_up_view.render());
			$("body").html(sign_up_view.render().el);

});

function keyUpListener(event)
{
	if(e.keyCode == 27)
		
}

// function addFriends(event)
// {
// 	event.preventDefault();
// 	var URL="http://192.168.1.160:3000/jarviz/register";
// 	//var channelId=call_back_params.channelId;
// 	var data={email:"email_id",friends_email:$("#friends_email").val()};
// 	$.post(URL,data,showSuccess);
	
// }

// function register_with_server(call_back_params)
// {
// 	console.log(call_back_params);
// 	var URL="http://192.168.1.160:3000/jarviz/register";
// 	var email_id=$("#user_email").val();
// 	//var channelId=call_back_params.channelId;
// 	var data={email:email_id,channel_id:call_back_params};
// 	console.log("Completed storage");
// 	localStorage["registered"]=true;
// 	$.post(URL,data,showSuccess);
// }

// function showSuccess(status)
// {
// 	// chrome.storage.sync.set({"registered":true},function(){
// 	// 	console.log("value stored");
// 	// });
// 	$("#form_to_submit").empty();
// 	$("#form_to_submit").html("<h3>"+status+"<h3>");
// }

// function getAllContacts(response)
// {
// 	contacts_array=jQuery.parseJSON(response);
// 	html_to_attach="";
// 	for(var i=0;i<contacts_array.length;i++)
// 	{
// 		html_to_attach+="<li data-email='"+contacts_array[i]+"'>"+contacts_array[i]+"</li>";
// 	}
// 	$("#available_friends_view").html(html_to_attach);
// 	$("#available_friends_view li").click(function(){
		
// 	});
// }

