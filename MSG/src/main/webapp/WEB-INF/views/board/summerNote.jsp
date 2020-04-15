<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
<html lang="en">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/boardWrite.css">
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/4c554cd518.js" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

    <title>boardWrite</title>
</head>
<body>
<section>
        <div>
            <article style="width: 1200; height: 100%;">
                <div class="subNav">
                    <h3>커뮤니케이션</h3>
                    <ul>
                        <li onclick="#">이메일</li>
                        <li onclick="location.href='${pageContext.request.contextPath}/board/list.do'">사내게시판</li>
                     </ul>
                </div>
                <br>
                <br>
                <br>

				<div style="height:100%">
					<iframe src="${pageContext.request.contextPath }/board/write.do" name="iframeWrite" align="right" scrolling="no" frameborder="0" marginheight="50" marginwidth="0" width="100%" height="900px"></iframe>

				</div>
    	</article>
	</div>
</section>
		
		
</body>
</html>