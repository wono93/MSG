var lastID = 0;
var toId = "";

hdjq(function(){
    hdjq(".dmBar").hide();
});

hdjq(function(){
    hdjq("#dmClose").click(function(){
    	hdjq('#dm-container').empty();
    	hdjq("#name-span").empty();
    	hdjq(".dmBar").fadeOut(100);
    	toId = "";
    	console.log(toId);
    })
});
hdjq(document).ready(function(){
	dmListFunction();
	setInterval(function() {
		dmListFunction();
	}, 10000);
});
function dmListFunction() {
	hdjq.ajax({
		type : "GET",
		url : "/msg/chat/headerDmList.do",
		dataType: "json",
		success : function(data) {
			hdjq("#dmList").html('<p>Direct Message</p>');
			for (var i = 0; i < data.length; i++) {
				addList(data[i]['empImage'], data[i]['empName'], data[i]['jobName'], data[i]['toId']);
			}
			
		}
	});
}
function addList(empImage, empName, jobName, toId) {
	
	hdjq("#dmList").append(
						 '<li>'+
			             '<a onclick="dmWindow('+"'"+toId+"', '"+empName+"'"+');">'+
						 '<img src="/msg/resources/image/'+empImage+'">'+
						 '<span class="headerlistname">'+empName+' '+
//						 jobName+
						 '</span>'+
						 '</a>'+
						 '</li>');
}


function dmWindow(paramId, empName){
	hdjq('#dm-container').empty();
	hdjq("#name-span").html(empName);
	hdjq(".dmBar").fadeIn(100);
	toId = paramId;
	chatListFunction(0, toId, fromId);
	console.log("dmWindow@JS=toId:"+toId+", fromId:"+fromId);
	
	var repeat = setInterval(function() {
		chatListFunction(lastID, toId, fromId);
	}, 1000);
	
	hdjq("#dmClose").click(function(){
		console.log("닫기");
		clearInterval(repeat);
	});
	
	
}
function autoClosingAlert(selecter, delay) {
	var alert = hdjq(selecter);
	alert.show();

	window.setTimeout(function() {
		alert.hide()
	}, delay);
}

function submitFunction() {
	var msgContent = hdjq("#msgContent").val();
	hdjq.ajax({
		type : "POST",
		url : "/msg/chat/msgInsert.do",
		data : {
			fromId : encodeURIComponent(fromId),
			toId : encodeURIComponent(toId),
			msgContent : encodeURIComponent(msgContent),
			empNo : encodeURIComponent(empNo)
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
	hdjq('#msgContent').val('');
}

function chatListFunction(type, toId, fromId) {
	console.log("chatList@JS=toId:"+toId+", fromId:"+fromId);
	hdjq.ajax({
		cache: false,
		type : "POST",
		url : "/msg/chat/msgList.do",
		data : {
			fromId : encodeURIComponent(fromId),
			toId : encodeURIComponent(toId),
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
				addChat(result[i][2].value, result[i][3].value, msgTime, hrDate, hideDate, result[i][5].value, fromId);
				
			}
			lastID = Number(parsed.last);
			
		}
	});
}

function addChat(toId, msgContent, msgTime, hrDate, hideDate, empImage, fromId) {
		let style = {display: "none"};
	var selHideDate =hdjq("#dm-container").children().children("p:last").text();
	console.log("작성자: "+toId+", 내용: "+msgContent);
	if(selHideDate != hideDate){
		hdjq("#dm-container").append(
									'<div id="hr-container">'
					                +'<hr class="dmHr" id="hr-left" align="left">'
					                +'<span id="span-date">'
					                +'</span>'
					                +hrDate
					                +'<hr class="dmHr" id="hr-right" align="right">'
					                +'</div>');
	}
	if(toId == fromId ){
		hdjq("#dm-container").append(
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
		hdjq("#dm-container").append(
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
	hdjq('#dm-container').scrollTop(hdjq('#dm-container')[0].scrollHeight);
	hdjq("#dm-container").children().children("p:last").css(style);
	
}

