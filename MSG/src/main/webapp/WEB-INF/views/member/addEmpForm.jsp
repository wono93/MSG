<!DOCTYPE html>
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
<script
	src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
<title>MSG :: 사원등록</title>
</head>
<style>
body { /* position: absolute;  */
	background-color: #EBEBEB;
	/*  left: 50%; transform: translateX(-50%);  */
	font-family: 'Noto Sans KR';
}
/* -------------------------------------------------------------------------------------------- */
section {
	position: absolute;
	text-align: center;
	width: 100%;
	height: 100%;
	left: 0;
	top: 0;
}

section>div {
	display: inline-block;
	width: 1200px;
	height: 100%;
	vertical-align: middle;
	/* border: 1px solid black; */
}

article>.content {
	display: inline-block;
	width: 1020px;
	height: 100%;
	vertical-align: middle;
	/* border: 1px solid black; */
	background-color: #fefefe;
}

.subNav::after {
	content: "";
	display: block;
	clear: both;
}

.subNav>h3 {
	margin: 75px 0 0 0px;
	font-size: 36px;
	font-weight: 900;
	text-align: left;
}

.subNav li {
	list-style: none;
	float: left;
	margin: 45px 45px 30px 0px;
	font-size: 21px;
	font-family: 'Noto Sans KR';
	color: #999;
	cursor: pointer;
}
/* -------------------------------------------------------------------------------------------- */
input {
	outline: none;
}

.left {
	float: left;
}
/* section{ width: 1200px; padding: 100px 100px; background-color: #EBEBEB; } */
#title {
	margin: 0 0;
	font-weight: 800;
	font-size: 38px;
}
/*     nav{ padding: 50px 0px; }
    nav a{ margin: 0 40px 0 0; text-decoration: none; color: #999999; font-size: 25px; } */
#enroll-container {
	position: relative;
	width: 1000px;
	padding: 65px 80px;
	background-color: #FEFEFE;
}

.input-div {
	display: inline-block;
	font-weight: 600;
	font-size: 18px;
    text-align: left;
}

.input-div>p {
	margin: 20px 0 10px 0;
}

.input-div-pic {
    text-align: left;
	display: inline-block;
	font-weight: 600;
	font-size: 18px;
	margin-left: 40px;
}

input::placeholder {
	font-size: 20px;
}

.row1 {
	width: 468px;
}

.row2 {
	width: 980px;
}

.row3 {
	width: 150px;
}

.row4 {
	width: 215px;
}

.ph::placeholder {
	font-size: 20px;
	font-weight: 600;
	color: black;
	text-align: right;
	padding-right: 30px;
}

input {
	height: 80px;
	width: inherit;
	background: #ebebeb;
	border: none;
	padding-left: 20px;
	font-size: 22px;
	font-family: 'Noto Sans KR';
}

.position {
	position: relative;
	left: 70px;
}

.authority {
	position: relative;
	left: 500px;
}

#enroll {
	width: 300px;
	height: 84px;
	border: 2px solid #999;
	background-color: #fefefe;
	color: #999;
	font-size: 30px;
	font-weight: 800;
	margin-top: 20px;
	padding: 0;
	cursor: pointer;
}

#enroll:hover {
	background-color: #f4ca25;
	color: #fefefe;
	border: none;
}

#button {
	margin: 93px -10px -2px 10px;
}
}
/* 파일첨부 */
.filebox input[type="file"] {
	position: absolute;
	width: 0;
	height: 0;
	padding: 0;
	overflow: hidden;
	border: 0;
}

.filebox label {
	position: absolute;
	display: inline-block;
	height: 58px;
	margin-right: 10px;
	padding: 10px 20px;
	color: #999;
	vertical-align: middle;
	background-color: #fefefe;
	cursor: pointer;
	border: 2px solid #999;
}

.filebox label:hover {
	color: #fefefe;
	background-color: #999;
}

.filebox .upload-name {
	display: inline-block;
	margin-left:126px;
	width: 322px;
	height: 82px;
	font-size: 18px;
	padding: 0 20px;
	vertical-align: middle;
	background-color: #ebebeb;
}
/* 아이디저장 체크박스*/
.chkdiv {
	position: relative;
	left: 220px;
	top: -20px;
	width: 180px;
}

.saveId-container {
	display: inline;
    position: absolute;
    padding: 10px 0 0 70px;
    cursor: pointer;
    font-size: 22px;
    top: -40px;
}

.saveId-container input {
	position: absolute;
	opacity: 0;
	cursor: pointer;
}

.saveId-checkmark {
	position: absolute;
	top: 3px;
	left: 0;
	height: 50px;
	width: 50px;
	background-color: #EBEBEB;
}

.saveId-container:hover input ~ .saveId-checkmark {
	background-color: #ccc;
}

.saveId-container input:checked ~ .saveId-checkmark {
	background-color: #F4CA25;
}

.saveId-checkmark:after {
	content: "";
	position: absolute;
	display: none;
} /*클릭시 체크생성*/
.saveId-container input:checked ~ .saveId-checkmark:after {
	display: inline;
}

.saveId-container .saveId-checkmark:after {
	left: 20px;
	top: 5px;
	width: 10px;
	height: 30px;
	border: solid white;
	border-width: 0 3px 3px 0;
	-webkit-transform: rotate(45deg);
	-ms-transform: rotate(45deg);
	transform: rotate(45deg);
}

.checkbox_wrap {
	position: relative;
}

.select-box {
	position: relative;
	display: flex;
	top: 30px;
	width: 100%;
	font-family: "Noto Sans KR";
	font-size: 19px;
	color: #333333;
}

@media ( min-width : 110px) {
	.select-box {
		width: 110px;
	}
}
/* 여기서부터 select-box */
.select-box {
	position: relative;
	display: inline-block;
	width: 100%;
	font-family: "Noto Sans KR";
	font-size: 22px;
	color: #333333;
	left: 10px;
}

@media ( min-width : 110px) {
	.select-box {
		width: 200px;    
		margin-right: 18px;
	}
}

.select-box__current {
	position: relative;
	border: 2px solid #999;
	cursor: pointer;
	outline: none;
}

.select-box__current:focus+.select-box__list {
	opacity: 1;
	-webkit-animation-name: none;
	animation-name: none;
}

.select-box__current:focus+.select-box__list .select-box__option {
	cursor: pointer;
}

.select-box__current:focus .select-box__icon {
	-webkit-transform: translateY(-50%) rotate(180deg);
	transform: translateY(-50%) rotate(180deg);
}

.select-box__icon {
	position: absolute;
	top: 50%;
	right: 7px;
	-webkit-transform: translateY(-50%);
	transform: translateY(-50%);
	width: 13px;
	opacity: 0.3;
	-webkit-transition: 0.2s ease;
	transition: 0.2s ease;
}

.select-box__value {
	display: -webkit-box;
	display: flex;
}

.select-box__input {
	display: none;
}

.select-box__input:checked+.select-box__input-text {
	display: block;
}

.select-box__input-text {
	display: none;
	text-align:center;
	/* width: 100%; */
	margin: 0;
	padding: 15px;
	padding-right: 30px;
	background-color: #fefefe;
}

.select-box__list {
	position: absolute;
	width: 100%;
	padding: 0;
	list-style: none;
	opacity: 0;
	-webkit-animation-name: HideList;
	animation-name: HideList;
	-webkit-animation-duration: 0.5s;
	animation-duration: 0.5s;
	-webkit-animation-delay: 0.5s;
	animation-delay: 0.5s;
	-webkit-animation-fill-mode: forwards;
	animation-fill-mode: forwards;
	-webkit-animation-timing-function: step-start;
	animation-timing-function: step-start;
	text-align : center;
	overflow: scroll;
	overflow-x : hidden;
	height : 250px;
}

.select-box__option {
	display: block;
	padding: 10px;
	background-color: #fefefe;
}

.select-box__option:hover, .select-box__option:focus {
	color: #333333;
	background-color: #ebebeb;
}

@
-webkit-keyframes HideList {from { -webkit-transform:scaleY(1);
	transform: scaleY(1);
}

to {
	-webkit-transform: scaleY(0);
	transform: scaleY(0);
}

}
@
keyframes HideList {from { -webkit-transform:scaleY(1);
	transform: scaleY(1);
}

to {
	-webkit-transform: scaleY(0);
	transform: scaleY(0);
}
}
</style>
<script>
	//파일을 올리면 파일명 표시 
	$(function() {
		$("#file").on('change', function() {
			let fileName = $("#file").val();
			$(".upload-name").val(fileName);
		});
	});
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

				<!-- 		        <p id="title">인사관리</p>
		        <nav>
		            <a href="">근태</a>
		            <a href="">급여</a>
		            <a href="">휴가관리</a>
		            <a href="">조직도</a>
		            <a href="">권한관리</a>
		            <a href="">사원등록</a>
		            <a href="">사원정보수정</a>
		        </nav> -->
				<div class=".content">
					<div id="enroll-container">
						<form
							action="${pageContext.request.contextPath}/member/addEmpFormSubmit.do"
							method="POST" enctype="multipart/form-data">

							<div class="input-div row1" style="padding-right: 40px;">
								<p>아이디</p>
								<input type="text" name="userId" placeholder="아이디 입력">
							</div>
							<div class="input-div row1">
								<p>비밀번호</p>
								<input type="password" name="userPwd">
							</div>
							<div class="input-div row1" style="padding-right: 40px;">
								<p>사원명</p>
								<input type="text" name="empName">
							</div>
							<div class="input-div row1">
								<p>주민등록번호</p>
								<input type="text" name="empRRNNo" placeholder="- 제외 13자리 입력">
							</div>
							<div class="input-div row1">
								<p>이메일</p>
								<input type="email" name="empEmail">
							</div>
							<div class="filebox input-div-pic row1">
								<p>사진</p>
								<label for="file"><p>파일선택</p></label> <input type="file"
									name="empImage_" id="file" style="display:none;"> <input type="text"
									class="upload-name" value="선택된 파일이 없습니다" readonly />
							</div>
							<div class="input-div row1" style="padding-right: 40px;">
								<p>연락처</p>
								<input type="text" name="empContact">
							</div>
							<div class="input-div row1">
								<p>주소</p>
								<input type="text" name="empAddress">
							</div>
							<div class="input-div row1" style="width:110%; margin-top:34px;">
								<div class="select-box">
									<div class="select-box__current" tabindex="1">
										<c:forEach items="${depts }" var="depts">
											<div class="select-box__value">
												<input class="select-box__input" type="radio"
													id="${depts.deptCd }" value="${depts.deptCd }"
													name="deptCd" />
												<p class="select-box__input-text">${depts.deptName }</p>
											</div>
										</c:forEach>
										<input class="select-box__input" type="radio" id="none"
											value="none" name="department" checked="checked" />
										<p class="select-box__input-text">소속부서</p>
										<img class="select-box__icon"
											src="http://cdn.onlinewebfonts.com/svg/img_295694.svg"
											alt="Arrow Icon" aria-hidden="true" />
									</div>
									<ul class="select-box__list">
										<c:forEach items="${depts }" var="depts">
											<li><label class="select-box__option"
												for="${depts.deptCd }" aria-hidden="aria-hidden">${depts.deptName }</label></li>
										</c:forEach>
									</ul>
								</div>
								<div class="select-box">
									<div class="select-box__current" tabindex="1">
										<c:forEach items="${jobs }" var="jobs">
											<div class="select-box__value">
												<input class="select-box__input" type="radio"
													id="${jobs.jobCd }" value="${jobs.jobCd }" name="jobCd" />
												<p class="select-box__input-text">${jobs.jobName }</p>
											</div>
										</c:forEach>
										<input class="select-box__input" type="radio" id="none"
											value="none" name="job" checked="checked" />
										<p class="select-box__input-text">직위</p>
										<img class="select-box__icon"
											src="http://cdn.onlinewebfonts.com/svg/img_295694.svg"
											alt="Arrow Icon" aria-hidden="true" />
									</div>
									<ul class="select-box__list">
										<c:forEach items="${jobs }" var="jobs">
											<li><label class="select-box__option"
												for="${jobs.jobCd }" aria-hidden="aria-hidden">${jobs.jobName }</label></li>
										</c:forEach>
									</ul>
								</div>
								<div class="select-box"> 
									<label class="saveId-container float" for="isManager">팀장 여부 
									<input type="checkbox" name="isManager" id="isManager" value="Y"
									style="position: relative; left: -65px; top: 15px; width: 180px; height: 42px"><span class="saveId-checkmark"></span></label> 
								</div>
								<div class="select-box" style=" margin-left: 131px;">
									<div class="select-box__current" tabindex="1">
										<div class="select-box__value">
											<input class="select-box__input" type="radio" id="N"
												value="N" name="authority" />
											<p class="select-box__input-text">일반사원</p>
										</div>
										<div class="select-box__value">
											<input class="select-box__input" type="radio" id="H"
												value="H" name="authority" />
											<p class="select-box__input-text">인사관리자</p>
										</div>
										<div class="select-box__value">
											<input class="select-box__input" type="radio" id="A"
												value="A" name="authority" />
											<p class="select-box__input-text">관리자</p>
										</div>
										<div class="select-box__value">
											<input class="select-box__input" type="radio" id="none"
												value="none" name="authority" checked="checked" />
											<p class="select-box__input-text" style="width:100%">권한설정</p>
										</div>
										<img class="select-box__icon"
											src="http://cdn.onlinewebfonts.com/svg/img_295694.svg"
											alt="Arrow Icon" aria-hidden="true" />
									</div>
									<ul class="select-box__list" style="height:auto; overflow:auto;">
										<li><label class="select-box__option" for="N"
											aria-hidden="aria-hidden">일반사원</label></li>
										<li><label class="select-box__option" for="H"
											aria-hidden="aria-hidden">인사관리자</label></li>
										<li><label class="select-box__option" for="A"
											aria-hidden="aria-hidden">관리자</label></li>
									</ul>
								</div>
							</div>
							<input type="hidden" name="isManager" id="isManager" value="N" />
							<div id="button">
								<input type="submit" id="enroll" value="사원 등록">
							</div>
						</form>
					</div>
				</div>
			</article>
		</div>
	</section>
</body>
</html>