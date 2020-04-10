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
						<li onclick="location.href='${pageContext.request.contextPath}/member/empLogBoard.do'">근태관리</li>
                        <li onclick="location.href='${pageContext.request.contextPath}/member/ioLog.do'">출입기록</li>
                        <li onclick="location.href='${pageContext.request.contextPath}/member/orgChart.do'">조직도</li>
	                    <li onclick="location.href='${pageContext.request.contextPath}/leave/update.do'">휴가관리</li>
                        <li onclick="location.href='${pageContext.request.contextPath}/leave/list.do'">휴가내역</li>
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
						<c:forEach  items="${leaveMyList}" var="leave" varStatus="vs">
						<c:if test="${memberLoggedIn.empNo == leave.empNo  }">
						<tr>
							<td>${leave.vctnDtlNo}</td>
							<td>${leave.vctnStdt }~${leave.vctnEndt}</td>
							<td>${leave.vctnReason}</td>
							<td>${leave.vctnNm }</td>
							<td>${leave.vctnUsed }</td>
						</tr>
						</c:if>
						</c:forEach>
					</table>
					<div class="pagination">
					${pageBar }	
					</div>
					<div class="srchBar">
						<div class="select-box">
							<div class="select-box__current" tabindex="1">
								<div class="select-box__value">
									<input class="select-box__input" type="radio" id="0" value="dept_name" name="srchTypeInput" ${srchType eq 'B.VCTN_REASON'?'checked="checked"':"" }/>
									<p class="select-box__input-text">사유</p>
								</div>
								<div class="select-box__value">
									<input class="select-box__input" type="radio" id="1" value="emp_name" name="srchTypeInput" ${srchType eq 'C.VCTN_NM'?'checked="checked"':"" }/>
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
									aria-hidden="aria-hidden">사유</label></li>
								<li><label class="select-box__option" for="1"
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
        form.action = '/msg/leave/select.do';
        form.target = '_self';        
        //input 태그 생성
        var input1 = document.createElement('input');
   
        //input태그에 set attribute
        input1.setAttribute("type", "hidden");
        input1.setAttribute("name", "srchWord");
        input1.setAttribute("value", $("#srchWord").val());        
       
        //완성된 input 태그를 form에 append
        form.appendChild(input1);
        //form 태그
        document.body.appendChild(form);
        // form 제출
        form.submit();
	});
	
	</script>
</body>
</html>