<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/channel.css">
    <script src="${pageContext.request.contextPath }/resources/js/channel.js"></script>
</head>
<body>
	<input type="hidden" name="userId" value="${userId }" id="inputUserId"/>
	<input type="hidden" name="chNo" value="${chNo }" id="inputChNo"/>
	<input type="hidden" name="chName" value="${chName }" id="inputChName"/>
    <section>
        <div>
            <article>
                <div class="subNav">
                    <h3>커뮤니케이션</h3>
                    <ul>
                        <li onclick="#">이메일</li>
                        <li onclick="location.href='${pageContext.request.contextPath}/board/list.do'">사내게시판</li>
                     </ul>
                </div>
				<div class="content">
					<div class="control">
				        <div id="channel-member-container">
				        </div>
				        <p id="channel-title"></p>
				        <div class="btnGrp">
					        <button id="video" class="button">화상회의</button>
					        <button id="addmember" class="button">구성원 추가/삭제</button>
				        </div>
					</div>
					
				    <div id="channel-container"></div>
		        
			        <div id="channel-send-msg-container">
			            <textarea name="" id="channel-send-msg-content" cols="150" rows="5"></textarea>
			            <button onclick="channelSubmitFunction();" id="channel-send-msg-button" class="button">전송</button>
			        </div>
		        </div>
			</article>
		</div>
    </section>    
</body>
</html>