<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/vacation.css">
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
<title>vacation</title>
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
						<form>
							<p>
							<div id="btnBox">
								<input type="text" value="2020년" id="yearcheck" />
								<button type="button" id="upYearcheck" onclick="upYear();">▲</button>
								<button type="button" id="downYearcheck" onclick="downYear();">▼</button>
							</div>
							<button type="submit" id="vacationcheck">휴가내역 보기</button>
							</p>
						</form>
					</div>
					<table>
						<tr>
							<th rowspan="2"></th>
							<th rowspan="2">부서</th>
							<th rowspan="2">이름</th>
							<th rowspan="2">근속연수</th>
							<th rowspan="2">연차할당</th>
							<th rowspan="2">포상할당</th>
							<th colspan="3" id="usedvct">사용 휴가</th>
							<th rowspan="2">휴가조정</th>
						</tr>
						<tr>
							<th>연차</th>
							<th>포상</th>
							<th>기타</th>
						</tr>
						<c:forEach items="${listSum}" var="leave" varStatus="vs">
							<tr>
								<td>   </td>
								<td>${leave.deptName}</td>
								<td>${leave.empName}</td>
								<td>${leave.longevity}</td>
								<td>${leave.annual}</td>
								<td>${leave.reward}</td>
								<td>${leave.annualUsed}</td>
								<td>${leave.rewardUsed }</td>
								<td>${leave.otherUsed }</td>
								<td><p>
										<a href="#test" rel="modal:open">
											<button class="penbutton">
												<i class='fas fa-pencil-alt'> </i>
											</button>
										</a>
									</p></td>
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
		<!-- modal에 띄우고자하는 코드 -->
		<div id="test" class="modal">
			<h1 style="margin-left: 40px;">휴가조정</h1>
			<p>
			<div class="checkbox custom">
				조정할휴가 <input id="box2" class="css-checkbox" type="radio" name="abc" />
				<label for="box2" class="css-label-yellow">연차</label> <input
					id="box1" class="css-checkbox" type="radio" name="abc" /> <label
					for="box1" class="css-label-red">포상</label>
			</div>
			</p>
			<p>
			<div class="updown custom">
				조절량
				<button type="button" class="upQtyBtn" onclick="upYear2();">+</button>
				<input type="text" id="Qty" value="0" readonly="true" />
				<button type="button" class="downQtyBtn" onclick="downYear2();">-</button>
			</div>
			</p>
			<p>
			<div class="divice custom">
				근거
				<form id="bookid">
					<p class="divice brd">전자문서:2020-GD001-0D3</p>
				</form>
			</div>
			</p>
			<p>
			<div class="setting custom">
				기조정내역 <br> <br>
				<table class="modaltb">
					<tr class="modaltr">
						<th class="modalth1">종류</th>
						<th class="modalth2">조절량</th>
						<th class="modalth3">근거</th>
						<th class="modalth4">일시</th>
					</tr>
					<tr>
						<td>포상</td>
						<td>+3</td>
						<td>전자문서:2020-G001-0D2</td>
						<td>2020-03-02 13:30</td>
					</tr>
					<tr>
						<td>연차</td>
						<td>-2</td>
						<td>근속년수 계산 오류</td>
						<td>2020-03-01 13:30</td>
					</tr>
				</table>
			</div>
			</p>
			<br> <br>
			<button type="submit" id="modalsub">확인</button>
			<a href="#" rel="modal:close"><button id="modalclo">취소</button></a>
			<!-- 닫기버튼 -->
		</div>
		</div>

	</section>

</body>
</html>