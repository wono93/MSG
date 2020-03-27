<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/allvacation.css">
<link
	href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700&display=swap"
	rel="stylesheet">
<!-- <script src="https://kit.fontawesome.com/4c554cd518.js" crossorigin="anonymous"></script> -->
<script
	src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
<!-- include jQuery :) -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<!-- jQuery Modal -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<script
	src="${pageContext.request.contextPath }/resources/js/datepicker.min.js"></script>
<script
	src="${pageContext.request.contextPath }/resources/js/datepicker.ko.js"></script>
<link
	href="${pageContext.request.contextPath }/resources/css/datepicker.min.css"
	rel="stylesheet" type="text/css">
<title>vacation</title>
</head>
<style>
#timepicker-start, #timepicker-end {
	margin-left: -260px;
	width: 210px;
	height: 50px;
	border: 2px solid #999;
	font-size: 19px;
	padding-left: 20px;
	margin-top: 40px;
}

.starticon {
	color: #999;
	cursor: pointer;
	padding-left: 10px;
	margin-bottom: 0px;
	position: relative;
	top: 5px;
}

.starticon:hover {
	color: black;
	cursor: pointer;
}

.endicon {
	color: #999;
	cursor: pointer;
	padding-left: 10px;
	margin-bottom: 0px;
	position: relative;
	top: 5px;
}

.endicon:hover {
	color: black;
	cursor: pointer;
}

#timepicker-start:focus+.starticon, #timepicker-end:focus+.endicon {
	color: #f4ca25;
}

#timepicker-end {
	margin-left: 30px;
}
</style>
<script>
	//아이콘 클릭 시 dateTimePicker focus

	$(function() {
		$('.starticon').click(function() {
			$('#timepicker-start').focus();
		});
		$('.endicon').click(function() {
			$('#timepicker-end').focus();
		});
	});

	// Initialization
	$('#my-element').datepicker()
	// Access instance of plugin
	$('#my-element').data('datepicker')

	// Create start date
	var start = new Date(), prevDay, startHours = 9;

	// 09:00 AM
	start.setHours(9);
	start.setMinutes(0);

	// If today is Saturday or Sunday set 10:00 AM
	if ([ 6, 0 ].indexOf(start.getDay()) != -1) {
		start.setHours(10);
		startHours = 10
	}

	$('#timepicker-actions-exmpl').datepicker({
		timepicker : true,
		language : 'en',
		startDate : start,
		minHours : startHours,
		maxHours : 18,
		onSelect : function(fd, d, picker) {
			// Do nothing if selection was cleared
			if (!d)
				return;

			var day = d.getDay();

			// Trigger only if date is changed
			if (prevDay != undefined && prevDay == day)
				return;
			prevDay = day;

			// If chosen day is Saturday or Sunday when set
			// hour value for weekends, else restore defaults
			if (day == 6 || day == 0) {
				picker.update({
					minHours : 10,
					maxHours : 16
				})
			} else {
				picker.update({
					minHours : 9,
					maxHours : 18
				})
			}
		}
	})
</script>
<script>
	// yearcheck ++
	function upYear() {
		var yearCheck = document.getElementById('yearcheck');
		var yearValue = getYearCheckValue();
		yearValue = yearValue + 1 + '년';
		yearCheck.value = yearValue;
	}

	// yearcheck --
	function downYear() {
		var yearCheck = document.getElementById('yearcheck');
		var yearValue = getYearCheckValue();
		yearValue = yearValue - 1 + '년';
		yearCheck.value = yearValue;
	}

	// input(yearcheck) 값 불러오기
	function getYearCheckValue() {
		var yearCheck = document.getElementById('yearcheck');
		var yearValueStr = yearCheck.value.split('년')[0]; // 숫자만 가져옴
		return Number(yearValueStr);
	}
	// yearcheck(modal) ++
	function upYear2() {
		var yearCheck = document.getElementById('Qty');
		var yearValue = getYearCheckValue2();
		yearValue = yearValue + 1;
		yearCheck.value = yearValue;
	}

	// yearcheck(modal)--
	function downYear2() {
		var yearCheck = document.getElementById('Qty');
		var yearValue = getYearCheckValue2();
		yearValue = yearValue - 1;
		yearCheck.value = yearValue;
	}

	// input(yearcheck) 값 불러오기
	function getYearCheckValue2() {
		var yearCheck = document.getElementById('Qty');
		var yearValueStr = yearCheck.value;
		console.log(yearValueStr);
		return Number(yearValueStr);
	}
</script>



<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<section>
		<div>
			<article>
				<div class="subNav">
					<h3>인사관리</h3>
					<ul>
						<li
							onclick="location.href='${pageContext.request.contextPath}/member/list.do'">근태관리</li>
						<li
							onclick="location.href='${pageContext.request.contextPath}/member/io.do'">출입기록</li>
						<li
							onclick="location.href='${pageContext.request.contextPath}/member/org.do'">조직도</li>
						<li
							onclick="location.href='${pageContext.request.contextPath}/leave/update.do'">휴가관리</li>
						<li
							onclick="location.href='${pageContext.request.contextPath}/leave/list.do'">휴가내역</li>
					</ul>
				</div>
				<div class="content">
					<div class="control">
						<form>
							<!-- <input type="text" data-range="true" data-multiple-dates-separator=" ~ " data-date-format="yyyy-m-d D"
                                    data-language="ko" id='timepicker-startend' class="datepicker-here"/>
                                    <i class='far fa-calendar-alt startendicon' style='font-size:32px'></i> -->
							<input type='text' id='timepicker-start' class='datepicker-here'
								data-language='ko' data-timepicker="true"
								data-date-format="yyyy-m-d D" data-time-format='hh:ii AA'
								autocomplete="off" minutesStep="10" /> <i
								class='far fa-calendar-alt starticon' id="start1"
								style='font-size: 32px'></i> <span class="wavepart">&nbsp;&nbsp;&nbsp;&nbsp;~</span>
							<input type='text' id='timepicker-end' class='datepicker-here'
								data-language='ko' data-timepicker="true"
								data-date-format="yyyy-m-d D" data-time-format='hh:ii AA'
								autocomplete="off" minutesStep="10" /> <i
								class='far fa-calendar-alt endicon' id="end1"
								style='font-size: 32px'></i>
							<p>
								<button type="submit" id="checkcal">휴가확인</button>
							</p>
						</form>
					</div>
					<table>
						<tr>
							<th></th>
							<th>부서</th>
							<th>이름</th>
							<th>종류</th>
							<th>신청일자</th>
							<th>시작일자</th>
							<th>종료일자</th>
							<th>사용일수</th>
						</tr>
						<c:forEach items="${leaveList}" var="leave" varStatus="vs">
							<tr
								onclick="location.href='${pageContext.request.contextPath}/leave/select.do'">
								<td>${leave.vctnDtlNo}</td>
								<td>${leave.deptName}</td>
								<td>${leave.empName}</td>
								<td>${leave.vctnNm}</td>
								<td>${leave.appDt}</td>
								<td>${leave.vctnStdt }</td>
								<td>${leave.vctnEndt}</td>
								<td>${leave.vctnUsed}</td>
							</tr>
						</c:forEach>
					</table>
					<div class="pagination">
						<a href="#" class="arrow">&laquo;</a> <a href="#">1</a> <a
							href="#" class="active">2</a> <a href="#">3</a> <a href="#">4</a>
						<a href="#">5</a> <a href="#" class="arrow">&raquo;</a>
					</div>
					<div class="srchBar">
						<div class="select-box">
							<div class="select-box__current" tabindex="1">
								<div class="select-box__value">
									<input class="select-box__input" type="radio" id="0" value="1"
										name="Ben" checked="checked" />
									<p class="select-box__input-text">부서</p>
								</div>
								<div class="select-box__value">
									<input class="select-box__input" type="radio" id="1" value="2"
										name="Ben" checked="checked" />
									<p class="select-box__input-text">이름</p>
								</div>
								<div class="select-box__value">
									<input class="select-box__input" type="radio" id="3" value="4"
										name="Ben" checked="checked" />
									<p class="select-box__input-text">휴가종류</p>
								</div>
								<div class="select-box__value">
									<input class="select-box__input" type="radio" id="2" value="3"
										name="Ben" checked="checked" />
									<p class="select-box__input-text">전체</p>
								</div>
								<img class="select-box__icon"
									src="http://cdn.onlinewebfonts.com/svg/img_295694.svg"
									alt="Arrow Icon" aria-hidden="true" />
							</div>
							<ul class="select-box__list">
								<li><label class="select-box__option" for="2"
									aria-hidden="aria-hidden">전체</label></li>
								<li><label class="select-box__option" for="0"
									aria-hidden="aria-hidden">부서</label></li>
								<li><label class="select-box__option" for="1"
									aria-hidden="aria-hidden">이름</label></li>
								<li><label class="select-box__option" for="3"
									aria-hidden="aria-hidden">휴가종류</label></li>
							</ul>
						</div>
						<input type="text" name="" id="srchWord">
						<button type="button" name="" id="srchBtn" class="yellowBtn">
							<i class="fas fa-search" style="font-size: 15px"></i> 검색
						</button>
					</div>
				</div>
			</article>
		</div>

	</section>

</body>
</html>