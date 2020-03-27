<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <link rel="stylesheet" href="css/header.css">
    <script src="https://kit.fontawesome.com/4c554cd518.js" crossorigin="anonymous"></script>
</head>
<style>
.welcomeBox {
    opacity: 0.4;
    position: absolute;
    top: 355px;
    width: 100%;
    height: 100%;
    z-index: 0;
    font-size: 30px;
    text-align: center;
}
.welcomeBox p {
	font-size: 34px;
	margin: 0;
	font-weight: 900;
}
</style>
<script>
</script>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="welcomeBox">
	<img src="${pageContext.request.contextPath}/resources/image/msgLogoGray.png" />
	<p>"회사가 먼저다"</p>
</div>

</body>
</html>
