<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/edocSrchRead.css">
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/4c554cd518.js" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
    <title>edocSrchRead</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <section>
        <div>
            <article>
                <div class="subNav">
                    <h3>전자결재</h3>
                    <ul>
                        <li onclick="location.href='${pageContext.request.contextPath}/edoc/srch.do'">문서검색</li>
                        <li onclick="location.href='${pageContext.request.contextPath}/edoc/list.do'">내문서함</li>
                        <li onclick="location.href='${pageContext.request.contextPath}/edoc/write.do'">문서기안</li>
                     </ul>
                </div>
                <div class="content">
                    <div class="control">

                        <div class="leftGrp">
                            <h1>재직증명서 발급 요청</h1>
                        </div>
                        <div class="rightGrp">
                            <button type="button" name="" id="downBtn" class="whiteBtn commonBtn" onclick="location.href='${pageContext.request.contextPath}/edoc/srch.do'">목록</button>
                        </div>
                    </div>
                    <div class="tbRow">
						<iframe src="getHiddenAddr.do?attachId=${attachId }" frameborder="0" style="width:88%;height:100%">
						</iframe>
                    </div>
                </div>
            </article>
        </div>
    </section>
</body>
</html>