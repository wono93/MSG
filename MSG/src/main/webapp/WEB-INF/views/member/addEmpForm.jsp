<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700&display=swap" rel="stylesheet">
    <script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
    <title>MSG :: 사원등록</title>
</head>
<style>
    body{/* position: absolute;  */background-color: #EBEBEB;/*  left: 50%; transform: translateX(-50%);  */font-family: 'Noto Sans KR';}
    /* -------------------------------------------------------------------------------------------- */
section {
    position: absolute;
    text-align: center;
    width: 100%;
    height: 100%;
    left: 0;
    top: 0;
}
section > div {
    display: inline-block;
    width: 1200px;
    height: 100%;
    vertical-align: middle;
    /* border: 1px solid black; */
}   
article > .content {
    display: inline-block;
    width: 1020px;
    height: 100%;
    vertical-align: middle;
    /* border: 1px solid black; */
    background-color: #fefefe;
}

.subNav::after{content:""; display:block; clear:both;}
.subNav > h3{margin:75px 0 0 0px; font-size:36px; font-weight:900; text-align: left;}
.subNav li{list-style: none; float: left; margin: 45px 45px 30px 0px; font-size: 21px; font-family: 'Noto Sans KR'; color:#999; cursor: pointer;}


    /* -------------------------------------------------------------------------------------------- */
    input{outline:none; } 
    .left {float: left;}
    /* section{ width: 1200px; padding: 100px 100px; background-color: #EBEBEB; } */
    #title{ margin: 0 0; font-weight: 800; font-size: 38px; }
/*     nav{ padding: 50px 0px; }
    nav a{ margin: 0 40px 0 0; text-decoration: none; color: #999999; font-size: 25px; } */
    #enroll-container{ position: relative; width: 1000px;  padding: 65px 80px; background-color: #FEFEFE;}
    .input-div{ display: inline-block; font-weight: 600; font-size: 18px; }
    .input-div> p{margin:20px 0 10px 0;}
    .input-div-pic{ display: inline-block; font-weight: 600;font-size: 18px; margin-left: 40px;}
    input::placeholder{ font-size:20px;}
    .row1{ width: 468px; }
    .row2{ width: 980px; }
    .row3{  width: 150px; }
    .row4{ width: 215px;}
    .ph::placeholder{ font-size: 20px; font-weight: 600; color: black; text-align: right; padding-right: 30px; }
    input{ height: 80px; width: inherit; background: #ebebeb; border:none; padding-left: 20px; font-size: 22px; font-family: 'Noto Sans KR';}
    .position{position:relative; left: 70px;}
    .authority{position:relative; left: 500px;}
    #enroll{ width: 300px;  height: 84px; border:2px solid #999; background-color:#fefefe; color:#999;font-size: 30px; font-weight: 800; margin-top:70px; padding:0; cursor: pointer;}
    #enroll:hover{background-color: #f4ca25; color:#fefefe; border:none;}
    #button{ margin: 100px 0 30px 0; text-align: center; } 

    /* 파일첨부 */
    .filebox input[type="file"] { position: absolute; width: 0;  height: 0; padding: 0; overflow: hidden; border: 0; }
    .filebox label {display: inline-block; height: 58px; margin-right: 10px; padding: 10px 20px; color: #999; vertical-align: middle;
        background-color: #fefefe; cursor: pointer; border: 2px solid #999;}
    .filebox label:hover{color:#fefefe; background-color: #999;}
    .filebox .upload-name { display: inline-block; width:322px; height: 82px; font-size:18px; padding: 0 20px; vertical-align: middle;
        background-color: #ebebeb;}

    /* 아이디저장 체크박스*/
    .chkdiv{position:relative; left: 220px; top: -20px; width: 180px;}
    .saveId-container { display: inline; position: relative; padding:10px 0 0 70px; cursor: pointer; font-size: 22px;}
    .saveId-container input {position: absolute; opacity: 0; cursor: pointer; }
    .saveId-checkmark { position: absolute; top: 3px; left: 0; height: 50px; width: 50px; background-color: #EBEBEB;}
    .saveId-container:hover input ~ .saveId-checkmark { background-color: #ccc;}
    .saveId-container input:checked ~ .saveId-checkmark { background-color: #F4CA25; }
    .saveId-checkmark:after { content: ""; position: absolute; display: none; } /*클릭시 체크생성*/
    .saveId-container input:checked ~ .saveId-checkmark:after { display: inline; }
    .saveId-container .saveId-checkmark:after { left: 20px; top: 5px; width: 10px; height: 30px; border: solid white;
                                        border-width: 0 3px 3px 0; -webkit-transform: rotate(45deg); -ms-transform: rotate(45deg); transform: rotate(45deg);}
    .checkbox_wrap{position: relative;}
    .select-box {
    position: relative;
    display: flex;
    top: 30px;
    width: 100%;
    font-family: "Noto Sans KR";
    font-size: 19px;
    color: #333333;
  }
  @media (min-width: 110px) {
    .select-box {
      width: 110px;
    }
  }

  /* 여기서부터 select-box */
.select-box { position: relative; display: inline-block; width: 100%; font-family: "Noto Sans KR";
    font-size: 22px; color: #333333; left: -40px; }
@media (min-width: 110px) { .select-box { width: 200px; float:right;left:50px;} }
.select-box__current { position: relative; border: 2px solid #999; cursor: pointer; outline: none;}
.select-box__current:focus + .select-box__list { opacity: 1;
    -webkit-animation-name: none;
            animation-name: none;
  }
  .select-box__current:focus + .select-box__list .select-box__option {
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
  .select-box__input:checked + .select-box__input-text {
    display: block;
  }
  .select-box__input-text {
    display: none;
    width: 100%;
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
  
  @-webkit-keyframes HideList {
    from {
      -webkit-transform: scaleY(1);
              transform: scaleY(1);
    }
    to {
      -webkit-transform: scaleY(0);
              transform: scaleY(0);
    }
  }
  
  @keyframes HideList {
    from {
      -webkit-transform: scaleY(1);
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
$(function(){
    $("#file").on('change',function(){
        let fileName = $("#file").val();
        $(".upload-name").val(fileName);
    });

});
</script>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <section>
   		<div>
			<article>
                <div class="subNav">
                    <h3>인사관리</h3>
                    <ul>
                        <li onclick="location.href='${pageContext.request.contextPath}/member/list.do'">근태관리</li>
                        <li onclick="location.href='${pageContext.request.contextPath}/member/io.do'">출입기록</li>
                        <li onclick="location.href='${pageContext.request.contextPath}/member/org.do'">조직도</li>
                        <li onclick="location.href='${pageContext.request.contextPath}/leave/update.do'">휴가관리</li>
                        <li onclick="location.href='${pageContext.request.contextPath}/leave/list.do'">휴가내역</li>
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
			            <form action="">
			                <div class="input-div row1" style="padding-right: 40px;">
			                    <p>아이디</p>
			                    <input type="text" name="memberId" placeholder="사번 입력">
			                </div>
			                <div class="input-div row1">
			                    <p>비밀번호</p>
			                    <input type="password" name="memberPwd">
			                </div>
			                <div class="input-div row1" style="padding-right: 40px;">
			                    <p>사원명</p>
			                    <input type="text" name="memberName">
			                </div>
			                <div class="input-div row1">
			                    <p>주민등록번호</p>
			                    <input type="text" name="" placeholder="- 제외 13자리 입력" >
			                </div>
			                <div class="input-div row1">
			                    <p>이메일</p>
			                    <input type="email" name="memberEmail">
			                </div>
			                <div class="filebox input-div-pic"> 
			                    <p>사진</p>
			                    <label for="file"><p>파일선택</p></label> 
			                    <input type="file" id="file"> 
			                      <input type="text" class="upload-name" value="선택된 파일이 없습니다" readonly>
			                  </div>
			                <div class="input-div row2">
			                    <p>주소</p>
			                    <input type="email" name="memberEmail">
			                </div>
			                <div class="input-div row3 left">
			                    <div class="deptBar">
			                        <div class="select-box">
			                            <div class="select-box__current" tabindex="1">
			                                <div class="select-box__value">
			                                <input class="select-box__input" type="radio" id="0" value="0" name="Ben" checked="checked"/>
			                                <p class="select-box__input-text">경리부</p>
			                                </div>
			                                <div class="select-box__value">
			                                <input class="select-box__input" type="radio" id="1" value="1" name="Ben" checked="checked"/>
			                                <p class="select-box__input-text">인사관리부</p>
			                                </div>
			                                <div class="select-box__value">
			                                <input class="select-box__input" type="radio" id="2" value="2" name="Ben" checked="checked"/>
			                                <p class="select-box__input-text">재경부</p>
			                                </div>
			                                <div class="select-box__value">
			                                <input class="select-box__input" type="radio" id="3" value="3" name="Ben" checked="checked"/>
			                                <p class="select-box__input-text">구매부</p>
			                                </div>
			                                <div class="select-box__value">
			                                <input class="select-box__input" type="radio" id="4" value="4" name="Ben" checked="checked"/>
			                                <p class="select-box__input-text">관리부</p>
			                                </div>
			                                <div class="select-box__value">
			                                <input class="select-box__input" type="radio" id="5" value="5" name="Ben" checked="checked"/>
			                                <p class="select-box__input-text">비서실</p>
			                                </div>
			                                <div class="select-box__value">
			                                <input class="select-box__input" type="radio" id="6" value="6" name="Ben" checked="checked"/>
			                                <p class="select-box__input-text">해외사업부</p>
			                                </div>
			                                <div class="select-box__value">
			                                <input class="select-box__input" type="radio" id="7" value="7" name="Ben" checked="checked"/>
			                                <p class="select-box__input-text">총무팀</p>
			                                </div>
			                                <div class="select-box__value">
			                                <input class="select-box__input" type="radio" id="8" value="8" name="Ben" checked="checked"/>
			                                <p class="select-box__input-text">경영지원팀</p>
			                                </div>
			                                <div class="select-box__value">
			                                <input class="select-box__input" type="radio" id="9" value="9" name="Ben" checked="checked"/>
			                                <p class="select-box__input-text">경영개선팀</p>
			                                </div>
			                                <div class="select-box__value">
			                                <input class="select-box__input" type="radio" id="10" value="10" name="Ben" checked="checked"/>
			                                <p class="select-box__input-text">고객만족팀</p>
			                                </div>
			                                <div class="select-box__value">
			                                <input class="select-box__input" type="radio" id="11" value="11" name="Ben" checked="checked"/>
			                                <p class="select-box__input-text">기술지원팀</p>
			                                </div>
			                                <div class="select-box__value">
			                                <input class="select-box__input" type="radio" id="12" value="12" name="Ben" checked="checked"/>
			                                <p class="select-box__input-text">전략기획팀</p>
			                                </div>
			                                <div class="select-box__value">
			                                <input class="select-box__input" type="radio" id="13" value="13" name="Ben" checked="checked"/>
			                                <p class="select-box__input-text">연구기획팀</p>
			                                </div>
			                                <div class="select-box__value">
			                                <input class="select-box__input" type="radio" id="14" value="14" name="Ben" checked="checked"/>
			                                <p class="select-box__input-text">연구개발팀</p>
			                                </div>
			                                <div class="select-box__value">
			                                <input class="select-box__input" type="radio" id="15" value="15" name="Ben" checked="checked"/>
			                                <p class="select-box__input-text">생산관리</p>
			                                </div>
			                                <div class="select-box__value">
			                                <input class="select-box__input" type="radio" id="16" value="16" name="Ben" checked="checked"/>
			                                <p class="select-box__input-text">시설관리</p>
			                                </div>
			                                <div class="select-box__value">
			                                <input class="select-box__input" type="radio" id="17" value="17" name="Ben" checked="checked"/>
			                                <p class="select-box__input-text">영업팀</p>
			                                </div>
			                                <div class="select-box__value">
			                                <input class="select-box__input" type="radio" id="18" value="18" name="Ben" checked="checked"/>
			                                <p class="select-box__input-text">영업기획팀</p>
			                                </div>
			                                <div class="select-box__value">
			                                <input class="select-box__input" type="radio" id="19" value="19" name="Ben" checked="checked"/>
			                                <p class="select-box__input-text">영역지원팀</p>
			                                </div>
			                                <div class="select-box__value">
			                                <input class="select-box__input" type="radio" id="20" value="20" name="Ben" checked="checked"/>
			                                <p class="select-box__input-text">홍보팀</p>
			                                </div>
			                                <div class="select-box__value">
			                                <input class="select-box__input" type="radio" id="21" value="21" name="Ben" checked="checked"/>
			                                <p class="select-box__input-text">품질관리팀</p>
			                                </div>
			                                <div class="select-box__value">
			                                <input class="select-box__input" type="radio" id="none" value="none" name="Ben" checked="checked"/>
			                                <p class="select-box__input-text">소속부서</p>
			                                </div><img class="select-box__icon" src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon" aria-hidden="true"/>
			                            </div>
			                            <ul class="select-box__list">
			                                <li> <label class="select-box__option" for="0" aria-hidden="aria-hidden">경리부</label>  </li>
			                                <li> <label class="select-box__option" for="1" aria-hidden="aria-hidden">인사관리부</label> </li>
			                                <li> <label class="select-box__option" for="2" aria-hidden="aria-hidden">재경부</label> </li>
			                                <li> <label class="select-box__option" for="3" aria-hidden="aria-hidden">구매부</label>  </li>
			                                <li> <label class="select-box__option" for="4" aria-hidden="aria-hidden">관리부</label> </li>
			                                <li> <label class="select-box__option" for="5" aria-hidden="aria-hidden">비서실</label> </li>
			                                <li> <label class="select-box__option" for="6" aria-hidden="aria-hidden">해외사업부</label>  </li>
			                                <li> <label class="select-box__option" for="7" aria-hidden="aria-hidden">총무팀</label> </li>
			                                <li> <label class="select-box__option" for="8" aria-hidden="aria-hidden">경영지원팀</label> </li>
			                                <li> <label class="select-box__option" for="9" aria-hidden="aria-hidden">경영개선팀</label>  </li>
			                                <li> <label class="select-box__option" for="10" aria-hidden="aria-hidden">고객만족팀</label> </li>
			                                <li> <label class="select-box__option" for="11" aria-hidden="aria-hidden">기술지원팀</label> </li>
			                                <li> <label class="select-box__option" for="12" aria-hidden="aria-hidden">전략기획팀</label>  </li>
			                                <li> <label class="select-box__option" for="13" aria-hidden="aria-hidden">연구기획팀</label> </li>
			                                <li> <label class="select-box__option" for="14" aria-hidden="aria-hidden">연구개발팀</label> </li>
			                                <li> <label class="select-box__option" for="15" aria-hidden="aria-hidden">생산관리팀</label>  </li>
			                                <li> <label class="select-box__option" for="16" aria-hidden="aria-hidden">시설관리팀</label> </li>
			                                <li> <label class="select-box__option" for="17" aria-hidden="aria-hidden">영업팀</label> </li>
			                                <li> <label class="select-box__option" for="18" aria-hidden="aria-hidden">영역기획팀</label>  </li>
			                                <li> <label class="select-box__option" for="19" aria-hidden="aria-hidden">영역지원팀</label> </li>
			                                <li> <label class="select-box__option" for="20" aria-hidden="aria-hidden">홍보팀</label> </li>
			                                <li> <label class="select-box__option" for="21" aria-hidden="aria-hidden">품질관리팀</label> </li>
			                            </ul>
			                        </div>
			                    </div>
			                </div>
			                <div class="input-div row3 left position">
			                    <div class="select-box">
			                        <div class="select-box__current" tabindex="1">
			                            <div class="select-box__value">
			                            <input class="select-box__input" type="radio" id="22" value="22" name="Ben_" checked="checked"/>
			                            <p class="select-box__input-text">인턴</p>
			                            </div>
			                            <div class="select-box__value">
			                            <input class="select-box__input" type="radio" id="23" value="23" name="Ben_" checked="checked"/>
			                            <p class="select-box__input-text">사원</p>
			                            </div>
			                            <div class="select-box__value">
			                            <input class="select-box__input" type="radio" id="24" value="24" name="Ben_" checked="checked"/>
			                            <p class="select-box__input-text">대리</p>
			                            </div>
			                            <div class="select-box__value">
			                            <input class="select-box__input" type="radio" id="25" value="25" name="Ben_" checked="checked"/>
			                            <p class="select-box__input-text">과장</p>
			                            </div>
			                            <div class="select-box__value">
			                            <input class="select-box__input" type="radio" id="26" value="26" name="Ben_" checked="checked"/>
			                            <p class="select-box__input-text">차장</p>
			                            </div>
			                            <div class="select-box__value">
			                            <input class="select-box__input" type="radio" id="27" value="27" name="Ben_" checked="checked"/>
			                            <p class="select-box__input-text">부장</p>
			                            </div>
			                            <div class="select-box__value">
			                            <input class="select-box__input" type="radio" id="28" value="28" name="Ben_" checked="checked"/>
			                            <p class="select-box__input-text">이사</p>
			                            </div>
			                            <div class="select-box__value">
			                            <input class="select-box__input" type="radio" id="29" value="29" name="Ben_" checked="checked"/>
			                            <p class="select-box__input-text">상무</p>
			                            </div>
			                            <div class="select-box__value">
			                            <input class="select-box__input" type="radio" id="30" value="30" name="Ben_" checked="checked"/>
			                            <p class="select-box__input-text">전무</p>
			                            </div>
			                            <div class="select-box__value">
			                            <input class="select-box__input" type="radio" id="31" value="31" name="Ben_" checked="checked"/>
			                            <p class="select-box__input-text">부사장</p>
			                            </div>
			                            <div class="select-box__value">
			                            <input class="select-box__input" type="radio" id="32" value="32" name="Ben_" checked="checked"/>
			                            <p class="select-box__input-text">사장</p>
			                            </div>
			                            <div class="select-box__value">
			                            <input class="select-box__input" type="radio" id="33" value="33" name="Ben_" checked="checked"/>
			                            <p class="select-box__input-text">부회장</p>
			                            </div>
			                            <div class="select-box__value">
			                            <input class="select-box__input" type="radio" id="34" value="34" name="Ben_" checked="checked"/>
			                            <p class="select-box__input-text">회장</p>
			                            </div>
			                            <div class="select-box__value">
			                            <input class="select-box__input" type="radio" id="none" value="none" name="Ben_" checked="checked"/>
			                            <p class="select-box__input-text">직위</p>
			                            </div><img class="select-box__icon" src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon" aria-hidden="true"/>
			                        </div>
			                        <ul class="select-box__list">
			                            <li> <label class="select-box__option" for="22" aria-hidden="aria-hidden">인턴</label> </li>
			                            <li> <label class="select-box__option" for="23" aria-hidden="aria-hidden">사원</label> </li>
			                            <li> <label class="select-box__option" for="24" aria-hidden="aria-hidden">대리</label> </li>
			                            <li> <label class="select-box__option" for="25" aria-hidden="aria-hidden">과장</label> </li>
			                            <li> <label class="select-box__option" for="26" aria-hidden="aria-hidden">차장</label> </li>
			                            <li> <label class="select-box__option" for="27" aria-hidden="aria-hidden">부장</label> </li>
			                            <li> <label class="select-box__option" for="28" aria-hidden="aria-hidden">이사</label> </li>
			                            <li> <label class="select-box__option" for="29" aria-hidden="aria-hidden">상무</label> </li>
			                            <li> <label class="select-box__option" for="30" aria-hidden="aria-hidden">전무</label> </li>
			                            <li> <label class="select-box__option" for="31" aria-hidden="aria-hidden">부사장</label> </li>
			                            <li> <label class="select-box__option" for="32" aria-hidden="aria-hidden">사장</label> </li>
			                            <li> <label class="select-box__option" for="33" aria-hidden="aria-hidden">부회장</label> </li>
			                            <li> <label class="select-box__option" for="34" aria-hidden="aria-hidden">회장</label> </li>
			                        </ul>
			                    </div>
			                    <div class="chkdiv">
			                        <label class="saveId-container float" for="one">팀장 여부
			                            <input type="checkbox" name="car" id="one">
			                        <span class="saveId-checkmark"></span>
			                     </div>
			                </div>
			                <div class="input-div row3 left authority">
			                    <div class="authorityBar">
			                        <div class="select-box">
			                            <div class="select-box__current" tabindex="1">
			                                <div class="select-box__value">
			                                <input class="select-box__input" type="radio" id="35" value="35" name="Ben__" checked="checked"/>
			                                <p class="select-box__input-text">일반사원</p>
			                                </div>
			                                <div class="select-box__value">
			                                <input class="select-box__input" type="radio" id="36" value="36" name="Ben__" checked="checked"/>
			                                <p class="select-box__input-text">인사관리자</p>
			                                </div>
			                                <div class="select-box__value">
			                                <input class="select-box__input" type="radio" id="37" value="37" name="Ben__" checked="checked"/>
			                                <p class="select-box__input-text">관리자</p>
			                                </div>
			                                <div class="select-box__value">
			                                <input class="select-box__input" type="radio" id="none" value="none" name="Ben__" checked="checked"/>
			                                <p class="select-box__input-text">권한설정</p>
			                                </div><img class="select-box__icon" src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon" aria-hidden="true"/>
			                            </div>
			                            <ul class="select-box__list">
			                                <li> <label class="select-box__option" for="35" aria-hidden="aria-hidden">일반사원</label> </li>
			                                <li> <label class="select-box__option" for="36" aria-hidden="aria-hidden">인사관리자</label> </li>
			                                <li> <label class="select-box__option" for="37" aria-hidden="aria-hidden">관리자</label> </li>
			                            </ul>
			                        </div>
			                    </div>
			                </form>
			                </div>
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