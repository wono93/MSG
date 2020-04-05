<!DOCTYPE html>
<html lang="en">
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700&display=swap" rel="stylesheet">
    <script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
    
    <link href="${pageContext.request.contextPath }/resources/dateTimePicker/dist/css/datepicker.min.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath }/resources/css/reservation.css" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath }/resources/dateTimePicker/dist/js/datepicker.min.js"></script>
	
    <script src="${pageContext.request.contextPath }/resources/dateTimePicker/dist/js/i18n/datepicker.ko.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/res_header.js"></script>
    <title>MSG :: 회의실 예약</title>
</head>
<style>
.center1200 li:first-of-type{color:#333;}
.saveId-container { display: inline; position: relative; padding-left: 25px; top:7px; left:110px; cursor: pointer; font-size: 20px;}
</style>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <section>
        <div>
            <article>
			    <div class="center1200">
			        <h3>예약관리</h3>
			        
			            <ul>
			                <li onclick="location.href='${pageContext.request.contextPath}/res/confRes.do'">회의실</li>
			                <li onclick="location.href='${pageContext.request.contextPath}/res/carRes.do'">법인차량</li>
			                <li onclick="location.href='${pageContext.request.contextPath}/res/myResView.do'">예약확인</li>
			             </ul>
			    </div>
			    <div id="whitecontent">
			    	<form action="${pageContext.request.contextPath }/res/confResInsert.do" method="post" id="confResFrm">
				        <input type='text' id='timepicker-start-conf' name='resUsedate' class='datepicker-here' data-language='ko' 
				                data-timepicker="true" data-date-format="yyyy-mm-dd D"  data-time-format="hh:ii"  autocomplete="off" placeholder="대여시작날짜/시간"/>
				                <i class='far fa-calendar-alt starticon' style='font-size:32px'></i>
				        <span>  ~</span>
				        <input type='text' id='timepicker-end-conf' name='resReturndate' class='datepicker-here' data-language='ko' 
				                data-timepicker="true" data-date-format="yyyy-mm-dd D" data-time-format="hh:ii" autocomplete="off" minutesStep="10" placeholder="대여반납날짜/시간"/>
				                <i class='far fa-calendar-alt endicon' style='font-size:32px'></i>
				        <input type="hidden" name="resUseDate" />
				        <input type="hidden" name="resReturnDate" />
				        <input type="hidden" name="resEnrolldate" />
				        <input type="hidden" name="empNo" class="empNo" value='${memberLoggedIn.empNo}'/>
				        <input type="hidden" name="isManager" class="isManager" value="${memberLoggedIn.isManager}"/>
				        <button id="getConfReserv"type="button">예약하기</button>
				        <!-- <button  id="reservTest" onclick="requestAjax()"></button> -->
				        <table class="res-table">
				            <tr>
				                <th></th>
				                <th>회의실명</th>
				                <th>수용인원</th>
				                <th>선택</th>
				            </tr>
				            <c:forEach items="${cList }" var="c" varStatus="vs">
				            	<tr class="ajaxHide-tr">
				            		<td>${vs.count }</td>
				            		<td>${c.croomName }</td>
				            		<td>${c.croomSize }</td>
				            		<td>
				            			<label class="saveId-container float" for="${c.croomCode }">
				            			<input type="radio" name="conf" id="${c.croomCode }" value="${c.croomCode }" onclick="intoConfCode();"/>
				            			<span class="saveId-checkmark"></span></label>
				            		</td>
				            	</tr>
				            </c:forEach>
				        </table>
				        <input type="hidden" id="croomCode" name="croomCode" />
				        <button id="add-conf" type="button">회의실 추가</button>
				        <button id="update-conf" type="button" onclick="location.href='${pageContext.request.contextPath }/res/updateConf.do'" >수정</button>
				        <button id="del-conf" type="button" onclick="location.href='${pageContext.request.contextPath }/res/delConf.do'" >삭제</button>
				     </form>
			    </div>
             </article>
        </div>
    </section>
    <div id="addConfModal" class="ch-modal">
            <!-- Modal content -->
            <div class="ch-modal-content">
                
                <img src="${pageContext.request.contextPath}/resources/image/X-icon.png" alt="" class="x-icon close confClose" id="close-btn">
                <div id="ch-content">
                    <form action="${pageContext.request.contextPath }/res/addConf.do">

                        <div class="channelGenTitle">
                            <h3>회의실 추가</h3>
                        </div>

                        <input type="text" name="room-title" id="addConf-title" placeholder="새로운 회의실 이름을 입력해주세요.">
                        <p>
						<div class="updown custom">
							수용인원
							<button type="button" class="minusBtn mLeft50" onclick="minus();">-</button>
							<input type="text" id="person" value="4" name="size" readonly="true" />
							<button type="button" class="plusBtn" onclick="plus();">+</button>
						</div>
						</p>
                        <input type="submit" class="addBtn" value="추가하기" />
                    </form>
               	</div>
            </div>
     </div>
     <script src="${pageContext.request.contextPath }/resources/js/res_footer.js"></script>
</body>
</html>