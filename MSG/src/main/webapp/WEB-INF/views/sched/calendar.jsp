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

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/fullCalendar/vendor/css/fullcalendar.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/fullCalendar/vendor/css/bootstrap.min.css">
    <link rel="stylesheet" href='${pageContext.request.contextPath}/resources/fullCalendar/vendor/css/select2.min.css' />
    <link rel="stylesheet" href='${pageContext.request.contextPath}/resources/fullCalendar/vendor/css/bootstrap-datetimepicker.min.css' />
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:400,500,600">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/fullCalendar/css/main.css">
    
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
			            <ul>
			                <li>내 일정</li>
			                <li onclick="location.href='${pageContext.request.contextPath}/res/confRes.do'">회의실</li>
			                <li onclick="location.href='${pageContext.request.contextPath}/res/carRes.do'">법인차량</li>
			             </ul>
			    </div>
			    <div class="container">
			
			        <!-- 일자 클릭시 메뉴오픈 -->
			        <div id="contextMenu" class="dropdown clearfix">
			            <ul class="dropdown-menu dropNewEvent" role="menu" aria-labelledby="dropdownMenu"
			                style="display:block;position:static;margin-bottom:5px;">
			                <li><a tabindex="-1" href="#">개인일정</a></li>
			                <li><a tabindex="-1" href="#">팀 일정</a></li>
			                <li><a tabindex="-1" href="#">부서 일정</a></li>
			                <li><a tabindex="-1" href="#">회사 일정</a></li>
			                <li class="divider"></li>
			                <li><a tabindex="-1" href="#" data-role="close">Close</a></li>
			            </ul>
			        </div>
			
			        <div id="wrapper">
			            <div id="loading"></div>
			            <div id="calendar"></div>
			        </div>
			
			
			        <!-- 일정 추가 MODAL -->
			        <div class="modal fade" tabindex="-1" role="dialog" id="eventModal">
			            <div class="modal-dialog" role="document">
			                <div class="modal-content">
			                	<form name="schedFrm" >
				                    <div class="modal-header">
				                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
				                                aria-hidden="true">&times;</span></button>
				                        <h4 class="modal-title"></h4>
				                    </div>
				                    <div class="modal-body">
				                        <div class="row">
				                            <div class="col-xs-12">
												<input type="hidden" id="edit-id" /><!-- 예약코드 -->
												<input type="hidden" id="emp-no" class="emp-no"/>
												<input type="hidden" id="emp-name" class="emp-name"/>
												<input type="hidden" id="dept-name" class="dept-name"/>
												<input type="hidden" id="job-name" class="job-name"/>
				                                <label class="col-xs-4" for="edit-allDay">하루종일</label>
				                                <input class='allDayNewEvent' id="edit-allDay" type="checkbox"></label>
				                            </div>
				                        </div>
				
				                        <div class="row">
				                            <div class="col-xs-12">
				                                <label class="col-xs-4 mt10" for="edit-title">일정명</label>
				                                <input class="inputModal" type="text" name="edit-title" id="edit-title"
				                                    required="required" />
				                            </div>
				                        </div>
				                        <div class="row">
				                            <div class="col-xs-12">
				                                <label class="col-xs-4 mt10" for="edit-start">시작</label>
				                                <input class="inputModal" type="text" name="edit-start" id="edit-start" />
				                            </div>
				                        </div>
				                        <div class="row">
				                            <div class="col-xs-12">
				                                <label class="col-xs-4 mt10" for="edit-end">끝</label>
				                                <input class="inputModal" type="text" name="edit-end" id="edit-end" />
				                            </div>
				                        </div>
				                        <div class="row">
				                            <div class="col-xs-12">
				                                <label class="col-xs-4 mt10" for="edit-type">구분</label>
				                                <select class="inputModal" type="text" name="edit-type" id="edit-type">
				                                    <option value="개인일정">개인일정</option>
				                                    <option value="팀 일정">팀 일정</option>
				                                    <option value="부서 일정">부서 일정</option>
				                                    <option value="회사 일정">회사 일정</option>
				                                </select>
				                            </div>
				                        </div>
				                        <div class="row">
				                            <div class="col-xs-12">
				                                <label class="col-xs-4 mt10" for="edit-color">색상</label>
				                                <select class="inputModal" name="color" id="edit-color">
				                                    <option value="#f4ca25" style="color:#f4ca25;">회의</option>
				                                    <option value="#f2ab39" style="color:#f2ab39;">기타</option>
				                                    <option value="#ee6a22" style="color:#ee6a22;">외근</option>
				                                    <option value="#bd8e62" style="color:#bd8e62;">휴가</option>
				                                    <option value="#69491a" style="color:#69491a;">출장</option>
				                                    <option value="#370d00" style="color:#370d00;">데드라인</option>
				                                </select>
				                            </div>
				                        </div>
				                        <div class="row">
				                            <div class="col-xs-12">
				                                <label class="col-xs-4 mt10" for="edit-desc">설명</label>
				                                <textarea rows="4" cols="50" class="inputModal" name="edit-desc"
				                                    id="edit-desc"></textarea>
				                            </div>
				                        </div>
				                    </div>
				                    <div class="modal-footer modalBtnContainer-addEvent">
				                        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				                        <button type="button" class="btn btn-primary" id="save-event">저장</button>
				                    </div>
				                    <div class="modal-footer modalBtnContainer-modifyEvent">
				                        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				                        <button type="button" class="btn btn-danger" id="deleteEvent">삭제</button>
				                        <input type="submit" class="btn btn-primary" id="updateEvent">저장</input>
				                    </div>
				                 </form>
			                </div><!-- /.modal-content -->
			            </div><!-- /.modal-dialog -->
			        </div><!-- /.modal -->
			
			        <div class="panel panel-default">
			
			            <div class="panel-heading">
			                <h3 class="panel-title">필터</h3>
			            </div>
			
			            <div class="panel-body">
			
 			                <div class="col-lg-6"> 
			                    <label for="calendar_view">구분별</label>
			                    <div class="input-group">
			                        <select class="filter" id="type_filter" multiple="multiple">
			                            <option value="개인일정">개인일정</option>
			                            <option value="팀 일정">팀 일정</option>
			                            <option value="부서 일정">부서 일정</option>
			                            <option value="회사 일정">회사 일정</option>
			                        </select>
			                    </div>
			                </div>
			
			                <div class="col-lg-6">
			                    <label for="calendar_view">등록자별</label>
			                    <div class="input-group">
			                    	<c:forEach items="${eList }" var="e">
			                                
			                             <label class="checkbox-inline">
			                             	<input type="checkbox" class="filter emp_filter" value="${e.empNo }"/>
			                             	${e.jobName } ${e.empName }
			                             </label>
			                    	</c:forEach>
			                    </div>
			                </div>
			
			            </div>
			        </div>
			        <!-- /.filter panel -->
			    </div>
			    <!-- /.container -->
            </article>
        </div>
    </section>
    
    <script src="${pageContext.request.contextPath}/resources/fullCalendar/vendor/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/fullCalendar/vendor/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/fullCalendar/vendor/js/moment.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/fullCalendar/vendor/js/fullcalendar.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/fullCalendar/vendor/js/ko.js"></script>
    <script src="${pageContext.request.contextPath}/resources/fullCalendar/vendor/js/select2.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/fullCalendar/vendor/js/bootstrap-datetimepicker.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/fullCalendar/js/main.js"></script>
    <script src="${pageContext.request.contextPath}/resources/fullCalendar/js/addEvent.js"></script>
    <script src="${pageContext.request.contextPath}/resources/fullCalendar/js/editEvent.js"></script>
    <script src="${pageContext.request.contextPath}/resources/fullCalendar/js/etcSetting.js"></script>
</body>
    <style>
    .fc-today-button{margin-left:70px;}
    input{auto-complete:off;}
    
    .fc-next-button, .fc-prev-button{width: 50px ; height: 50px !important; border-radius: 50px; padding: 5px !important; margin: 0 20px !important;}
	
	#listWeekBtn{margin-right: 30px !important;}
    </style>
	<script>
	
	$("input").attr("autocomplete",'off');
	
	$("#listWeekBtn").css("margin-right","30px !important");
	</script>
</html>