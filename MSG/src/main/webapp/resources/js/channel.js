var chLastID = 0;
var chjq = jQuery.noConflict();

chjq(document).ready(function(){
	channelMemberFunction();
//	setInterval(function() {
//		channelMemberFunction();
//	}, 10000);
});
function channelMemberFunction() {
	var chName = chjq("#inputChName").val();
	
	var chNo = chjq("#inputChNo").val();
	chjq.ajax({
		type : "GET",
		url : "/msg/chat/channelMember.do",
		dataType: "json",
		data:{chNo: chNo},
		success : function(data) {
			hdjq("#channel-title").html(chName);
			for (var i = 0; i < data.length; i++) {
				addChannelMember(data[i]['empImage'],data[i]['regId'],data[i]['userId']);
			}
		}
	});
	hdjq('#channel-member-container').empty();
}
function addChannelMember(empImage, regId, userId){
//	console.log(empImage);
	if(userId == regId){
		hdjq("#channel-member-container").append('<a href="#">'
				+'<img src="/msg/resources/image/king.svg" id="head">'
				+'<img src="/msg/resources/image/'+empImage+'" class="channel-member-img" id="head-aura">'
				+'</a>');
	}
	else{
		hdjq("#channel-member-container").append('<a href="#"><img src="/msg/resources/image/'+empImage+'" class="channel-member-img" id="public"></a>');
	}
}


chjq(document).ready(function(){
	channelFunction(0);
	var channelRepeat = setInterval(function() {
		channelFunction(chLastID);
	}, 1000);
//	console.log(chLastID+"@interval");
	
//	chjq("#").click(function(){
//		clearInterval(channelRepeat);
//	});
});


function channelFunction(type) {
	var userId = chjq("#inputUserId").val();
	var chNo = chjq("#inputChNo").val();
	chjq.ajax({
		cache: false,
		type : "post",
		url : "/msg/chat/channelContent.do",
		data : {
			userId : userId,
			chNo : chNo,
			listType : type
		},
		success : function(data) {
			if (data == "") return;
			var parsed = JSON.parse(data);
			var result = parsed.result;
			for (var i = 0; i < result.length; i++) {
				var originDate = result[i][4].value;
				var year = originDate.substring(23,28);
				var subMonth = originDate.substring(4,7);
				var day = originDate.substring(8,10);
				if(day < 10){
					day = day.substring(1,2);
				}
				var date = new Date(year+"/"+subMonth+"/"+day);
		        var week = new Array('일','월','화','수','목','금','토');
		        var dayOfWeek = week[date.getDay()];
				var month = date.getMonth()+1;
				var hrDate = year+"년 "+month+"월 "+day+"일 "+dayOfWeek+"요일";
				var hour = originDate.substring(11,13);
				var minute = originDate.substring(14,16);
				var timeType = "AM";
				var hideDate = hrDate;
				if(hour >= 12){
					timeType = "PM";
					hour -= 12;
				}else{
					hour = hour.substring(1,2);
				}
				var msgTime = hour+":"+minute+" "+timeType;
				addChannelChat(fromId, result[i][2].value, result[i][3].value, msgTime, hrDate, hideDate, result[i][5].value);
				
			}
			chLastID = Number(parsed.last);
//			console.log(chLastID+"@ajax");
			
		}
	});
}

function addChannelChat(userId, chatId, msgContent, msgTime, hrDate, hideDate, empImage) {
	let style = {display: "none"};
	var selHideDate =chjq("#channel-container").children().children("p:last").text();
//	console.log("아이디:"+userId+", 작성자:"+chatId+", 내용:"+msgContent);
//	console.log("selHideDate="+selHideDate+", hideDate="+hideDate);
	if(selHideDate != hideDate){
		chjq("#channel-container").append(
									'<div id="channel-hr-container">'
					                +'<hr class="channel-dmHr" id="channel-hr-left" align="left">'
					                +'<span id="channel-span-date">'
					                +'</span>'
					                +hrDate
					                +'<hr class="channel-dmHr" id="channel-hr-right" align="right">'
					                +'</div>');
	}
	if(userId != chatId ){
		chjq("#channel-container").append(
									'<div id="channel-from-msg">'
					                +'<img src="/msg/resources/image/'+empImage+'" id="channel-from-msg-img" class="channel-member-img">'
					                +'<div id="channel-from-msg-content" class="channel-msg-content">'+msgContent
					                +'<span id="channel-from-msg-time" class="channel-msg-time">'
					                +msgTime
									+'</span>'
									+'</div>'
									+'<p>'
									+hideDate
									+'</p>'
				            		+'</div>');
	}else{
		chjq("#channel-container").append(
									'<div id="channel-to-msg">'
						            +'<img src="/msg/resources/image/'+empImage+'" id="channel-to-msg-img" class="channel-member-img">'
						            +'<div id="channel-to-msg-content" class="channel-msg-content">'+msgContent
						            +'<span id="channel-to-msg-time" class="channel-msg-time">'
						            +msgTime
						            +'</span>'
						            +'</div>'
						            +'<p>'
									+hideDate
									+'</p>'
					            	+'</div>');
	}
	chjq('#channel-container').scrollTop(chjq('#channel-container')[0].scrollHeight);
	chjq("#channel-container").children().children("p:last").css(style);
	
}

function channelSubmitFunction() {
	var chNo = chjq("#inputChNo").val();
	var userId = fromId;
	var msgContent = chjq("#channel-send-msg-content").val();
	chjq.ajax({
		type : "POST",
		url : "/msg/chat/channelMsgInsert.do",
		data : {
			chNo : encodeURIComponent(chNo),
			empNo : encodeURIComponent(empNo),
			userId : encodeURIComponent(userId),
			msgContent : encodeURIComponent(msgContent)
		},
		success : function(result) {
			if (result == 1) {
				autoClosingAlert('#successMessage', 2000);
			} else if (result == 0) {
				autoClosingAlert('#dangerMessage', 2000);
			} else {
				autoClosingAlert('#warningMessage', 2000);
			}
		}
	});
	chjq('#channel-send-msg-content').val('');
	
}