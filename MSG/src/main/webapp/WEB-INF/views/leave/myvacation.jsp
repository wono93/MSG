<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/myvacation.css">
<link
	href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700&display=swap"
	rel="stylesheet">
<script src="https://kit.fontawesome.com/4c554cd518.js"
	crossorigin="anonymous"></script>
<script
	src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
<script
	src="${pageContext.request.contextPath }/resources/js/vacation.js"></script>
<!-- include jQuery :) -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<!-- jQuery Modal -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<title>myvacation</title>
</head>
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
						<h3 class="h3title">
							<%-- <c:forEach  items="${leaveListInfoPlus}" var="leave1" varStatus="vs" begin="1" end="1">
							<tr>
							<th>${leave1.deptName}</th>
							<th>${leave1.jobName}</th>
							<th>${leave1.empName}</th>
						</tr>
						</c:forEach> --%>
						${memberLoggedIn.deptName } ${memberLoggedIn.jobName } ${memberLoggedIn.empName }
							</h3>
							<form>
								<p>
								<h4 class="h4title">휴가현황</h4>
								<div id="btnBox">
									<input type="text" value="2020년" id="yearcheck" />
									<button type="button" id="upYearcheck" onclick="upYear();">▲</button>
									<button type="button" id="downYearcheck" onclick="downYear();">▼</button>
								</div>
								</p>
							</form>
					</div>
					<table>
						<tr id="vct_tr">
							<th id="vct_th" rowspan="2">연차</th>
							<th id="vct_th" rowspan="2">포상</th>
							<th id="vct_th" colspan="7" style="border-bottom: white;">휴가사용내역</th>
							<th id="vct_th" rowspan="2">남은휴가</th>
						</tr>
						<tr id="vct_tr">
							<th id="vct_th">연차</th>
							<th id="vct_th">포상</th>
							<th id="vct_th">공가</th>
							<th id="vct_th">경조사</th>
							<th id="vct_th">병가</th>
							<th id="vct_th">무급</th>
							<th id="vct_th">기타</th>
						</tr>
					    <c:forEach  items="${leaveListInfoPlus}" var="leave2" varStatus="vs">
							 <c:if test="${vs.last}">
							<tr>
							 <th>${leave2.annual}</th> 
							 <th>${leave2.reward}</th>
							<th>${leave2.annualUsed}</th>
							<th>${leave2.rewardUsed}</th>
							<th>${leave2.floatingUsed}</th>
							<th>${leave2.familyeventUsed}</th>
							<th>${leave2.sickleaveUsed}</th>
							<th>${leave2.unpaidUsed}</th>
							<th>${leave2.otherUsed}</th>
							<th>연차${leave2.annualNotUsed }일 포상${leave2.rewardNotused }일</th> 			
						</tr>
						</c:if> 
						</c:forEach>				
					</table>
					<table>
						<h4 class="h4title2">
							휴가내역
							</h4>
					</table>
					<table>
						<tr>
							<th></th>
							<th>일시</th>
							<th>사유</th>
							<th>종류</th>
							<th>사용일수</th>
						</tr>
						<c:forEach  items="${leaveList4}" var="leave" varStatus="vs">
						<tr>
							<td>${leave.vctnDtlNo}</td>
							<td>${leave.vctnStdt }~${leave.vctnEndt}</td>
							<td>${leave.vctnReason}</td>
							<td>${leave.vctnNm }</td>
							<td>${leave.vctnUsed }</td>
						</tr>
						</c:forEach>
					</table>
					<div class="pagination">
						<a href="#" class="arrow">&laquo;</a> <a href="#">1</a> <a
							href="#" class="active">2</a> <a href="#">3</a> <a href="#">4</a>
						<a href="#">5</a> <a href="#" class="arrow">&raquo;</a>
					</div>
				</div>
			</article>
		</div>
	</section>
</body>
</html>