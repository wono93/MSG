<!DOCTYPE html>
<%@page import="com.kh.msg.member.controller.MemberController"%>
<%@page import="com.kh.msg.member.model.vo.LoginVO"%>
<%@page import="com.kh.msg.member.model.vo.OrgChart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.kh.msg.chat.model.vo.DirectMsg"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Enumeration" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>MSG</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/directMessage.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/channelGenerate.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/channelGenerate.css">
    <script src='https://kit.fontawesome.com/a076d05399.js'></script>
    <script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
    <script>
		var hdjq = jQuery.noConflict();
    </script>
    <script src='https://kit.fontawesome.com/a076d05399.js'></script>
    <script src="${pageContext.request.contextPath }/resources/js/channelList.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/directMessage.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/header.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/channelGenerate.js"></script>
	<!-- jQuery ui style sheet -->
	<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<!-- jQuery ui library -->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    
<%
	List<LoginVO> userList= MemberController.userList;
	//OrgChart oc = null;
	//if(session.getAttribute("memberLoggedIn") != null){
	//	oc = (OrgChart)session.getAttribute("memberLoggedIn");	
	//}
	OrgChart oc = (OrgChart)session.getAttribute("memberLoggedIn");
	String userId = oc.getUserId();
	int empNo = oc.getEmpNo();
	String deptName = oc.getDeptName();
%>

<script>	
	var fromId = '<%=userId%>';
	var empNo = '<%=empNo%>';
	var eempNo = '<%=empNo%>';
	var empDept = '<%=deptName%>' /* 민희 웰컴페이지에서 일정 받아올 때 씁니다 */ 
	hdjq(function() {
	    hdjq(".dmBar").draggable({ revert: false});
	});
</script>
</head>
<body>
	<input id="hamburger" class="hamburger" type="checkbox" /> 
    <nav class="primnav">
    	<img class="goHomeImg" src="${pageContext.request.contextPath}/resources/image/goHome.png" onclick="location.href='${pageContext.request.contextPath}/chat/main.do'"/>
		<img class="logoutImg" src="${pageContext.request.contextPath}/resources/image/logout.png" onclick="location.href='${pageContext.request.contextPath}/member/logout.do'"/>
        <div class="userinfo">
            <user id="user">
                <img src="${pageContext.request.contextPath}/resources/upload/empImg/${memberLoggedIn.empImage}" />
                <idSection>
                    <idSection>
                        <name>${memberLoggedIn.empName }</name>
                        <actions><a href="#">${memberLoggedIn.deptName }</a> | <a href="#">${memberLoggedIn.jobName }</a></actions>
                    </idSection>
                </idSection>
            </user>
        </div>
<!--         <br> -->
        <ul class="firnav">
            <li>
            	<c:choose>
            		<c:when test="${memberLoggedIn.authority ne 'N' }">
		                <a href="${pageContext.request.contextPath}/member/empLogBoard.do">    		
            		</c:when>
            		<c:otherwise>
		                <a href="${pageContext.request.contextPath}/member/empLog.do?empNo=${memberLoggedIn.empNo}">    		
            		</c:otherwise>
            	</c:choose>
                    <i class="icon far fa-id-card" style="font-size:24px"></i> 인사관리
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/edoc/srch.do">
                    <i class="icon far fa-folder" style="font-size:24px"></i> 전자문서
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/board/list.do">
                    <i class="icon far fa-comments" style="font-size:24px"></i> 커뮤니케이션
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/sched/calcover.do">
                    <i class="icon far fa-calendar-alt" style="font-size:24px"></i> 일정관리
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/res/confRes.do">
                    <i class="icon far fa-check-square" style="font-size:24px"></i> 예약관리
                </a>
            </li>
<!--             <li>
                <a href="#">
                    <i class="icon fas fa-shopping-basket" style="font-size:24px"></i> 오피스디포
                </a>
            </li> -->
            <ul class="secnav" style="margin-bottom: 4px;">
	            <p id="channelListTitle">Channel
	            	<img src="/msg/resources/image/plus-icon.png" id="plus-icon" style="width:10px; heigth:10px;">
	            </p>
			</ul>
            <ul class="secnav" id="channelList" style="height:120px;"></ul>
            <ul class="secnav" id="">
	            <p id="dmListTitle">Direct Message
	            	<input type="text" name="dmKeyword" id="srchDmWord">
                           	<a href="#" onclick="searchMember()">
	                           	<img src="${pageContext.request.contextPath}/resources/image/search-icon.png" id="dm-search-icon">
                           	</a>
	            </p>
	           	<p id="getAllReadDm">Unread:</p>
	        </ul>
            <ul class="secnav" id="dmList" style="height:223px;"></ul>
        </ul>
    </nav>
    <label for="hamburger" class="hamburger"> 
		<i></i>
	</label>
	<!--  Direct Message -->
    <side class="dmBar">
    	<div id="entire-container">
			<div id="title-container">
				<a href="#">
					<img src="${pageContext.request.contextPath}/resources/image/X-icon.png" id="dmClose">
				</a>
				<div id="name-span"></div>
			</div>
			
			<div id="dm-container"></div>
			
			<div id="send-dm-container">
					<textarea id="msgContent" style="width:78%; height:96%;"></textarea>
				<button id="send-dm-button" class="dmButton"
					onclick="submitFunction();">전송</button>
			</div>
		
        </div>
    </side> 
    
        <div id="channelGenModal" class="ch-modal">
            <!-- Modal content -->
            <div class="ch-modal-content">
	            <a href="#">
	                <img src="${pageContext.request.contextPath}/resources/image/X-icon.png" alt="" class="x-icon close" id="close-btn">
	            </a>
                <div id="ch-content">
                    <form action="${pageContext.request.contextPath}/chat/generateChannel.do" method="Post">
                        <div class="channelGenTitle">
                            <h3>채널만들기</h3>
                            <a href="#">
	                            <img src="${pageContext.request.contextPath}/resources/upload/empImg/${memberLoggedIn.empImage}" id="ch-aura" class="ch-member-img">
	                            <img src="${pageContext.request.contextPath}/resources/image/king.svg" id="ch-head">
                            </a>
                        </div>

                        <input type="text" name="chName" class="ch-input" placeholder="채널명을 입력해주세요." required="required" tabindex="3">
                        <input type="text" name="chEx" class="ch-input" placeholder="채널 소개란을 입력해주세요." required="required" tabindex="4">
                        <input type="hidden" name="regId" value="${memberLoggedIn.userId }">
                        <input type="hidden" name="regEmpNo" value="${memberLoggedIn.empNo }">

                        <div id="ch-member-list">
                            <table id="ch-member-table">
                            	<tr>
                            		<td><img src="/msg/resources/upload/empImg/${memberLoggedIn.empImage }" id="ch-member-list-img" class="ch-member-img"></td>
                            		<td>${memberLoggedIn.empName }</td>
                            		<td>${memberLoggedIn.deptName }</td>
                            		<td>${memberLoggedIn.jobName }</td>
                            		<td class="delNo">${memberLoggedIn.empNo }</td>
                            		<td></td>
									<input type="hidden" name="empNo" value="${memberLoggedIn.empNo }">
								</tr>
                            </table>
                        </div>
                        <div class="channel_srchChBar">
                            <div class="channel_select-box">
                                <div class="channel_select-box__current" tabindex="1">
                                    <div class="channel_select-box__value">
                                        <input class="channel_select-box__input" type="radio" id="T1" value="emp_name" name="chSearchType" checked="checked"/>
                                        <p class="channel_select-box__input-text">이름</p>

                                    </div>
                                    <div class="select-box__value">
                                        <input class="channel_select-box__input" type="radio" id="T2" value="dept_name" name="chSearchType" />
                                        <p class="channel_select-box__input-text">부서</p>
                                    </div>
                                    <div class="channel_select-box__value">
                                        <input class="channel_select-box__input" type="radio" id="T3" value="job_name" name="chSearchType" />
                                        <p class="channel_select-box__input-text">직위</p>
                                    </div>
                                    <img class="channel_select-box__icon"
                                        src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon"
                                        aria-hidden="true" />
                                </div>
                                <ul class="channel_select-box__list">
                                    <li>
                                        <label class="channel_select-box__option" for="T1" aria-hidden="aria-hidden">이름</label>
                                    </li>
                                    <li>
                                        <label class="channel_select-box__option" for="T2" aria-hidden="aria-hidden">부서</label>
                                    </li>
                                    <li>
                                        <label class="channel_select-box__option" for="T3" aria-hidden="aria-hidden">직위</label>
                                    </li>
                                </ul>
                            </div>
                            <input type="text" name="chKeyword" id="srchChWord" tabindex="1">
                           	<a href="#" onclick="searchMemberCh()" tabindex="2">
	                           	<img src="${pageContext.request.contextPath}/resources/image/search-icon.png" id="ch-search-icon">
                           	</a>
                            <div class="chDivBtn">
                                <button type="submit" class="ch-button">확인</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
	</div>
        
        
</body>
</html>