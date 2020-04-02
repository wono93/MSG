var lastID = 0;

hdjq(document).ready(function(){
	channelListFunction(0);
	console.log("ready@JS=fromId:"+fromId);
	
	var channelRepeat = setInterval(function() {
		channelListFunction(lastID);
	}, 1000);
	
//	hdjq("#").click(function(){
//		clearInterval(channelRepeat);
//	});
});


function channelListFunction(type) {
	console.log("channel@JS=type:"+type);
	var userId = hdjq("#inputUserId").val();
	console.log("userID@js="+userId);
	var chNo = hdjq("#inputChNo").val();
	console.log("chNo@js="+chNo);
	hdjq.ajax({
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
				addChat(userId, result[i][2].value, result[i][3].value, msgTime, hrDate, hideDate, result[i][5].value);
				
			}
			lastID = Number(parsed.last);
			
		}
	});
}

function addChat(userId, chatId, msgContent, msgTime, hrDate, hideDate, empImage) {
	let style = {display: "none"};
	var selHideDate =hdjq("#dm-container").children().children("p:last").text();
	console.log("작성자: "+chatId+", 내용: "+msgContent);
	if(selHideDate != hideDate){
		hdjq("#channel-container").append(
									'<div id="hr-container">'
					                +'<hr class="dmHr" id="hr-left" align="left">'
					                +'<span id="span-date">'
					                +'</span>'
					                +hrDate
					                +'<hr class="dmHr" id="hr-right" align="right">'
					                +'</div>');
	}
	if(userId == chatId ){
		hdjq("#channel-container").append(
									'<div id="from-dm">'
					                +'<img src="/msg/resources/image/'+empImage+'" id="from-dm-img" class="member-img">'
					                +'<div id="from-dm-content" class="dm-content">'+msgContent
					                +'<span id="from-dm-time" class="dm-time">'
					                +msgTime
									+'</span>'
									+'</div>'
									+'<p>'
									+hideDate
									+'</p>'
				            		+'</div>');
	}else{
		hdjq("#channel-container").append(
									'<div id="to-dm">'
						            +'<img src="/msg/resources/image/'+empImage+'" id="to-dm-img" class="member-img">'
						            +'<div id="to-dm-content" class="dm-content">'+msgContent
						            +'<span id="to-dm-time" class="dm-time">'
						            +msgTime
						            +'</span>'
						            +'</div>'
						            +'<p>'
									+hideDate
									+'</p>'
					            	+'</div>');
	}
	hdjq('#channel-container').scrollTop(hdjq('#channel-container')[0].scrollHeight);
	hdjq("#channel-container").children().children("p:last").css(style);
	
}
//
//function submitFunction() {
//	var msgContent = hdjq("#msgContent").val();
//	hdjq.ajax({
//		type : "POST",
//		url : "/msg/chat/msgInsert.do",
//		data : {
//			fromId : encodeURIComponent(fromId),
//			toId : encodeURIComponent(toId),
//			msgContent : encodeURIComponent(msgContent),
//			empNo : encodeURIComponent(empNo)
//		},
//		success : function(result) {
//			if (result == 1) {
//				autoClosingAlert('#successMessage', 2000);
//			} else if (result == 0) {
//				autoClosingAlert('#dangerMessage', 2000);
//			} else {
//				autoClosingAlert('#warningMessage', 2000);
//			}
//		}
//	});
//	hdjq('#msgContent').val('');
//}