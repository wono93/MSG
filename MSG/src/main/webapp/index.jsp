<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>MSG | 로그인</title>
<script src="<%=request.getContextPath()%>/resources/js/jquery-3.4.1.js"></script>
<link href="https://fonts.googleapis.com/css?family=Josefin+Sans&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/member/main.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/member/login.css">
<script src="https://kit.fontawesome.com/226b55f414.js" crossorigin="anonymous"></script>
<style>
.thick { font-weight: bold; }
.float {float: left;}
.clear {clear: both;}
.inline-block {display: inline-block;}
.login-label { text-align: left; margin-top: 10px; margin-left: 309px;}
html { background-color: #EBEBEB;}
*{ margin: 0; padding:0; border:0; font-family: 'Noto Sans KR', sans-serif;}
h3{color: #333333; font-size:48px; margin: 100px 0 50px 0;}
#loginForm {text-align: center;}
#loginForm h1+p, h3+p { margin-top: 15px;}
#loginFrm {width: 100%; height:auto;}
#loginFrm>div {width:1200px; padding-top: 80px; margin:0 auto; text-align: center; background-color: #FEFEFE;}
#loginFrm>p {color: #333333; font-size: 16px;}
#loginFrm label { color: #333333; font-size: 18px; position: absolute;  left: 310px; margin-bottom: 10px; padding-left: 65px; padding-top: 15px;}
/* #loginFrm label:nth-of-type(1) { color: #3B3B3B; font-size:20px; position: absolute; left:310px; margin-bottom: 10px;}
#loginFrm label:nth-of-type(2) { color: #3B3B3B; font-size:20px; position: absolute; left:310px; top: 725px; margin-bottom: 10px;} */
#loginFrm>div>input[type] {width:540px; height:85px; background:#EBEBEB; border:none; padding-left: 30px; font-size: 25px;}
#loginFrm>div>input[type]::placeholder { color: #333333; font-size: 20px; opacity: 0.8; left: 20px;}
#loginFrm span {color: #3B3B3B; font-size: 20px;}
#loginFrm input[type=text], input[type=password]{ margin: 10px 0; }
.hidden-space { color:#f4ca25; font-size: 16px; position: relative; left:-190px;}
#float-form { margin-top: 20px;}
#enroll-btn{position:relative; color:#999999; font-size: 18px; border:none; background:white; 
    cursor: pointer; margin-left: 646px; border: 1px solid #999999; padding: 12px 35px;}
#login-btn{width:580px; height:85px; background: #F4CA25; border:none; cursor: pointer;}
button[type=button]{margin-top: 30px; margin-bottom: 100px;}
button[type=button]>p{width: 580px; color:#333333; font-size: 30px;}
/* 아이디저장 체크박스*/
.saveId-container { display: inline; position: relative; padding-left: 35px; cursor: pointer; font-size: 20px;}
.saveId-container input {position: absolute; opacity: 0; cursor: pointer; }
.saveId-checkmark { position: absolute; top: 3px; left: 0; height: 50px; width: 50px; background-color: #EBEBEB;}
.saveId-container:hover input ~ .saveId-checkmark { background-color: #ccc;}
.saveId-container input:checked ~ .saveId-checkmark { background-color: #F4CA25; }
.saveId-checkmark:after { content: ""; position: absolute; display: none; } /*클릭시 체크생성*/
.saveId-container input:checked ~ .saveId-checkmark:after { display: inline; }
.saveId-container .saveId-checkmark:after { left: 20px; top: 5px; width: 10px; height: 30px; border: solid white;
                                    border-width: 0 3px 3px 0; -webkit-transform: rotate(45deg); -ms-transform: rotate(45deg); transform: rotate(45deg);}
.checkbox_wrap{position: relative;}
                                    
</style>
<script></script>
</head>
<body id="loginForm">
    <h3 class="thick kor">로그인</h3>
    <div>
    <form id="loginFrm" method="POST" action="${pageContext.request.contextPath}/member/login.do">
        <div>
            <p class="kor login-label">아이디</p>
            <input type="text" name="userId" id="userId"  class="kor"
                   placeholder="아이디를 입력하세요"/>
            <%-- <% if(msg == "존재하지 않는 아이디입니다."){ %> --%>
            <p class="kor hidden-space">존재하지 않는 아이디입니다.</p>
           	<%-- <% } %> --%>
            <p class="kor login-label">비밀번호</p>
            <input type="password" name="password" id="password"  class="kor"
                   placeholder="비밀번호를 입력하세요"/>
           	<%-- <% if(msg == "비밀번호가 틀렸습니다."){ %> --%>
            <p class="kor hidden-space">비밀번호가 틀렸습니다.</p>
            <%-- <% } %> --%>
            <div id="float-form">
                 <div class="checkbox_wrap">
                    <label class="saveId-container kor float" for="saveId">아이디 저장
                        <input type="checkbox" name="saveId" id="saveId">
                        <span class="saveId-checkmark"></span>
                    </label>
                </div>
                <span class="float">
                    <input id="enroll-btn" class="kor float" type="button" value="아이디 / 비밀번호 찾기"/>
                </span>
            </div>
            <button id="login-btn" type="submit"><p class="thick kor">로그인</p></button>
        </div>
    </form>
    </div>

</body>
</html>