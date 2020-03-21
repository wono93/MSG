<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/boardView.css">
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/4c554cd518.js" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
    <script>
         $(function(){
                $('#star').on('click',function(){
                    $("#star").html("<i id='star1' class='fas fa-star'></i>");
                })
                
            });
    </script>
    <title>boardView</title>
</head>
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
                        <div class="box" style="background: #BDBDBD;">
                            <img class="profile" src="${pageContext.request.contextPath}/resources/image/worker.jpg">
                        </div>
                        <div id="comLeft">
                            <div id="title">
                                <p>
                                    하하하하하하안녕하세요
                                </p>
                            </div>

                            <!--스크립트 별변경-->
                            <div id="star">
                                <i id='star1' class='far fa-star'></i>
                            </div>

                            <div id="member">
                                <p class="com3">사업부</p>
                                <p class="com3">1팀</p>
                                <p class="com3">과장</p>
                                <p class="com3">장그래</p>
                               
                            </div>
                            
                        </div>
                        <div id="comRight">
                            <div id="category">
                                <p> 자유게시판</p>
                            </div>
                            <div id="date">
                                <i class="fas fa-eye" id="eye">
                                </i>
                                <p class="com3" style="font-size: 22px; padding-right: 8px;">15</p>
                                <p class="com3">2020-03-01   17:53</p>
                            </div>
                        </div>
                    </div>
                <div id="boardContentH">
                    <div id="boardContent">
                        <p class="com4">
                            관현악이며, 그러므로 어디 대중을 싸인 그것을 같이, 간에 아니한 위하여서. 가슴이 작고 피가
                             가지에 우리 불어 힘있다. 
                             <br>
                             위하여 군영과 수 있을 동력은 몸이 황금시대의 보내는 있는가? 같이 사는가 과실이 피는 내려온 피어나는 거친 트고,
                              자신과 있으랴? 가지에 그들에게 풀이 불어 뭇 인간의 교향악이다. 인간의 갑 인간에 밝은 보이는 몸이 때문이다.
                               동산에는 인간의 꽃 용감하고 노래하며 듣는다. 있으며, 뜨거운지라,
                               <br>
                              실현에 청춘의 대중을 설레는 얼마나 하는 끓는 것이다. 피고 대한 무한한 바이며, 사막이다.
                              무엇을 원질이 원대하고, 이상 피가 구할 뿐이다.
                        </p>
                        <img style="float: left; cursor: pointer;" src="${pageContext.request.contextPath}/resources/image/fileDownload.PNG"/>
                    </div>
                    <div>
                        <div style="margin-top:35px; width: 100%; height: 100%; z-index: 100; position: relative; 
                            display: inline-block;">
                            <button type="button" name="" id="grayBtn1" class="btn">수정</button>
                            <button type="button" name="" id="grayBtn1" class="btn">삭제</button> 
                        </div>
                    </div>
                    <div style="height: 100%;" id="commentContent">
                        <div id="commentCnt">
                            <p class="com5">2 개의 댓글</p>
                            <br>
                        </div>
                        <div id="commentUser">
                            <table>
                                <tr>
                                    <td style="padding-left: 0px; padding-right: 0px; width: 50px;">
                                        <div class="box1" style="background: #BDBDBD;">
                                        <img class="profile" src="${pageContext.request.contextPath}/resources/image/worker.jpg">
                                        </div>
                                    </td>
                                    <td style="padding: 0; width: 166px;">기술지원부 3팀 김그래</td>
                                    <td style="font-size: 22px; padding-left: 20px;">asdasdasd</td>
                                    <td style="padding: 0; width: 166px; color: gray;">
                                        03 - 16 14 : 50
                                        <br>
                                        <button type="button" name="" id="grayBtn3" class="btn">삭제</button>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div id="commentUser">
                            <table>
                                <tr>
                                    <td>
                                        <div class="box1" style="background: #BDBDBD;">
                                            <img class="profile" src="${pageContext.request.contextPath}/resources/image/worker.jpg">
                                        </div>
                                    </td>
                                    <td style="padding: 0; width: 166px;">기술지원부 3팀 김그래</td>
                                    <td style="font-size: 22px; padding-left: 20px;">non optio, similique delectus explicabo!</td>
                                    <td style="top: 2px; padding: 0; width: 166px; color: gray;">
                                        03 - 16 14 : 50
                                        <br>
                                        <button type="button" name="" id="grayBtn3" class="btn">삭제</button>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div id="commentUser">
                            <table>
                                <tr>
                                    <td style="width: 720px;">
                                        <textarea type="textarea" id="inputWrd"></textarea>
                                    </td>
                                    <td>
                                        <button style="margin-bottom: 12px; bottom: 10px;
                                        right: 22px;" type="button" name="" id="grayBtn2" class="yellowBtn">
                                            댓글등록
                                        </button>                               
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                </div>
            </div>
            </article>
        </div>
    </section>

</body>
</html>