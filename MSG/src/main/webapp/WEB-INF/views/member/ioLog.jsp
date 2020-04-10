<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath }/resources/css/datepicker.min.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath }/resources/css/select_box.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath }/resources/css/paging.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath }/resources/css/hrBoard.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath }/resources/css/timepicker.custom.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath }/resources/css/empLog.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath }/resources/css/IOlog.css" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/datepicker.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/datepicker.ko.js"></script>
    <style>
        

    </style>
    <title>MSG :: 출입기록</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<section>
		<div>
			<article>
                <div class="subNav">
                    <h3>인사관리</h3>
                    <ul>
                       	<li onclick="location.href='${pageContext.request.contextPath}/member/empLogBoard.do'">근태관리</li>
                        <li onclick="location.href='${pageContext.request.contextPath}/member/ioLog.do'">출입기록</li>
                        <li onclick="location.href='${pageContext.request.contextPath}/member/orgChart.do'">조직도</li>
	                    <li onclick="location.href='${pageContext.request.contextPath}/leave/update.do'">휴가관리</li>
                        <li onclick="location.href='${pageContext.request.contextPath}/leave/list.do'">휴가내역</li>
                     </ul>
                </div>
			    <div class="content">
			        <div class="control">
			            <h2>조회날짜</h2>
			            <input type='text' id='timepicker-start' class='datepicker-here' data-language='ko' 
			                    data-date-format="yyyy-m-d" autocomplete="off" minutesStep="10"/>
			                    <i class='far fa-calendar-alt starticon' style='font-size:32px'></i>
			            <span>~</span>
			            <input type='text' id='timepicker-end' class='datepicker-here' data-language='ko' 
			                    data-date-format="yyyy-m-d" autocomplete="off" minutesStep="10"/>
			            <i class='far fa-calendar-alt endicon' style='font-size:32px'></i>
			        </div>
			        <hr class="boardHr" />
			        <div class="logView">
			            <ol>
			            	<c:forEach items="${list }" var="io"> 
			                	<li><fmt:formatDate value="${io.taken}" pattern="YYYY-MM-dd HH:mm"/> by ${io.empName } (${io.inoutFg })</li>
			                </c:forEach>
			            </ol>
			            <div class="srchBar">
			                <div class="select-box">
			                    <div class="select-box__current" tabindex="1">
			                        <div class="select-box__value">
			                            <input class="select-box__input" type="radio" id="empName" value="empName" name="searchBy"
			                                checked="checked" />
			                            <p class="select-box__input-text">이름</p>
			                        </div><img class="select-box__icon"
			                            src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon"
			                            aria-hidden="true" />
			                    </div>
			                    <ul class="select-box__list">
			                        <li>
			                            <label class="select-box__option" for="empName" aria-hidden="aria-hidden">이름</label>
			                        </li>
			                    </ul>
			                </div>
			                <input type="text" name="" id="srchWord">
			                <button type="button" name="" id="srchBtn" class="yellowBtn"><i class="fas fa-search"
			                        style="font-size:15px"></i> 검색</button>
			        </div>
			    </div>
   			</article>
		</div>
	</section>
	<script>
	//광역변수 선언
	let startDate;
	let endDate;

	//아이콘 클릭 시 dateTimePicker focus
	$(document).ready(function() {

		$('.starticon').click(function() {
			$('#timepicker-start').focus();
		});
		$('.endicon').click(function() {
			$('#timepicker-end').focus();
		});

		$("#timepicker-start").val("${srcDateStart}");
		$("#timepicker-end").val("${srcDateEnd}");
	});

	$("#timepicker-start").datepicker({
		onSelect : function onSelect(start) {
			startDate = start;
			if (startDate !== undefined && endDate !== undefined) {
				validate(startDate, endDate);
			}
		},
		maxDate : new Date()
	});
	$("#timepicker-end").datepicker({
		onSelect : function onSelect(end) {
			endDate = end;
			if (startDate !== undefined && endDate !== undefined) {
				validate(startDate, endDate);
			}
		},
		maxDate : new Date()
	});

	//날짜로 변환
	function toDate(strDate) {
		var y = strDate.substr(0, 4);
		var m = strDate.substr(5, 2);
		var d = strDate.substr(8, 2);

		return new Date(y, m - 1, d);
	}

	//유효성검사
	function validate(startDate, endDate) {
		var dstartDate = toDate(startDate);
		var dendDate = toDate(endDate);

		//검색하고자 하는 시작날짜가 종료날짜보다 나중인 경우
		if (+dstartDate > +dendDate) {
			alert("날짜를 다시 지정해주세요");
		} else {
			location.href = "${pageContext.request.contextPath}/member/ioLog.do?startDate="
					+ startDate + "&endDate=" + endDate;
		}
	}

</script>
</body>
</html>