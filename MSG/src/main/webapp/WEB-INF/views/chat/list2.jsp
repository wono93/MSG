<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/M_DirectMessage.css">
<style>
		#dm-containerr{
			margin-left: 200px;
		}
</style>
<%
	String empName = request.getParameter("empName");
	Date nowDate = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy년 M월 d일");
	pageContext.setAttribute("nowDate", sf.format(nowDate));
%>
<script>
/* 	var lastID = 0;
	$(document).ready(function() {
		getInfiniteChat();
	});
	function getInfiniteChat() {
		setInterval(function() {
			chatListFunction(lastID);
		}, 1000);
	} */
	/* function chatListFunction(type) {
		console.log("chatListFunction()");
		var chatName = ${toId};
		var chatContent = ${msgContent};
		console.log(chatName);
		$.ajax({
			type : "POST",
			url : "${pageContext.request.contextPath}/chat/list",
			data : {
				listType : type,
			},
			success : function(data) {
				if (data == "")
					return;

				var parsed = JSON.parse(data);
				var result = parsed.result;
				for (var i = 0; i < result.length; i++) {
					addChat(result[i][0].value, result[i][1].value,
							result[i][2].value);
				}
				lastID = Number(parsed.last);
			}
		});
	} */
	/* function submitFunction(){
		console.log("submitFunction()")		
		var fromId = ${fromId};
		var toId = ${toId};
		var msgContent = $('#send-dm-content').val();
		$.ajax({
			type: "POST",
			url: "${pageContext.request.contextPath}/chat/insert",
			data: { 
				fromId: fromId,
				toId: toId,
				msgContent: msgContent,
			},
			function(result){
				if(result == 1) {
					autoClosingAlert('#successMessage',2000);
				}else if (result == 0){
					autoClosingAlert('#dangerMessage',2000);
				}else{
					autoClosingAlert('#warningMessage',2000);
			}
		});
		$('#send-dm-content').val('');
	} */
		/* 		
	function addChat(toId, msgContent, msgDate) {
		console.log("addChat()")	
		if(toId == 'admin'){
			$('#dm-container').append(
								 '<div id="from-dm">'
					                +'<img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="from-dm-img" class="member-img">'
					                +'<div id="from-dm-content" class="dm-content">${msgContent}</div>'
					                +'<span id="from-dm-time" class="dm-time">'
					               		+'<fmt:formatDate value="${msgDate}" pattern="K:m a"/>'
									+'</span>'
				            	+'</div>');
		}else{
			$('#dm-container').append(
								 '<div id="to-dm">'
						            +'<img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="to-dm-img" class="member-img">'
						            +'<div id="to-dm-content" class="dm-content">${msgContent}</div>'
						            +'<div id="to-dm-time" class="dm-time">'
						            	+'<fmt:formatDate value="${msgDate}"pattern="K:m a"/>'
						            +'</div>'
					            +'</div>');
		}
		$('#dm-container').scrollTop($('#dm-container')[0].scrollHeight);
	}

	function autoClosingAlert(selector, delay){
		var alert = $(selector).alert();
		alert.show();
		window.setTimeout(function() {alert.hide()}, delay);
	}
		 */
</script>
<div id="dm-containerr">
	<!--  Direct Message -->
        <div id="title-container">
                <img src="${pageContext.request.contextPath}/resources/image/X-icon.png" alt="" id="dmClose">
                <div id="name-span">${empName}</div>
        </div>
        <div id="dm-container">
			
		<%-- <c:if test="${not empty list}">
			<c:forEach items="${list}" var="d">
				<c:set value="admin" var="admin"/>
				<c:set value="jhaeil" var="jhaeil"/>
				
			    <c:if test="${admin ne d.toId}">
	            <div id="from-dm">
	                <img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="from-dm-img" class="member-img">
	                <div id="from-dm-content" class="dm-content">${d.msgContent}</div>
	                <span id="from-dm-time" class="dm-time">
	                	<fmt:formatDate value="${d.msgDate}" pattern="K:m a"/>
					</span>
	            </div>
	        	</c:if>
	        	
	        	<div style="display:none">
					<fmt:formatDate value="${d.msgDate}" pattern="yyyy년 M월 d일" var="nowDate1"/>
	        	</div> --%>
	        	
<%-- 	        	<c:if test="${nowDate1 ne nowDate }">
		        	<div id="hr-container">
		                <hr class="dmHr" id="hr-left" align="left">
		                <span id="span-date">
			        	<fmt:formatDate value="${d.msgDate}" pattern="yyyy년 M월 d일 E요일"/>
		                </span>
		                <hr class="dmHr" id="hr-right" align="right">
	            	</div>
	        	</c:if> --%>
	        	
	        	
			<%--     <c:if test="${admin eq d.toId}">
				<div id="to-dm">
	                <img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="to-dm-img" class="member-img">
	                <div id="to-dm-content" class="dm-content">${d.msgContent}</div>
	                <div id="to-dm-time" class="dm-time">
	                <fmt:formatDate value="${d.msgDate}" pattern="K:m a"/>
	                </div>
	            </div>
	        	</c:if>
	        	
			</c:forEach>
       </c:if>
             --%>
        </div>
        
        <div id="send-dm-container">
	            <textarea name="" id="send-dm-content" cols="60" rows="5"></textarea>
	            <button id="send-dm-button" class="dmButton" onclick="submitFunction();">전송</button>
        </div>
        
		<div class="" id="successMessage" style="display:none;">
			<Strong>메시지 전송에 성공했습니다.</Strong>
		</div>
		<div class="" id="dangerMessage" style="display:none;">
			<Strong>이름과 내용을 모두 입력해주세요.</Strong>
		</div>
		<div class="" id="warningMessage" style="display:none;">
			<Strong>데이터베이스 오류가 발생했습니다.</Strong>
		</div>
 </div>
