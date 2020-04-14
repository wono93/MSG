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
	
	<link href="${pageContext.request.contextPath }/resources/css/reservation.css" rel="stylesheet" type="text/css">
	    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/edocList.css">
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<!-- jQuery ui style sheet -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- jQuery library -->
<script src="https://code.jquery.com/jquery.js"></script>
<!-- jQuery ui library -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<title>vacation</title>
</head>
<script>

$( document ).ready( function() {
     $( 'td:empty' ).append( 0 );
   } );	

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
	function plus() {
		var yearCheck = document.getElementById('Qty');
		var yearValue = getYearCheckValue2();
		yearValue = yearValue + 1;
		yearCheck.value = yearValue;
	}

	// yearcheck(modal)--
	function minus() {
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
							onclick="location.href='${pageContext.request.contextPath}/member/empLogBoard.do'">근태관리</li>
						<li
							onclick="location.href='${pageContext.request.contextPath}/member/ioLog.do'">출입기록</li>
						<li
							onclick="location.href='${pageContext.request.contextPath}/member/orgChart.do'">조직도</li>
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
					 	<c:forEach items="${listSum}" var="leave">
							<tr>
								<td>${leave.deptName}</td>
								<td>${leave.empName}</td>
								<td>${leave.longevity}</td>
								<td>${leave.annual}</td>
								<td>${leave.reward}</td>
								<c:set var="zero" value="0" />
								<td id="tdZero"> 						
								 <c:forEach items="${listAnnual}" var="an" varStatus="vs">																						
									<c:if test="${leave.empNo == an.empNo }">
									 ${an.annual }
									</c:if>
								</c:forEach> 
								</td>
									<td id="tdZero">
								 <c:forEach items="${listReward }" var="rw">							
									<c:if test="${leave.empNo == rw.empNo }">
									 ${rw.reward }
									</c:if>					
								</c:forEach> 
								</td>
								<td id="tdZero">
								 <c:forEach items="${listOther }" var="lo">							
									<c:if test="${leave.empNo == lo.empNo }">
									 ${lo.other }
									</c:if>					
								</c:forEach> 
								</td>
								 <td><p>
										<a href="#test" rel="modal:open">
											<button class="penbutton" id="modalBtn" name="modalNm"
												value="${leave.empNo}" onclick="modal(this);">
												<i class='fas fa-pencil-alt'> </i>
											</button>
										</a>
									</p></td>
							</tr>
						</c:forEach> 			
					</table>
					<div class="pagination">${pageBar }</div>
					<div class="srchBar">
						<div class="select-box">
							<div class="select-box__current" tabindex="1">
								<div class="select-box__value">
									<input class="select-box__input" type="radio" id="0"
										value="dept_name" name="srchTypeInput"
										${srchType eq 'd.dept_name'?'checked="checked"':"" } />
									<p class="select-box__input-text">부서</p>
								</div>
								<div class="select-box__value">
									<input class="select-box__input" type="radio" id="1"
										value="emp_name" name="srchTypeInput"
										${srchType eq 'b.emp_name'?'checked="checked"':"" } />
									<p class="select-box__input-text">이름</p>
								</div>
								<div class="select-box__value">
									<input class="select-box__input" type="radio" id="2"
										value="all" name="srchTypeInput"
										${srchType eq 'all'?'checked="checked"':"" } />
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
						<input type="text" name="" id="srchWord"
							value="${srchWord eq 'null'?'':srchWord }"
							placeholder="검색창 나중에 위 쪽으로 올릴것">
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
			 <div class="checkbox_wrap">
                                <label class="myDocu-container kor float" for="myDocu">연차
                                            <input type="radio" name="arrayDocuCheck" id="myDocu" class="docuCheck" value="myDocu"  checked="checked">
                                            <span class="myDocu-checkmark"></span>
                               </label>
                                <label class="reqDocu-container kor float" for="reqDocu">포상
                                            <input type="radio" name="arrayDocuCheck" id="reqDocu" class="docuCheck" value="reqDocu" >
                                            <span class="reqDocu-checkmark"></span>
                               </label>
                            </div>
			<div class="checkbox custom">
				조정할휴가 <input id="box2" class="css-checkbox" type="radio" name="abc" />
				<label for="box2" class="css-label-yellow">연차</label> <input
					id="box1" class="css-checkbox" type="radio" name="abc" /> <label
					for="box1" class="css-label-red">포상</label>
			</div>
			</p>
			  <p>
						<div class="updown custom">
							조정
							<button type="button" class="minusBtn mLeft50" onclick="minus();">-</button>
							<input type="text" id="person_" value="0" name="carSize" readonly="true" />
							<button type="button" class="plusBtn" onclick="plus();">+</button>
						</div>
						</p>
			<p>			
			<div class="updown custom">
				조절량
				<button type="button" class="upQtyBtn" onclick="upYear2();">+</button>
				<input type="text" id="Qty" value="0" readonly="true" name="Qty" />
				<button type="button" class="downQtyBtn" onclick="downYear2();">-</button>
			</div>
			</p>
			<div class="ui-widget">
				<label for="search">문서 검색: </label> <input id="search">

				<p>
				<div class="divice custom">
					근거
					<form id="bookid">
						<input type="text" id="reasonBox" />
					</form>
				</div>
				</p>
				<input type="text" name="carNo" id="updateCar-no" placeholder="근거를 입력해주세요."/>
				<p>
				<div class="setting custom">
					기조정내역 <br> <br>
					<table class="modaltb" id="modalAjax">
						<tr class="modaltr">
							<th class="modalth1">종류</th>
							<th class="modalth2">조절량</th>
							<th class="modalth3">전자문서</th>
							<th class="modalth5">사유</th>
							<th class="modalth4">일시</th>
						</tr>
					</table>
				</div>
				</p>
				<br> <br>
				<button type="submit" id="modalsub" onclick="modalSub();">확인</button>
				<a href="#" rel="modal:close"><button id="modalclo"
						onclick="modalDel();">취소</button></a>
				<!-- 닫기버튼 -->
			</div>
		</div>

	</section>
	<script>
	$(document).ready(function() {
		if($('#tdZero').text()==null){
		$('#tdZero').append("0");
		}
		});
		
		$("#srchBtn").click(function() {

			//폼 태그 생성
			var form = document.createElement('form');
			//폼 속성 set attribute
			form.name = 'newForm';
			form.method = 'get';
			form.action = '/msg/leave/update.do';
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
	<script>
		/*기조정내역 테이블  */
		function modalDel() {
			
			$(".delTr").remove();

		};

		/* 모달 테이블 */
		var empNo;

		function modal(btn) {

			var btnNo = $(btn).val();
			console.log("empNo =", btnNo);
			empNo = $(btn).val();

			$.ajax({
				url : "/msg/leave/modal",
				type : "GET",
				data : {
					empNo : btnNo
				},
				success : function(data) {
					var str = '';
					$.each(data, function(i, item) {
						str += '<tr class ="delTr"><td>' + item.vctnNm
								+ '</td><td>' + item.vctnAmt + '</td><td>'
								+ item.edocId + '</td><td>' + item.vctnReason
								+ '</td><td>' + item.vctnUpdtDt;
						str += '</tr>'
					});
					$("#modalAjax").append(str);
				}

			});

			$.ajax({
				url : "/msg/leave/modalSearch",
				type : "GET",
				success : function(data) {
					var str = [];
					$.each(data, function(i, item) {
						str[i] = "제목 : " + item.edocTitle + " 문서ID : "
								+ item.edocId;

					});

					$("#search").autocomplete({
						source : str
					});
					console.log("STR =", str);

				}

			});

		};

		/*모달 내용 삽입  */
		function modalSub() {
			var vctnCd = "";
			if ($("input:radio[id='box2']").is(":checked")) {

				vctnCd = "V1";

			} else if ($("input:radio[id='box1']").is(":checked")) {

				vctnCd = "V2";

			}
			if (vctnCd == "") {
				alert("연차 또는 포상을 선택해주세요.")
				return;
			}

			var vctnAmt = $("#Qty").val();

			var vctnReason = $("#reasonBox").val();

			var edocId;
			var edocIdSearch = $("#search").val();
			var lastIdx = edocIdSearch.lastIndexOf(":");
			edocId = edocIdSearch.substring(lastIdx + 1);

			console.log("edocId", edocId);
			console.log("vctnReason", vctnReason);
			console.log("vctnCd", vctnCd);
			console.log("vctnAmt", vctnAmt);

			$.ajax({
				url : "/msg/leave/update.do",
				type : "POST",
				data : {
					empNo : empNo,
					edocId : edocId,
					vctnCd : vctnCd,
					vctnAmt : vctnAmt,
					vctnReason : vctnReason
				},
				dataType : "JSON",
				success : function(data) {

				}
			});
			/* $(".modal").modal('hide'); */
			$(".delTr").remove();
			/*  $("#test").hide(); */
			$("#test").modal("hide");
			/* 	$(".jquery-modal blocker current").modal("hide"); */

		};
		
	
	</script>

</body>
</html>