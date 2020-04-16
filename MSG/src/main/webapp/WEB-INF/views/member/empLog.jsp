<!DOCTYPE html>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link
	href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700&display=swap"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath }/resources/css/datepicker.min.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath }/resources/css/select_box.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath }/resources/css/paging.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath }/resources/css/hrBoard.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath }/resources/css/timepicker.custom.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath }/resources/css/empLog.css"
	rel="stylesheet" type="text/css">
<script
	src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
<script
	src="${pageContext.request.contextPath }/resources/js/datepicker.min.js"></script>
<script
	src="${pageContext.request.contextPath }/resources/js/datepicker.ko.js"></script>
<style>
</style>
<title>MSG :: 근태 관리</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<section>
		<div>
			<article>
				<div class="subNav">
					<h3>인사관리</h3>
					<ul>
						<li
							onclick="location.href='${pageContext.request.contextPath}/member/empLogBoard.do'">근태관리</li>
						<li
							onclick="location.href='${pageContext.request.contextPath}/member/ioLog.do'">출입기록</li>
						<li
							onclick="location.href='${pageContext.request.contextPath}/member/orgChart.do'">조직도</li>
						<li
							onclick="location.href='${pageContext.request.contextPath}/leave/update.do'">휴가관리</li>
						<li
							onclick="location.href='${pageContext.request.contextPath}/leave/list.do'">휴가내역</li>
						<li onclick="location.href='${pageContext.request.contextPath}/leave/select.do'">나의휴가내역</li>
					</ul>
				</div>
				<div class="content">
					<div class="control">
						<h2>조회날짜</h2>
						<input type='text' id='timepicker-start' name="startDate"
							class='datepicker-here' data-language='ko'
							data-date-format="yyyy-mm-dd" autocomplete="off" minutesStep="10" />
						<i class='far fa-calendar-alt starticon' style='font-size: 32px'></i>
						<span>~</span> <input type='text' id='timepicker-end'
							name="endDate" class='datepicker-here' data-language='ko'
							data-date-format="yyyy-mm-dd" autocomplete="off" minutesStep="10" />
						<i class='far fa-calendar-alt endicon' style='font-size: 32px'></i>
						<h2 class="workingdays">
							총 영업일 <span class="number">${bsnsDay }</span> 일
						</h2>
					</div>
					<div class="emp">
						<ul>
							<li class="deptAndJob">${list.get(0).deptName }</li>
							<li><p class="empName">${list.get(0).empName }</li>
							<li>출근일&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span
								class=number>${bsnsDay - list.get(0).vctnCount }</span>일
							</li>
							<li>휴가&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<span class="number">${list.get(0).vctnCount }</span>일
							</li>
							<li>결근&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<span class="number">${list.get(0).absentCount }</span>일
							</li>
							<li>지각&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<span class="number">${list.get(0).lateCount }</span>일
							</li>
							<li>조퇴&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<span class="number">${list.get(0).leaveCount }</span>일
							</li>
						</ul>
					</div>
					<div class="empLogView">
						<table class="board">
							<tr>
								<th></th>
								<th>날짜</th>
								<th>출근시각</th>
								<th>퇴근시각</th>
								<th>처리</th>
							</tr>
							<c:forEach items="${wt }" var="wt" varStatus="vs">
								<tr>
									<td>${vs.count }</td>
									<td><fmt:formatDate value="${wt.workDay}"
											pattern="YYYY-MM-dd" /></td>
									<td><fmt:formatDate value="${wt.clockIn}" pattern="HH:mm" /></td>
									<td><fmt:formatDate value="${wt.clockOut}" pattern="HH:mm" /></td>
									<td>${wt.remark }</td>
								</tr>
							</c:forEach>
						</table>
					</div>
					<div class="pagination">
						<c:if test="${paging.startPage != 1 }">
							<a
								href="${pageContext.request.contextPath}/member/empLog.do?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}&startDate=${srcDateStart}&endDate=${srcDateEnd}&empNo=${empNo}"
								class="arrow" style="margin-left: 0px; margin-right: 0px;">&laquo;</a>
						</c:if>
						<c:forEach begin="${paging.startPage }" end="${paging.endPage }"
							var="p">
							<c:choose>
								<c:when test="${p == paging.nowPage }">
									<a class="active">${p }</a>
								</c:when>
								<c:when test="${p != paging.nowPage }">
									<a
										href="${pageContext.request.contextPath}/member/empLog.do?nowPage=${p }&cntPerPage=${paging.cntPerPage}&startDate=${srcDateStart}&endDate=${srcDateEnd}&empNo=${empNo}">${p }</a>
								</c:when>
							</c:choose>
						</c:forEach>
						<c:if test="${paging.endPage != paging.lastPage}">
							<a
								href="${pageContext.request.contextPath}/member/empLog.do?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}&startDate=${srcDateStart}&endDate=${srcDateEnd}&empNo=${empNo}"
								class="arrow" style="margin-left: 0px; margin-right: 0px;">&raquo;</a>
						</c:if>
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
				var bsnsDay = calcDate(dstartDate, dendDate);
				location.href = "${pageContext.request.contextPath}/member/empLog.do?empNo="
						+ ${empNo} +"&startDate=" + startDate + "&endDate=" + endDate
						+ "&bsnsDay=" + bsnsDay;
				{
					list.get(0).empNo
				}
			}
		}

		function calcDate(date1, date2) {

			var count = 0;

			while (true) {
				var temp_date = date1;
				if (temp_date.getTime() > date2.getTime()) {
					break;
				} else {
					var tmp = temp_date.getDay();
					if (tmp == 0 || tmp == 6) {
						// 주말
						console.log("주말");
					} else {
						// 평일
						console.log("평일");
						count++;
					}
					temp_date.setDate(date1.getDate() + 1);
				}
			}
			return count;
		}
	</script>
</body>
</html>