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
						<li onclick="location.href='${pageContext.request.contextPath}/member/empLogBoard.do'">근태관리</li>
                        <li onclick="location.href='${pageContext.request.contextPath}/member/ioLog.do'">출입기록</li>
                        <li onclick="location.href='${pageContext.request.contextPath}/member/orgChart.do'">조직도</li>
	                    <li onclick="location.href='${pageContext.request.contextPath}/leave/update.do'">휴가관리</li>
                        <li onclick="location.href='${pageContext.request.contextPath}/leave/list.do'">휴가내역</li>
					</ul>
				</div>
				<div class="content">
					<div class="control">
							<input type='text' id='timepicker-start' class='datepicker-here' name="startDate"
								data-language='ko' data-date-format="yyyy-m-d"
								autocomplete="off" minutesStep="10" /> <i
								class='far fa-calendar-alt starticon' style='font-size: 32px'></i>
							<span>~</span> <input type='text' id='timepicker-end'  name="endDate"
								class='datepicker-here' data-language='ko'
								data-date-format="yyyy-m-d" autocomplete="off" minutesStep="10" />
							<i class='far fa-calendar-alt endicon' style='font-size: 32px'></i>
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
							<th>사유</th>
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
								<td>${leave.vctnReason }</td>
							</tr>
						</c:forEach>
					</table>
					<div class="pagination">
					${pageBar }
					</div>
					<div class="srchBar">
						<div class="select-box">
							<div class="select-box__current" tabindex="1">
								<div class="select-box__value">
									<input class="select-box__input" type="radio" id="0" value="dept_name" name="srchTypeInput" ${srchType eq 'dept_name'?'checked="checked"':"" }/>
									<p class="select-box__input-text">부서</p>
								</div>
								<div class="select-box__value">
									<input class="select-box__input" type="radio" id="1" value="emp_name" name="srchTypeInput" ${srchType eq 'emp_name'?'checked="checked"':"" }/>
									<p class="select-box__input-text">이름</p>
								</div>
								<div class="select-box__value">
									<input class="select-box__input" type="radio"  id="3" value="vctn_nm" name="srchTypeInput" ${srchType eq 'vctn_nm'?'checked="checked"':"" } />
									<p class="select-box__input-text">휴가종류</p>
								</div>
								<div class="select-box__value">
									<input class="select-box__input" type="radio"  id="2" value="all" name="srchTypeInput" ${srchType eq 'all'?'checked="checked"':"" }/>
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
						<input type="text" name="" id="srchWord" value="${srchWord eq 'null'?'':srchWord }" placeholder="검색창 나중에 위 쪽으로 올릴것">
						<button type="button" name="" id="srchBtn" class="yellowBtn">
							<i class="fas fa-search" style="font-size: 15px"></i> 검색
						</button>
					</div>
				</div>
			</article>
		</div>

	</section>
	<script>
	
	$("#srchBtn").click(function(){
		
		//폼 태그 생성
        var form = document.createElement('form');
        //폼 속성 set attribute
        form.name = 'newForm';
        form.method = 'get';
        form.action = '/msg/leave/list.do';
        form.target = '_self';        
        //input 태그 생성
        var input1 = document.createElement('input');
			 var input3 = document.createElement('input');
        //input태그에 set attribute
       input1.setAttribute("type", "hidden");
			input1.setAttribute("name", "srchWord");
			input1.setAttribute("value", $("#srchWord").val());
			input3.setAttribute("type", "hidden");
	        input3.setAttribute("name", "srchType");
	        input3.setAttribute("value", $("input[name='srchTypeInput']:checked").val());
        //완성된 input 태그를 form에 append
        form.appendChild(input1);
			form.appendChild(input3);
        //form 태그
        document.body.appendChild(form);
        // form 제출
        form.submit();
	});
	
	</script>
</body>
</html>