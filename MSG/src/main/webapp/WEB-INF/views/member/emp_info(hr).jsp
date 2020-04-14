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
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/listForm.css">
<script
	src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
<title>송종기 대리 :: 인적사항</title>
<style>
body {
	font-family: 'Noto Sans KR', sans-serif;
}

.left {
	float: right;
}

article {
	margin: 0 auto;
	font-size: 16px;
}
section > div {
	border: none;
}

article .content {
	background-color: #FEFEFE;
	width: 900px;
	height: 800px;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}

.x {
	margin: 30px 30px 0 0;
	text-align: right;
}

.x div {
	position: absolute;
	background-color: #F4CA25;
	width: 30px;
	height: 30px;
	border-radius: 50%;
	margin: 60px 0 0 90px;
}

.x img {
	width: 35px;
	height: 35px;
	cursor: pointer;
}

.picture {
	float: left;
	padding: 20px 60px 0 120px;
	text-align: center;
}

.picture>img {
	height: 200px;
	width: 200px;
	border-radius: 50%;
}

.picture p {
	font-size: 21px;
	margin: 20px 0 0 0;
}

.picture p:last-of-type {
	font-size: 45px;
	font-weight: 700;
	margin: 0;
}

.about {
	float: left;
	text-align: left;
	margin: 0 60px 0 61px;
}

#info-tbl {
	width: 50%;
	line-height: 40px;
	margin-top: 20px;
}

#info-tbl td {
	color: #333;
	width: 70%;
	text-align: left;
}

#info-tbl td:first-of-type {
	color: #333;
	width: 30%;
	text-align: center;
}

#info-tbl tr {
	width: 350px;
	display: flex;
	border-bottom: 1px solid #999;
}

#info-tbl tr:first-child {
	border-top: 4px solid #999;
}

#info-tbl tr:last-child {
	margin-bottom: 50px;
}

.statusbox {
	text-align: center;
	margin-top: 400px;
}

.statusbox img {
	width: 100px;
	height: 100px;
	position: relative;
}

.status {
	width: 65%;
	height: 30px;
	resize: none;
	padding: 20px 20px 20px 0;
	text-align: center;
	font-size: 20px;
	outline: none;
	font-family: 'Noto Sans KR', sans-serif;
	border: none;
}

.quote-left::before, .quote-right::before {
	position: relative;
	top: -30px;
	color: #F4CA25;
}

.buttons {
	display: inline-block;
	margin-top: 50px;
}

.buttons button:hover {
    font-weight: bold;
    color: #fefefe;
    border: none;
    background-color: #f4ca25;
    cursor: pointer;
}

.buttons button {
    width: 100px;
    height: 55px;
    font-size: 19px;
    color: #999;
    background-color: #fefefe;
    border: 1px solid #999;
	margin: 20px;
}

.annotation {
	text-align: left;
	margin-left: 80px;
}

.select-box {
	position: relative;
	display: flex; /* left: -210px; */ /* top: -40px; */
	width: 100%;
	font-family: "Noto Sans KR";
	font-size: 19px;
	color: #333333;
}

@media ( min-width : 110px) {
	.select-box {
		width: 170px;
	}
}
/* 여기서부터 select-box */
.select-box {
	position: relative;
	display: inline-block;
	width: 100%;
	font-family: "Noto Sans KR";
	font-size: 18px;
	color: #333333;
}

@media ( min-width : 110px) {
	.select-box {
		width: 110px;
		/* float:right; */
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
	width: 100%;
	margin: 0;
	padding: 10px;
	padding-right: 20px;
	background-color: #FEFEFE;
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
}

.select-box__option {
	display: block;
	padding: 10px;
	background-color: #FEFEFE;
}

.select-box__option:hover, .select-box__option:focus {
	color: #333333;
	background-color: #EBEBEB;
}

.change-quote-color::before {
	color: #F4CA25;
}

.status:focus::placeholder {
	color: transparent;
}

.hidden {
	display: none;
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
#info-tbl input[type=text] {
	background-color: #ebebeb;
	padding: 5px;
	width: 180px;
}

.picture p.imgStatus {
	color: gray;
	font-size: 0.3em;
}
</style>
</head>
<title>사원 정보</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<section>
		<div>
			<article>
				<form
					action="${pageContext.request.contextPath }/member/updateEmp.do"
					method="POST" enctype="multipart/form-data">
					<input type="hidden" name="empNo" value="${emp.empNo }" />
					<div class="content">
						<div class="x">
							<div></div>
							<a href="${pageContext.request.contextPath }/member/orgChart.do"><img
								src="${pageContext.request.contextPath }/resources/image/X.png"
								alt=""></a>
						</div>
						<div class="picture">
							<img class="profileImg"
								src="${pageContext.request.contextPath }/resources/upload/empImg/${emp.empImage}"
								alt="${emp.empName }.png" />
							<p class="imgStatus" style="display: none;">새로운 이미지가
								등록대기중입니다....</p>
							<input type="file" name="empImage_" class="uploadImg"
								style="display: none;" />
							<p>${emp.deptName } ${emp.jobName }</p>
							<p>${emp.empName }</p>
						</div>
						<div class="about">
							<table id="info-tbl">
								<tr>
									<td>사번</td>
									<td>${emp.empNo }</td>
								</tr>
								<tr>
									<td>입사일</td>
									<td>${emp.hireDate }</td>
								</tr>
								<tr>
									<td>아이디</td>
									<td>${emp.userId }</td>
								</tr>
								<tr>
									<td>이메일</td>
									<td><span class="email">${emp.empEmail }</span> <input
										type="text" name="empEmail" class="email hidden"
										value="${emp.empEmail }"></td>
								</tr>
								<tr>
									<td>생일</td>
									<td>${birthDay }</td>
								</tr>
								<tr>
									<td>연락처</td>
									<td><span class="contact">${emp.empContact }</span> <input
										type="text" name="empContact" class="contact hidden"
										value="${emp.empContact }"></td>
								</tr>
								<tr>
									<td>주소</td>
									<td><span class="address">${emp.empAddress }</span> <input
										type="text" name="empAddress" class="address hidden"
										value="${emp.empAddress }"></td>
								</tr>
							</table>
						</div>
						<div class="buttons">
							<div class="select-box">
								<div class="select-box__current" tabindex="1">
									<div class="select-box__value">
										<input class="select-box__input" type="radio" id="H" value="H"
											name="auth" >
										<p class="select-box__input-text">인사관리</p>
									</div>
									<div class="select-box__value">
										<input class="select-box__input" type="radio" id="N" value="N"
											name="auth" />
										<p class="select-box__input-text">일반사원</p>
									</div>
									<div class="select-box__value">
										<input class="select-box__input" type="radio" id="A" value="A"
											name="auth" />
										<p class="select-box__input-text">관리자</p>
									</div>
									<img class="select-box__icon"
										src="http://cdn.onlinewebfonts.com/svg/img_295694.svg"
										alt="Arrow Icon" aria-hidden="true" />
								</div>
								<ul class="select-box__list">
									<li><label class="select-box__option" for="H"
										aria-hidden="aria-hidden">인사관리</label></li>
									<li><label class="select-box__option" for="N"
										aria-hidden="aria-hidden">일반사원</label></li>
									<li><label class="select-box__option" for="A"
										aria-hidden="aria-hidden">관리자</label></li>
								</ul>
							</div>
							<button type="submit" class="submit">수정</button>
						</div>
					</div>
				</form>
			</article>
		</div>
	</section>
	<script>
		$(document).ready(function(){
			$("#${emp.authority}").prop("checked", true);
		})
		$(function() {
			$(".temp_pwd").click(function() {
				alert("임시 비밀번호가 sjong@gmail.com 으로 전송되었습니다.");
			});

			$(".status").focus(function() {
				$("#status").css('border-bottom', '1px solid #999');
				$(".quote-left,.quote-right").addClass('change-quote-color');
			});
			$(".status").blur(
					function() {
						$("#status").css('border-bottom', '0px solid #999');
						$(".quote-left,.quote-right").removeClass(
								'change-quote-color');
					});
			$("span.email").click(function() {
				let text = $("span.email").text();
				$("input.email").removeClass('hidden').focus();
				$("span.email").addClass('hidden');
			});
			$("span.contact").click(function() {
				let text = $("span.contact").text();
				$("input.contact").removeClass('hidden').focus();
				$("span.contact").addClass('hidden');
			});
			$("span.address").click(function() {
				let text = $("span.address").text();
				$("input.address").removeClass('hidden').focus();
				$("span.address").addClass('hidden');
			});
			$("input.email").focusout(function() {
				let text = $("input.email").val();
				if (text != "") {
					$("input.email").addClass('hidden');
					$("span.email").removeClass('hidden').text(text);
				}
			});
			$("input.contact").focusout(function() {
				let text = $("input.contact").val();
				if (text != "") {
					$("input.contact").addClass('hidden');
					$("span.contact").removeClass('hidden').text(text);
				}
			});
			$("input.address").focusout(function() {
				let text = $("input.address").val();
				if (text != "") {
					$("input.address").addClass('hidden');
					$("span.address").removeClass('hidden').text(text);
				}
			});

			$(".profileImg").click(function() {
				$(".uploadImg").click();
			})

			$(".uploadImg").change(function(e) {
				$(".imgStatus").show();
			})
		});
	</script>
</body>
</html>