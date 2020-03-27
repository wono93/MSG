<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle" />
</jsp:include>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/M_DirectMessage.css">
<style>
#entire-container {
	margin-left: 200px;
    width: fit-content;
    box-shadow: -5px -5px 30px 5px grey;
}
</style>
<%
	String userId = "admin";
	String toId = "jhaeil";
%>
<script>
	var lastID = 0;

	function submitFunction() {
		var toId = '<%=toId%>';
		var fromId = '<%=userId%>';
		var msgContent = hdjq("#msgContent").val();
		
		hdjq.ajax({
			type : "POST",
			url : "./msgInsert.do",
			data : {
				fromId : encodeURIComponent(fromId),
				toId : encodeURIComponent(toId),
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
		hdjq('#msgContent').val('');
	}

	function autoClosingAlert(selecter, delay) {
		var alert = hdjq(selecter).alert();
		alert.show();

		window.setTimeout(function() {
			alert.hide()
		}, delay);
	}

 	function chatListFunction(type) {
		var toId = '<%=toId%>';
		var fromId = '<%=userId%>';
		hdjq.ajax({
			type : "POST",
			url : "./msgList.do",
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
					addChat(result[i][2].value, result[i][3].value, msgTime, hrDate, hideDate);
				}
				lastID = Number(parsed.last);
			}
		});
	}

	function addChat(toId, msgContent, msgTime, hrDate, hideDate) {
        let style = {
	            display: "none"
	        };
		var selHideDate =hdjq("#dm-container").children().children("p:last").text();
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
		if(toId == 'admin'){
			hdjq("#dm-container").append(
										'<div id="from-dm">'
						                +'<img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="from-dm-img" class="member-img">'
						                +'<div id="from-dm-content" class="dm-content">'+msgContent+'</div>'
						                +'<span id="from-dm-time" class="dm-time">'
						                +msgTime
										+'</span>'
										+'<p>'
										+hideDate
										+'</p>'
					            		+'</div>');
		}else{
			hdjq("#dm-container").append(
										'<div id="to-dm">'
							            +'<img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="to-dm-img" class="member-img">'
							            +'<div id="to-dm-content" class="dm-content">'+msgContent+'</div>'
							            +'<span id="to-dm-time" class="dm-time">'
							            +msgTime
							            +'</span>'
							            +'<p>'
										+hideDate
										+'</p>'
						            	+'</div>');
		}
		hdjq('#dm-container').scrollTop(hdjq('#dm-container')[0].scrollHeight);
		hdjq("#dm-container").children().children("p:last").css(style);
	}
	function getInfiniteChat() {
		setInterval(function() {
 			chatListFunction(lastID);
		}, 1000);
	}

</script>
<div id="entire-container">
	<!--  Direct Message -->
	<div id="title-container">
		<img
			src="${pageContext.request.contextPath}/resources/image/X-icon.png"
			alt="" id="dmClose">
		<div id="name-span">${dm.empName}</div>
	</div>
	<div id="dm-container">
	
	</div>

	<div id="send-dm-container">
		<textarea id="msgContent" cols="60" rows="6"></textarea>
		<button id="send-dm-button" class="dmButton"
			onclick="submitFunction();">전송</button>
	</div>

</div>
<script>
	hdjq(document).ready(function(){
		chatListFunction('ten');
		getInfiniteChat();
	});
	
</script>
