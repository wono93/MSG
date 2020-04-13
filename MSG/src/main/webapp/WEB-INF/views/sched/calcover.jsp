<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>MSG :: 일정관리</title>
	<style>
	html{background-color: #ededed;}
	section{ position: absolute; text-align: center; width: 100%; height: 100%; left: 0; top: 0; }
	section > div { display: inline-block; width: 1200px; height: 100%; vertical-align: middle; /* border: 1px solid black; */ }
	.center1200{ width: 1200px; margin:0 auto; position: relative;}
	.center1200::after{content:""; display:block; clear:both;}
	.center1200>h3{ margin:75px 0 0 60px; font-size:36px; font-weight:900;text-align:left;}
	.center1200 li:first-of-type{margin-left:60px;}
	.center1200 li{list-style: none; float: left; margin: 30px 65px 30px 0; font-size: 21px; font-family: 'Noto Sans KR'; color:#999; cursor: pointer;}
	.container{width:1200px; margin:0 auto; padding:30px; min-height: 100px; padding:48px 0 0 53px;background-color:#fff;}
	#containert>span{font-size:30px; margin-left: 30px;}
	
	</style>

    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:400,500,600">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

    
</head>

<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<input type="hidden" id="userEmpNo" value="${memberLoggedIn.empNo}" /> 
<input type="hidden" id="userEmpName" value="${memberLoggedIn.empName}" /> 
<input type="hidden" id="userDeptName" value="${memberLoggedIn.deptName}" /> 
<input type="hidden" id="userJobName" value="${memberLoggedIn.jobName}" /> 
    <section>
        <div>
            <article>
			 	<div class="center1200">
			        <h3>일정관리</h3>
			        <div style="height:20px; width:100%;"></div>
			    </div>
			    <!-- <div class="container"> -->
			    <iframe src="${pageContext.request.contextPath }/sched/cal.do" style="width:1900px; height:1200px; border:none;">
			    </iframe>
				<!-- </div> -->
				<div style="height:50px; width:100%;"></div>
			</article>
		</div>
	</section>
</body>
</html>