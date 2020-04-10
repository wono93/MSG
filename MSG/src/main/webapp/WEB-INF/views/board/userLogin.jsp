<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import = "java.util.Enumeration" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 목록</title>
</head>
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
    <script src="${pageContext.request.contextPath }/resources/js/channelList.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/directMessage.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/header.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/channelGenerate.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/directMessage.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/channelGenerate.css">
    <script src='https://kit.fontawesome.com/a076d05399.js'></script>
    <script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
<body>
	<ul class="" id="userLogin">
		<c:forEach items="${userList }" var="u">
            <c:forEach items="${memberList }" var= "m">
	            <c:if test="${u.id==m.userId }">
	            	<li>
						 <i class="fas fa-circle" style="font-size:15px; color:green;  margin-right:5px;"></i>	
						 <a href="#" onclick=""> 
						 <img src="'/msg/resources/image/'${m.empImage}" class="member-img">
						 <span class="headerlistname">${m.empName } ${m.jobCd }</span>
				 	</li>
	            </c:if>
	            <c:if test="${u.id!=m.userId }">
	            	<li>
						 <i class="fas fa-circle" style="font-size:15px; color:gray;  margin-right:5px;"></i>	
						 <a href="#" onclick=""> 
						 <img src="'/msg/resources/image/'${m.empImage}" class="member-img">
						 <span class="headerlistname">${m.empName } ${m.jobCd }</span>
				 	</li>
	            </c:if>
            </c:forEach>
		</c:forEach>
    </ul>
</body>
</html>