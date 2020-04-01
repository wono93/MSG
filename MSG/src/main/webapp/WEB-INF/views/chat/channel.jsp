<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/channel.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/js/channel.js">
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <section>
        <div>
            <article>
                <div class="subNav">
                    <h3>커뮤니케이션</h3>
                    <ul>
                        <li onclick="#">이메일</li>
                        <li onclick="location.href='${pageContext.request.contextPath}/chat/channel.do'">팀채널</li>
                        <li onclick="location.href='${pageContext.request.contextPath}/board/list.do'">사내게시판</li>
                        	<%-- <form action="${pageContext.request.contextPath}/chat/msgList.do" method="GET">
		                        <input type="hidden" name="toId" value="admin"/>
		                    	<!-- <input type="hidden" name="fromId" value="jhaeil"/>
		                    	<input type="hidden" name="msgNo" value="1"/>
		                    	<input type="hidden" name="msgContent" value="하위,,"/>
		                    	<input type="hidden" name="empName" value="정해일"/> -->
		                        <li>
			                        <button type="submit">DM</button>
		                        </li>
                        	</form> --%>
                     </ul>
                </div>
				<div class="content">
					<div class="control">
				        <div id="member-container">
				            <a href=""><img src="${pageContext.request.contextPath}/resources/image/img.jpg" class="member-img"></a>
				            <a href=""><img src="${pageContext.request.contextPath}/resources/image/img.jpg" class="member-img"></a>
				            <a href=""><img src="${pageContext.request.contextPath}/resources/image/img.jpg" class="member-img"></a>
				            <a href=""><img src="${pageContext.request.contextPath}/resources/image/img.jpg" class="member-img"></a>
				            <a href=""><img src="${pageContext.request.contextPath}/resources/image/img.jpg" class="member-img"></a>
				        </div>
				        <p id="title">경영지원 1팀</p>
				        <div class="btnGrp">
					        <button id="video" class="button">화상회의</button>
					        <button id="addmember" class="button">구성원 추가/삭제</button>
				        </div>
					</div>
				    <div id="channel-container">
			            <div id="hr-container">
			                <hr id="hr-left" align="left">
			                <span id="span-date">
			                    2020년 00월 00일 월요일
			                </span>
			                <hr id="hr-right" align="right">
			            </div>
			            
			            <div id="from-msg">
			                <img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="from-msg-img" class="member-img">
			                <div id="from-msg-content" class="msg-content">안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요</div>
			                <span id="from-msg-time" class="msg-time">12:00 AM</span>
			            </div>
			            
			            <div id="hr-container">
			                <hr id="hr-left" align="left">
			                <span id="span-date">
			                    2020년 00월 00일 월요일
			                </span>
			                <hr id="hr-right" align="right">
			            </div>
			
			            <div id="to-msg">
			                <img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="to-msg-img" class="member-img">
			                <div id="to-msg-content" class="msg-content">안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요</div>
			                <div id="to-msg-time" class="msg-time">12:00 AM</div>
			            </div>
			            
			            <div id="hr-container">
			                <hr id="hr-left" align="left">
			                <span id="span-date">
			                    2020년 00월 00일 월요일
			                </span>
			                <hr id="hr-right" align="right">
			            </div>
			            
			            <div id="from-msg">
			                <img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="from-msg-img" class="member-img">
			                <div id="from-msg-content" class="msg-content">안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요</div>
			                <div id="from-msg-time" class="msg-time">12:00 AM</div>
			            </div>
			            
			            <div id="hr-container">
			                <hr id="hr-left" align="left">
			                <span id="span-date">
			                    2020년 00월 00일 월요일
			                </span>
			                <hr id="hr-right" align="right">
			            </div>
			
			            <div id="to-msg">
			                <img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="to-msg-img" class="member-img">
			                <div id="to-msg-content" class="msg-content">안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요</div>
			                <div id="to-msg-time" class="msg-time">12:00 AM</div>
			            </div>
			            
			            <div id="hr-container">
			                <hr id="hr-left" align="left">
			                <span id="span-date">
			                    2020년 00월 00일 월요일
			                </span>
			                <hr id="hr-right" align="right">
			            </div>
			            
			            <div id="from-msg">
			                <img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="from-msg-img" class="member-img">
			                <div id="from-msg-content" class="msg-content">안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요</div>
			                <div id="from-msg-time" class="msg-time">12:00 AM</div>
			            </div>
			            
			            <div id="hr-container">
			                <hr id="hr-left" align="left">
			                <span id="span-date">
			                    2020년 00월 00일 월요일
			                </span>
			                <hr id="hr-right" align="right">
			            </div>
			
			            <div id="to-msg">
			                <img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="to-msg-img" class="member-img">
			                <div id="to-msg-content" class="msg-content">안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요</div>
			                <div id="to-msg-time" class="msg-time">12:00 AM</div>
			            </div>
			            
			            <div id="hr-container">
			                <hr id="hr-left" align="left">
			                <span id="span-date">
			                    2020년 00월 00일 월요일
			                </span>
			                <hr id="hr-right" align="right">
			            </div>
			            
			            <div id="from-msg">
			                <img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="from-msg-img" class="member-img">
			                <div id="from-msg-content" class="msg-content">안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요</div>
			                <div id="from-msg-time" class="msg-time">12:00 AM</div>
			            </div>
			            
			            <div id="hr-container">
			                <hr id="hr-left" align="left">
			                <span id="span-date">
			                    2020년 00월 00일 월요일
			                </span>
			                <hr id="hr-right" align="right">
			            </div>
			
			            <div id="to-msg">
			                <img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="to-msg-img" class="member-img">
			                <div id="to-msg-content" class="msg-content">안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요</div>
			                <div id="to-msg-time" class="msg-time">12:00 AM</div>
			            </div>
			            
		        	</div>
		        
		        <div id="send-msg-container">
		            <textarea name="" id="send-msg-content" cols="150" rows="5"></textarea>
		            <button id="send-msg-button" class="button">전송</button>
		        </div>
		        </div>
			</article>
		</div>
    </section>    
</body>
</html>