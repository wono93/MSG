<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <link rel="stylesheet" href="css/header.css">
     <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/main.css">
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/4c554cd518.js" crossorigin="anonymous"></script>
    <script src="jquery-3.4.1.js"></script>
    <script src="main.js"></script>
</head>
<style>
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
</style>
<script>
</script>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<section>
        <div>
            <article>
                <div style="margin-left: 15px;" class="subNav">
                    <div style="margin-top: 55px;">
                        <button type="button" name="" id="boardBtn" class="yellowBtn">접속자 확인</button>
                        <button type="button" name="" id="boardBtn" class="yellowBtn">팀 채널 가기</button>
                    </div>
                    <div style="bottom: 60px; position: relative; text-align: right;">
                        <img style="right: 0px; width: 180px; height: 75px; " src="${pageContext.request.contextPath }/resources/image/msgMain.png"/>
                    </div>
                </div>
                <div style="width: 500px;;" class="content1">
                    <div style="width:500px; margin-bottom: 50px; margin-top: 30px;" id="notice">
                        <p style="text-align: left; margin-left: 25px;"><i style="color:yellow;" class="fas fa-circle"></i > 공지사항</p>
                        <table>
                            <tr>
                                <th>글쓴이</th>
                                <th>작성일</th>
                                <th>제목</th>
                                
                            </tr>
                            <c:forEach items="${boardList }" var="bl">
	                            <tr>
	                                <td>${bl.empNo }</td>
	                                <td>${bl.bdate }</td>
	                                <td>${bl.title }</td>
	                            </tr>
                            </c:forEach>
                        </table>
                    </div>
                    <div id="55">
                        <p style="text-align: left; margin-left: 25px;"><i style="color:yellow;" class="fas fa-circle"></i > 전자문서</p>
                        <table>
                            <tr>
                                <th>기안자</th>
                                <th>문서종류</th>
                                <th>제목</th>
                            </tr>
                            <tr>
                                <td>장그래</td>
                                <td>자유</td>
                                <td >
                                    실현에 청춘의 대중을 설레는 얼마나 하(4)
                                </td>
                            </tr>
                            <tr>
                                <td>천광웅</td>
                                <td>건의</td>
                                <td>피고 대한 무한한 바이며, 사막이다.(5)</td>
                            </tr>
                            <tr>
                                <td>장그래</td>
                                <td>건의</td>
                                <td>안녕하세용가나다라마바사(1)</td>
                            </tr>
                            <tr>
                                <td>천광웅</td>
                                <td>건의</td>
                                <td>무서운이야기가나다라마바사</td>
                            </tr>
                            <tr>
                                <td>장그래</td>
                                <td>공지&행사</td>
                                <td>재밌는얘기가나다라마바사</td>
                            </tr>
                            <tr>
                                <td>장그래</td>
                                <td>자유</td>
                                <td>퇴근하겠습니다가나다라마바사</td>
                            </tr>     
                        </table>
                    </div>
                </div>
                <div style="width: 500px;" id="content2">
                    <div style="width:500px; margin-bottom: 34px; margin-top: 30px;" id="notice">
                        <div id="calender" style="width:400px; height: 350px; margin-left: 50px; border: 1px solid black;">
                            <p> 달력소스 오픈소스</p>
                        </div>
                    </div>
                    <div id="66">
                        <p style="text-align: left; margin-left: 25px;"><i style="color:yellow;" class="fas fa-circle"></i > 이번 주 일정</p>
                        <table style="text-align: left;">
                            <tr>
                                <td>13 월</td>
                            </tr>
                            <tr>
                                <td>14 화</td>
                            </tr>
                            <tr>
                                <td>15 수</td>
                            </tr>
                            <tr>
                                <td>16 목</td>
                            </tr>
                            <tr>
                                <td>17 금</td>
                            </tr>
                            <tr>
                                <td>18 토</td>
                            </tr>
                            <tr>
                                <td>19 일</td>
                            </tr>

                        </table>
                    </div>
                </div>
            </article>
        </div>
    </section>

</body>
</html>
