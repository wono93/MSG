<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/M_DirectMessage.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/M_ChannelGenerate.css">
    <script src="https://kit.fontawesome.com/4c554cd518.js" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
    <script>
		var hdjq = jQuery.noConflict();
    </script>
    <script src="${pageContext.request.contextPath }/resources/js/header.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/M_ChannelGenerate.js"></script>
</head>
<body>
    <input id="hamburger" class="hamburger" type="checkbox" />
    <label for="hamburger" class="hamburger">
        <i></i>
<%-- 	<text>
        <close>close</close>
        <open>menu</open>
	</text> --%>
    </label>


    <nav class="primnav">
        <div class="userinfo">
            <user id="user">
                <img src="https://randomuser.me/api/portraits/women/85.jpg" />
                <idSection>
                    <idSection>
                        <name>누구지</name>
                        <actions><a href="#">사업부</a> | <a href="#">과장</a></actions>
                    </idSection>
                </idSection>
            </user>
        </div>
        <br>
        <ul class="firnav">
            <li>
                <a href="${pageContext.request.contextPath}/member/list.do">
                    <i class="icon far fa-id-card" style="font-size:24px"></i> 인사관리
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/edoc/srch.do">
                    <i class="icon far fa-folder" style="font-size:24px"></i> 전자문서
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/board/list.do">
                    <i class="icon far fa-comments" style="font-size:24px"></i> 커뮤니케이션
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/res/cal.do">
                    <i class="icon far fa-calendar-alt" style="font-size:24px"></i> 일정관리
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/res/carRes.do">
                    <i class="icon far fa-check-square" style="font-size:24px"></i> 예약관리
                </a>
            </li>
            <li>
                <a href="#">
                    <i class="icon fas fa-shopping-basket" style="font-size:24px"></i> 오피스디포
                </a>
            </li>
            <ul class="secnav">
                <p>Channel<img src="${pageContext.request.contextPath}/resources/image/plus.png" id="plus-icon" alt=""></p>
                <li>
                    <a href="#">
                        <i class="fas fa-circle" style="font-size:15px"></i>　경영지원 1팀
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="fas fa-circle" style="font-size:15px"></i>　미식가들
                    </a>
                </li>
            </ul>
            <ul class="secnav">
                <p>Direct Message</p>
                <li>
                    <a href="#" id="dmWindow">
                        <img src="https://randomuser.me/api/portraits/women/85.jpg">　누구지 부장
                    </a>
                </li>
                <li>
                    <a href="#">
                        <img src="https://randomuser.me/api/portraits/women/85.jpg">　누구지 대리
                    </a>
                </li>
                <li>
                    <a href="#">
                        <img src="https://randomuser.me/api/portraits/women/85.jpg">　누구지 사원
                    </a>
                </li>
            </ul>
        </ul>
    </nav>

    <side class="dmBar">
        <div id="title-container">
                <img src="${pageContext.request.contextPath}/resources/image/X-icon.png" alt="" id="dmClose">
                <div id="name-span">최원호 대리</div>
        </div>
            <div id="dm-container">
            <div id="hr-container">
                <hr class="dmHr" id="hr-left" align="left">
                <span id="span-date">
                    2020년 00월 00일 월요일
                </span>
                <hr class="dmHr" id="hr-right" align="right">
            </div>
            
            <div id="from-dm">
                <img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="from-dm-img" class="member-img">
                <div id="from-dm-content" class="dm-content">안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요</div>
                <span id="from-dm-time" class="dm-time">12:00 AM</span>
            </div>
            
            <div id="hr-container">
                <hr class="dmHr" id="hr-left" align="left">
                <span id="span-date">
                    2020년 00월 00일 월요일
                </span>
                <hr class="dmHr" id="hr-right" align="right">
            </div>

            <div id="to-dm">
                <img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="to-dm-img" class="member-img">
                <div id="to-dm-content" class="dm-content">안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요</div>
                <div id="to-dm-time" class="dm-time">12:00 AM</div>
            </div>
            
            <div id="hr-container">
                <hr class="dmHr" id="hr-left" align="left">
                <span id="span-date">
                    2020년 00월 00일 월요일
                </span>
                <hr class="dmHr" id="hr-right" align="right">
            </div>
            
            <div id="from-dm">
                <img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="from-dm-img" class="member-img">
                <div id="from-dm-content" class="dm-content">안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요</div>
                <div id="from-dm-time" class="dm-time">12:00 AM</div>
            </div>
            
            <div id="hr-container">
                <hr class="dmHr" id="hr-left" align="left">
                <span id="span-date">
                    2020년 00월 00일 월요일
                </span>
                <hr class="dmHr" id="hr-right" align="right">
            </div>

            <div id="to-dm">
                <img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="to-dm-img" class="member-img">
                <div id="to-dm-content" class="dm-content">안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요</div>
                <div id="to-dm-time" class="dm-time">12:00 AM</div>
            </div>
            
            <div id="hr-container">
                <hr class="dmHr" id="hr-left" align="left">
                <span id="span-date">
                    2020년 00월 00일 월요일
                </span>
                <hr class="dmHr" id="hr-right" align="right">
            </div>
            
            <div id="from-dm">
                <img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="from-dm-img" class="member-img">
                <div id="from-dm-content" class="dm-content">안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요</div>
                <div id="from-dm-time" class="dm-time">12:00 AM</div>
            </div>
            
            <div id="hr-container">
                <hr class="dmHr" id="hr-left" align="left">
                <span id="span-date">
                    2020년 00월 00일 월요일
                </span>
                <hr class="dmHr" id="hr-right" align="right">
            </div>

            <div id="to-dm">
                <img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="to-dm-img" class="member-img">
                <div id="to-dm-content" class="dm-content">안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요</div>
                <div id="to-dm-time" class="dm-time">12:00 AM</div>
            </div>
            
            <div id="hr-container">
                <hr class="dmHr" id="hr-left" align="left">
                <span id="span-date">
                    2020년 00월 00일 월요일
                </span>
                <hr class="dmHr" id="hr-right" align="right">
            </div>
            
            <div id="from-dm">
                <img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="from-dm-img" class="member-img">
                <div id="from-dm-content" class="dm-content">안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요</div>
                <div id="from-dm-time" class="dm-time">12:00 AM</div>
            </div>
            
            <div id="hr-container">
                <hr class="dmHr" id="hr-left" align="left">
                <span id="span-date">
                    2020년 00월 00일 월요일
                </span>
                <hr class="dmHr" id="hr-right" align="right">
            </div>

            <div id="to-dm">
                <img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="to-dm-img" class="member-img">
                <div id="to-dm-content" class="dm-content">안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요</div>
                <div id="to-dm-time" class="dm-time">12:00 AM</div>
            </div>
            
        </div>
        
        <div id="send-dm-container">
            <textarea name="" id="send-dm-content" cols="62" rows="7"></textarea>
            <button id="send-dm-button" class="dmButton">전송</button>
        </div>
    </side>    

	        <div id="channelGenModal" class="ch-modal">
            <!-- Modal content -->
            <div class="ch-modal-content">
                
                <img src="${pageContext.request.contextPath}/resources/image/X-icon.png" alt="" class="x-icon close" id="close-btn">
                <div id="ch-content">
                    <form action="">

                        <div class="channelGenTitle">
                            <h3>채널만들기</h3>
                            <img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="" class="ch-member-img">
                            <img src="${pageContext.request.contextPath}/resources/image/king.svg" id="king" class="">
                        </div>

                        <input type="text" name="" id="ch-input-title" placeholder="채널명을 입력해주세요.">

                        <div id="ch-member-list">
                            <table id="ch-member-table">
                                <tr>
                                    <td><img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="ch-member-list-img" class="ch-member-img"></td>
                                    <td>가디01</td>
                                    <td>해외영업부</td>
                                    <td>과장</td>
                                    <td>20122222</td>
                                    <td><img src="${pageContext.request.contextPath}/resources/image/X-icon.png" alt="" class="x-icon" id=""></td>
                                </tr>
                                <tr>
                                    <td><img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="ch-member-list-img" class="ch-member-img"></td>
                                    <td>가디01</td>
                                    <td>해외영업부</td>
                                    <td>과장</td>
                                    <td>20122222</td>
                                    <td><img src="${pageContext.request.contextPath}/resources/image/X-icon.png" alt="" class="x-icon" id=""></td>
                                </tr>
                                <tr>
                                    <td><img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="ch-member-list-img" class="ch-member-img"></td>
                                    <td>가디01</td>
                                    <td>해외영업부</td>
                                    <td>과장</td>
                                    <td>20122222</td>
                                    <td><img src="${pageContext.request.contextPath}/resources/image/X-icon.png" alt="" class="x-icon" id=""></td>
                                </tr>
                                <tr>
                                    <td><img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="ch-member-list-img" class="ch-member-img"></td>
                                    <td>가디01</td>
                                    <td>해외영업부</td>
                                    <td>과장</td>
                                    <td>20122222</td>
                                    <td><img src="${pageContext.request.contextPath}/resources/image/X-icon.png" alt="" class="x-icon" id=""></td>
                                </tr>
                            </table>
                        </div>


                        <div class="srchChBar">
                            <div class="select-box">
                                <div class="select-box__current" tabindex="1">
                                    <div class="select-box__value">
                                        <input class="select-box__input" type="radio" id="0" value="1" name="Ben" />
                                        <p class="select-box__input-text">부서</p>
                                    </div>
                                    <div class="select-box__value">
                                        <input class="select-box__input" type="radio" id="1" value="2" name="Ben" />
                                        <p class="select-box__input-text">사번</p>
                                    </div>
                                    <div class="select-box__value">
                                        <input class="select-box__input" type="radio" id="2" value="3" name="Ben" />
                                        <p class="select-box__input-text">이름</p>
                                    </div>
                                    <div class="select-box__value">
                                        <input class="select-box__input" type="radio" id="3" value="4" name="Ben"
                                            checked="checked" />
                                        <p class="select-box__input-text">전체</p>
                                    </div><img class="select-box__icon"
                                        src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon"
                                        aria-hidden="true" />
                                </div>
                                <ul class="select-box__list">
                                    <li>
                                        <label class="select-box__option" for="3" aria-hidden="aria-hidden">전체</label>
                                    </li>
                                    <li>
                                        <label class="select-box__option" for="0" aria-hidden="aria-hidden">부서</label>
                                    </li>
                                    <li>
                                        <label class="select-box__option" for="1" aria-hidden="aria-hidden">사번</label>
                                    </li>
                                    <li>
                                        <label class="select-box__option" for="2" aria-hidden="aria-hidden">이름</label>
                                    </li>
                                </ul>
                            </div>
                            <input type="text" name="" id="srchChWord">
                            <img src="${pageContext.request.contextPath}/resources/image/search-icon.png" alt="" id="ch-search-icon">
                            <div class="chDivBtn">
                                <button type="button" class="ch-button">확인</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
</body>
</html>