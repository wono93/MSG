<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>
<style>
    section{
/*         position: relative;
        width: 1000px;
        padding: 50px 100px;
        background-color: #EBEBEB; */
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
	article > .subNav {
	    display: inline-block;
	    width: 1020px;
	    height: 230px;
	    vertical-align: middle;
/* 	    border: 1px solid red; */
	}
	.content > .control {
	    display: inline-block;
	    width: 1020px;
	    border-bottom: 2px solid #999999;
 	    padding-bottom: 20px;
    	text-align : left;
	}
    .control > p{
	    text-align: left;
    	padding-left : 61px;
    }
    .control > .btnGrp, #member-container {
    	display: inline-block;
    	padding-left : 61px;
   	}
    
    
    /* subNav */
	.subNav::after{
		content:"";
		display:block;
		clear:both;
	}
	.subNav > h3{
		margin:75px 0 0 0px;
		font-size:36px;
		font-weight:900;
		text-align: left;
	}
	.subNav li{
		list-style: none;
		float: left;
		margin: 45px 45px 30px 0px;
		font-size: 21px;
		font-family: "Noto Sans KR";
		color:#999;
		cursor: pointer;
	}
    
    #title{
        margin: 15px 0;
        font-weight: 800;
        font-size: 24px;
    }
    .button{
        font-size: 14px;
        padding: 13px 20px;
        background: #999999;
        margin-right: 5px;
    }
    .button:hover{
        background: #F4CA25;

    }
    #channel-container{
        width: 840px;
        padding: 65px 80px;
        background-color: #FEFEFE;
        margin: 10px 0;
        height: 600px;
        overflow-y: scroll;
    }
    /* member img */
    .member-img{
        width: 50px; 
        height: 50px;
        object-position: top;
        object-fit: cover;
        border-radius: 50%;
        float: inherit;
    }
    #member-container{
        float: right;
    }
    /* hr date */
    #hr-container{
        text-align: center;
        color: #999999;
        font-size: 15px;
    }
    hr{
        width: 313px;
        display: inline-block;
    }
    #span-date{
        position: relative;
        left: 10px
    }
    #hr-right{
        position: relative;
        float: right;
    }
    /* msg */
    .msg-content{
        padding: 15px;
        max-width: calc(100% - 500px);
        max-height: calc(100% - 70px);
	    overflow-y: scroll;
        margin: 0 10px;
        float: inherit;
    }
    .msg-time{
        color: #999999;
        width: 70px;
        float: inherit;
    }
    /* to msg */
    #to-msg{
        float: right;
        margin: 20px;
    }
    #to-msg-content{
        background: #F4CA25;
    }
    /* from msg */
    #from-msg{
        float: left;
        margin: 20px;
    }
    #from-msg-content{
        background-color: #EBEBEB;
    }
    /* send msg */
    #send-msg-container{
        background-color: #FEFEFE;
        width: 1000px;
        height: 150px;
    }
    #send-msg-container textarea{
		background-color: #EBEBEB;
    }
    #send-msg-button{
        float: right;
        margin: 26px 37px 0 0;
    }
    #send-msg-content{
        margin: 14px 0px 0px 77px;
        border: none;
        resize: none;
    }
</style>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <section>
        <div>
            <article>
                <div class="subNav">
                    <h3>커뮤니케이션</h3>
                    <ul>
                        <li onclick="#">이메일</li>
                        <li onclick="location.href='${pageContext.request.contextPath}/chat/channel.do'">팀채널</li>
                        <li onclick="location.href='${pageContext.request.contextPath}/board/list.do'">사내게시판</li>
                     </ul>
                </div>
				<div class="content">
					<div class="control">
				        <div id="member-container">
				            <a href=""><img src="${pageContext.request.contextPath}/resources/image/img.jpg" class="member-img"></a>
				            <a href=""><img src="${pageContext.request.contextPath}/resources/image/img.jpg" class="member-img"></a>
				            <a href=""><img src="${pageContext.request.contextPath}/resources/image/img.jpg" class="member-img"></a>
				            <a href=""><img src="${pageContext.request.contextPath}/resources/image/img.jpg" class="member-img"></a>
				            <a href=""><img src="${pageContext.request.contextPath}/resources/image/img.jpg" class="member-img"></a>
				        </div>
				        <p id="title">경영지원 1팀</p>
				        <div class="btnGrp">
					        <button id="video" class="button">화상회의</button>
					        <button id="addmember" class="button">구성원 추가/삭제</button>
				        </div>
					</div>
				    <div id="channel-container">
			            <div id="hr-container">
			                <hr id="hr-left" align="left">
			                <span id="span-date">
			                    2020년 00월 00일 월요일
			                </span>
			                <hr id="hr-right" align="right">
			            </div>
			            
			            <div id="from-msg">
			                <img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="from-msg-img" class="member-img">
			                <div id="from-msg-content" class="msg-content">안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요</div>
			                <span id="from-msg-time" class="msg-time">12:00 AM</span>
			            </div>
			            
			            <div id="hr-container">
			                <hr id="hr-left" align="left">
			                <span id="span-date">
			                    2020년 00월 00일 월요일
			                </span>
			                <hr id="hr-right" align="right">
			            </div>
			
			            <div id="to-msg">
			                <img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="to-msg-img" class="member-img">
			                <div id="to-msg-content" class="msg-content">안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요</div>
			                <div id="to-msg-time" class="msg-time">12:00 AM</div>
			            </div>
			            
			            <div id="hr-container">
			                <hr id="hr-left" align="left">
			                <span id="span-date">
			                    2020년 00월 00일 월요일
			                </span>
			                <hr id="hr-right" align="right">
			            </div>
			            
			            <div id="from-msg">
			                <img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="from-msg-img" class="member-img">
			                <div id="from-msg-content" class="msg-content">안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요</div>
			                <div id="from-msg-time" class="msg-time">12:00 AM</div>
			            </div>
			            
			            <div id="hr-container">
			                <hr id="hr-left" align="left">
			                <span id="span-date">
			                    2020년 00월 00일 월요일
			                </span>
			                <hr id="hr-right" align="right">
			            </div>
			
			            <div id="to-msg">
			                <img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="to-msg-img" class="member-img">
			                <div id="to-msg-content" class="msg-content">안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요</div>
			                <div id="to-msg-time" class="msg-time">12:00 AM</div>
			            </div>
			            
			            <div id="hr-container">
			                <hr id="hr-left" align="left">
			                <span id="span-date">
			                    2020년 00월 00일 월요일
			                </span>
			                <hr id="hr-right" align="right">
			            </div>
			            
			            <div id="from-msg">
			                <img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="from-msg-img" class="member-img">
			                <div id="from-msg-content" class="msg-content">안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요</div>
			                <div id="from-msg-time" class="msg-time">12:00 AM</div>
			            </div>
			            
			            <div id="hr-container">
			                <hr id="hr-left" align="left">
			                <span id="span-date">
			                    2020년 00월 00일 월요일
			                </span>
			                <hr id="hr-right" align="right">
			            </div>
			
			            <div id="to-msg">
			                <img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="to-msg-img" class="member-img">
			                <div id="to-msg-content" class="msg-content">안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요</div>
			                <div id="to-msg-time" class="msg-time">12:00 AM</div>
			            </div>
			            
			            <div id="hr-container">
			                <hr id="hr-left" align="left">
			                <span id="span-date">
			                    2020년 00월 00일 월요일
			                </span>
			                <hr id="hr-right" align="right">
			            </div>
			            
			            <div id="from-msg">
			                <img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="from-msg-img" class="member-img">
			                <div id="from-msg-content" class="msg-content">안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요</div>
			                <div id="from-msg-time" class="msg-time">12:00 AM</div>
			            </div>
			            
			            <div id="hr-container">
			                <hr id="hr-left" align="left">
			                <span id="span-date">
			                    2020년 00월 00일 월요일
			                </span>
			                <hr id="hr-right" align="right">
			            </div>
			
			            <div id="to-msg">
			                <img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="to-msg-img" class="member-img">
			                <div id="to-msg-content" class="msg-content">안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요</div>
			                <div id="to-msg-time" class="msg-time">12:00 AM</div>
			            </div>
			            
		        	</div>
		        
		        <div id="send-msg-container">
		            <textarea name="" id="send-msg-content" cols="130" rows="5"></textarea>
		            <button id="send-msg-button" class="button">전송</button>
		        </div>
			</article>
		</div>
    </section>    
</body>
</html>