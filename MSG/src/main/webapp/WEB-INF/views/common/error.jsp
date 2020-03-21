<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERROR</title>
<style>
	body {
		padding: 50px;
		text-align: center
	
	}

	h1{
		color: red;
	}
</style>
</head>
<body>
	<h1>ERROR</h1>
	<h2><%=exception.getMessage() %></h2>
	<a href="${pageContext.request.contextPath}">인덱스 페이지로 돌아가기</a>

</body>
</html>