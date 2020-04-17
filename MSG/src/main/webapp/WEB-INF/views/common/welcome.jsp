<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>MSG</title>
<script
	src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/main.css">
<link
	href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Sen:wght@400;700&display=swap"
	rel="stylesheet">
<script src="https://kit.fontawesome.com/4c554cd518.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<script src='https://kit.fontawesome.com/a076d05399.js'></script>

</head>
<style>
article {
	overflow: hidden;
}

.welcomeBox {
	opacity: 0.4;
	position: absolute;
	top: 355px;
	width: 100%;
	height: 100%;
	z-index: 0;
	font-size: 30px;
	text-align: center;
}

.welcomeBox p {
	font-size: 34px;
	margin: 0;
	font-weight: 900;
}
.welcomeBoard td:nth-child(1) {
	width: 22%;
}
.welcomeBoard td:nth-child(2) {
	text-align: left;
	text-overflow: ellipsis;
}
.welcomeBoard td:nth-child(3) {
	width: 24%;
}
.welcomeEdoc td:nth-child(1) {
	width: 22%;
}
.welcomeEdoc td:nth-child(2) {
	width: 22%;
}
.welcomeEdoc td:nth-child(3) {
	text-align: left;
	text-overflow: ellipsis;
}


</style>
<script>
	function view(no, empNo, memberEmpno) {
		location.href = "${pageContext.request.contextPath}/board/view.do?boardNo="
				+ no + "&empNo=" + empNo + "&memberEmpno=" + memberEmpno;

	}

	$('a[href="#ex7"]').click(function(event) {
		event.preventDefault();

		$(this).modal({
			fadeDuration : 250
		});
	});
	$(document).ready(
			function() {
				$("tr[data-edoc-no]").on(
					"click",
					function() {
						let edocId = $(this).attr("data-edoc-no");
						let edocTitleFromPage = $(this).attr("data-edoc-title");
						// console.log(edocTitle);
						location.href = "${pageContext.request.contextPath}/edoc/edocSrchView.do?edocId="
								+ edocId
								+"&edocTitleFromPage="
								+ edocTitleFromPage;
					});

	});

	
</script>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<section>
		<div>
			<article>
				<div style="margin-left: 15px;" class="subNav">
					<div style="margin-top: 55px;">
						<a id="Scr" href="#ex1" rel="modal:open" style="text-decoration: none;">
							<button type="button" name="" id="boardBtn1" class="yellowBtn">접속자
								확인</button>
						</a>
<!-- 						<button type="button" name="" id="boardBtn2" class="yellowBtn">팀
							채널 가기</button> -->
					</div>
					<!-- 접속자확인 모달 -->
					<div style="bottom: 22px; width: 317px; z-index: 100;" id="ex1"
						class="modal">
						<p>접속자 확인</p>
						<div style="text-align: left; height: 300px; width: 280px; overflow-y: scroll;">
							<ul class="mainLi" id="userLogin">
								<c:forEach items="${userList }" var="u">
									<c:forEach items="${memberList }" var="m">
										<c:if test="${u.id == m.userId }">
											<li><a href="#" onclick="">
													<img
													src="${pageContext.request.contextPath }/resources/upload/empImg/${m.empImage}"
													class="member-img">
													<span
													style="position: relative; top: -15px; margin-bottom: -30px; margin-right: 10px;"
													class="headerlistname">${m.empName }  ${m.jobName } </span>
													
											<i class="fas fa-circle" style="font-size: 15px; color: green; margin-right: 5px;"></i>
													</li>
										</c:if>
									</c:forEach>
								</c:forEach>
								<c:forEach items="${userList }" var="u">
									<c:forEach items="${memberList }" var="m">
										<c:if test="${u.id != m.userId }">
											<li><a href="#" onclick=""> 
													<img
													src="${pageContext.request.contextPath }/resources/upload/empImg/${m.empImage}"
													class="member-img">
													<span
													style="position: relative; top: -15px; margin-bottom: -29px; margin-right: 10px;"
													class="headerlistname">${m.empName }  ${m.jobName } </span>
											<i class="fas fa-circle"
													style="font-size: 15px; color: gray; margin-right: 5px;"></i>
													</li>
										</c:if>
									</c:forEach>
								</c:forEach>
							</ul>
						</div>
            <style>						  
            .modal a.close-modal{
				top: 13px;
				right: 15px;
				width: 20px;
				background-image: url("${pageContext.request.contextPath }/resources/image/X-icon.png");
            }
            .dummyDiv {
            	background-color: #fefefe;
				top: -30px;
			    position: relative;
			    height: 25px;
            }
            
            
            </style>
						<div style="height: 30px;">
							<a rel="modal:close">
								<button id="grayBtnModal" rel="modal:close">닫기</button>
							</a>
						</div>
					</div>
					<div
						style="bottom: 60px; width: 100px; position: relative; left: 825px; text-align: right;">
						<img style="right: 0px; width: 190px; height: 75px;"
							src="${pageContext.request.contextPath }/resources/image/msgMain.png" />
					</div>
				</div>
				<div style="width: 500px;" class="content1">
					<div style="width: 500px; margin-bottom: 50px; margin-top: 30px;"
						id="notice">
						<p style="text-align: left; margin-left: 40px;">
							<i style="color: #f4ca25;" class="fas fa-circle"></i> 공지사항
						</p>
						<table class="welcomeBoard">
							<tr>
								<th>글쓴이</th>
								<th>제목</th>
								<th>작성일</th>

							</tr>
							<c:forEach begin="0" end="5" items="${boardList }" var="bl">
								<tr
									onClick="view('${bl.no}', '${bl.empNo }', '${memberLoggedIn.empNo }');"
									style="cursor: pointer;">
									<td>${bl.empName }</td>
									<td>${bl.title }</td>
									<td>${bl.bdate }</td>
								</tr>
							</c:forEach>
						</table>
					</div>
					<div id="55">
						<p style="text-align: left; margin-left: 40px;">
							<i style="color: #f4ca25;" class="fas fa-circle"></i> 전자문서
						</p>
						<table class="welcomeEdoc">
							<tr>
								<th>기안자</th>
								<th>문서종류</th>
								<th>제목</th>
							</tr>
						<c:forEach items="${edocList }" var="ed">
							<tr data-edoc-no="${ed.edocId }" data-edoc-title="${ed.edocTitle }">
								<td>${ed.empName }</td>
								<td>${ed.formNm }</td>
								<td>${ed.edocTitle }</td>
							</tr>
						</c:forEach>	
						</table>
					</div>
				</div>
				<div style="width: 500px;" id="content2">
					<div style="width: 500px; margin-bottom: 34px; margin-top: 30px;"
						id="notice">
						<div id="calender"
							style="width: 400px; height: 300px; margin-left: 50px;">
							<iframe
								src="https://calendar.google.com/calendar/embed?src=ltm0jrlsamv8mlhrg0bpcgu6ps%40group.calendar.google.com&ctz=Asia%2FSeoul&amp;showTitle=0&amp;showNav=0&amp;showPrint=0&amp;showTabs=0&amp;showCalendars=0&amp;showTz=0"
								" style="border-width: 0" width="400" height="300"
								frameborder="0" scrolling="no"></iframe>
							<div class="dummyDiv"></div>
						</div>
					</div>
					<div id="66">
						<p class="hover_" style="text-align: left; margin-left: 40px;">
							<i style="color: #f4ca25;" class="fas fa-circle"></i> 이번 주 일정
						</p>
						<div id="66hover">
							<div id="informSched">
								<div class="alldayY"></div>
								<p>하루종일</p>
								<div class="alldayN closer"></div>
								<p class="div">하루 미만</p>
								<hr />
								<div class="schedCircle" id="c1"></div>
								<p>회의</p>
								<div class="schedCircle" id="c2"></div>
								<p>기타</p>
								<div class="schedCircle" id="c3"></div>
								<p>외근</p>
								<div class="schedCircle" id="c4"></div>
								<p>휴가</p>
								<div class="schedCircle" id="c5"></div>
								<p>출장</p>
								<div class="schedCircle" id="c6"></div>
								<p id="over">데드라인</p>
								<div class="schedCircle" id="c7"></div>
								<p>회의실 예약</p>
								<div class="schedCircle closer2" id="c8"></div>
								<p class="over2">차량 예약</p>
								<div class="schedCircle" id="c9"></div>
								<p>생일</p>
							</div>
						</div>
						<table id="calTable" style="text-align: left; cursor: pointer;"
							onclick="location.href='${pageContext.request.contextPath}/sched/calcover.do'"">
							<tr>
								<td id="day_1"></td>
								<td>월</td>
								<td></td>
							</tr>
							<tr>
								<td id="day_2"></td>
								<td>화</td>
								<td></td>
							</tr>
							<tr>
								<td id="day_3"></td>
								<td>수</td>
								<td></td>
							</tr>
							<tr>
								<td id="day_4"></td>
								<td>목</td>
								<td></td>
							</tr>
							<tr>
								<td id="day_5"></td>
								<td>금</td>
								<td></td>
							</tr>
							<tr>
								<td id="day_6"></td>
								<td>토</td>
								<td></td>
							</tr>
							<tr>
								<td id="day_7"></td>
								<td>일</td>
								<td></td>
							</tr>

						</table>
						<!--   <div title="그룹웨어만들기" style="width:30px; height:30px; border-radius:30px; background:#f4ca25;"></div> -->
					</div>
				</div>
			</article>
		</div>
	</section>
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
</body>
</html>
