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
    
<%
	List<LoginVO> userList= MemberController.userList;
	//OrgChart oc = null;
	//if(session.getAttribute("memberLoggedIn") != null){
	//	oc = (OrgChart)session.getAttribute("memberLoggedIn");	
	//}
	OrgChart oc = (OrgChart)session.getAttribute("memberLoggedIn");
	String userId = oc.getUserId();
	int empNo = oc.getEmpNo();
%>

<script>	
	var fromId = '<%=userId%>';
	var empNo = '<%=empNo%>';
</script>
</head>
<body>
	
	<input id="hamburger" class="hamburger" type="checkbox" /> 
    <nav class="primnav">
		<img src="${pageContext.request.contextPath}/resources/image/logout.png" onclick="location.href='${pageContext.request.contextPath}/member/logout.do'" style="height:20px; width: 20px"/>
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
        <br>
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
                <a href="${pageContext.request.contextPath}/sched/cal.do">
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
            <ul class="secnav" id="">
	            <p id="channelListTitle">Channel
	            	<img src="/msg/resources/image/plus-icon.png" id="plus-icon" style="width:10px; heigth:10px;">
	            </p>
			</ul>
            <ul class="secnav" id="channelList"></ul>
            <ul class="secnav" id="dmList">
            
            </ul>
           
        </ul>
    </nav>
    <label for="hamburger" class="hamburger"> 
		<i></i>
	</label>
	<!--  Direct Message -->
    <side class="dmBar">
    	<div id="entire-container">
			<div id="title-container">
				<img src="${pageContext.request.contextPath}/resources/image/X-icon.png" id="dmClose">
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
                <img src="${pageContext.request.contextPath}/resources/image/X-icon.png" alt="" class="x-icon close" id="close-btn">
                <div id="ch-content">
                    <form action="${pageContext.request.contextPath}/chat/generateChannel.do" method="Post">
                        <div class="channelGenTitle">
                            <h3>채널만들기</h3>
                            <img src="${pageContext.request.contextPath}/resources/image/${memberLoggedIn.empImage}" id="" class="ch-member-img">
                            <img src="${pageContext.request.contextPath}/resources/image/king.svg" id="king" class="">
                        </div>

                        <input type="text" name="chName" class="ch-input" placeholder="채널명을 입력해주세요." required="required" tabindex="3">
                        <input type="text" name="chEx" class="ch-input" placeholder="채널 소개란을 입력해주세요." required="required" tabindex="4">
                        <input type="hidden" name="regId" value="${memberLoggedIn.userId }">

                        <div id="ch-member-list">
                            <table id="ch-member-table">
                                <%-- <tr>
                                    <td><img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="ch-member-list-img" class="ch-member-img"></td>
                                    <td>가디01</td>
                                    <td>해외영업부</td>
                                    <td>과장</td>
                                    <td>20122222</td>
                                    <td><img src="${pageContext.request.contextPath}/resources/image/X-icon.png" alt="" class="x-icon" id=""></td>
                                </tr> --%>
                            </table>
                        </div>
                        <div class="srchChBar">
                            <div class="select-box">
                                <div class="select-box__current" tabindex="1">
                                    <div class="select-box__value">
                                        <input class="select-box__input" type="radio" id="T1" value="emp_name" name="chSearchType" checked="checked"/>
                                        <p class="select-box__input-text">이름</p>
                                    </div>
                                    <div class="select-box__value">
                                        <input class="select-box__input" type="radio" id="T2" value="dept_name" name="chSearchType" />
                                        <p class="select-box__input-text">부서</p>
                                    </div>
                                    <div class="select-box__value">
                                        <input class="select-box__input" type="radio" id="T3" value="job_name" name="chSearchType" />
                                        <p class="select-box__input-text">직위</p>
                                    </div>
                                    <img class="select-box__icon"
                                        src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon"
                                        aria-hidden="true" />
                                </div>
                                <ul class="select-box__list">
                                    <li>
                                        <label class="select-box__option" for="T1" aria-hidden="aria-hidden">이름</label>
                                    </li>
                                    <li>
                                        <label class="select-box__option" for="T2" aria-hidden="aria-hidden">부서</label>
                                    </li>
                                    <li>
                                        <label class="select-box__option" for="T3" aria-hidden="aria-hidden">직위</label>
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