<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/boardListForm.css">
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/4c554cd518.js" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
    <!--
    <script>
        function acyncMovePage(url){
        // ajax option
        var ajaxOption = {
                url : url,
                async : true,
                type : "POST",
                dataType : "html",
                cache : false
        };
        
        $.ajax(ajaxOption).done(function(data){
            // Contents 영역 삭제
            $('#bodyContents').children().remove();
            // Contents 영역 교체
            $('#bodyContents').html(data);
        });
    }
    </script>-->
    <title>boardListForm</title>
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
                        <div id="first" class="select-box">
                            <div class="select-box__current" tabindex="1">
                                <div class="select-box__value">
                                    <input class="select-box__input" type="radio" id="3" value="1" name="Ben1" checked="checked"/>
                                    <p class="select-box__input-text">건의사항</p>
                                </div>
                                <div class="select-box__value">
                                    <input class="select-box__input" type="radio" id="4" value="2" name="Ben1" checked="checked"/>
                                    <p class="select-box__input-text">자유게시판</p>
                                </div>
                                <div class="select-box__value">
                                    <input class="select-box__input" type="radio" id="5" value="3" name="Ben1" checked="checked"/>
                                    <p class="select-box__input-text">공지&행사</p>
                                </div>
                                 <div class="select-box__value">
                                    <input class="select-box__input" type="radio" id="6" value="4" name="Ben1" checked="checked"/>
                                    <p class="select-box__input-text">전체 보기</p>
                                </div> 
                                <img class="select-box__icon" src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon" aria-hidden="true"/>
                            </div>
                            
                            <ul class="select-box__list">
                                <div id="1">
                                    <li>
                                        <label class="select-box__option" for="3" aria-hidden="aria-hidden">건의사항</label>
                                    </li>
                                </div>
                                <div id="2">
                                    <li>
                                        <label class="select-box__option" for="4" aria-hidden="aria-hidden">자유게시판</label>
                                    </li>
                                </div>
                                <div id="3">
                                    <li>
                                        <label class="select-box__option" for="5" aria-hidden="aria-hidden">공지&행사</label>
                                    </li>
                                </div>
                                <div id="4">
                                    <li>
                                        <label class="select-box__option" for="6" aria-hidden="aria-hidden">전체보기</label>
                                    </li>
                                </div>
                            </ul>
                        </div>


                        <div class="select-box">
                            <div class="select-box__current" tabindex="1">
                                <div class="select-box__value">
                                    <input class="select-box__input" type="radio" id="0" value="1" name="Ben" checked="checked"/>
                                    <p class="select-box__input-text">모두 보기</p>
                                </div>
                                <div class="select-box__value">
                                    <input class="select-box__input" type="radio" id="1" value="2" name="Ben" checked="checked"/>
                                    <p class="select-box__input-text">내가 쓴 글</p>
                                </div>
                                <div class="select-box__value">
                                    <input class="select-box__input" type="radio" id="2" value="3" name="Ben" checked="checked"/>
                                    <p class="select-box__input-text">스크랩 글</p>
                                </div>
                                <!-- <div class="select-box__value">
                                <input class="select-box__input" type="radio" id="3" value="4" name="Ben" checked="checked"/>
                                <p class="select-box__input-text">전체</p>
                                </div> -->
                                <img class="select-box__icon" src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon" aria-hidden="true"/>
                            </div>
                            <ul class="select-box__list">
                                <li>
                                    <label class="select-box__option" for="0" aria-hidden="aria-hidden">모두 보기</label>
                                </li>
                                <li>
                                    <label class="select-box__option" for="1" aria-hidden="aria-hidden">내가 쓴 글</label>
                                </li>
                                <li>
                                    <label class="select-box__option" for="2" aria-hidden="aria-hidden">스크랩 글</label>
                                </li>
                                <!-- <li>
                                <label class="select-box__option" for="2" aria-hidden="aria-hidden">문서종류</label>
                                </li> -->
                            </ul>
                        </div>

                        <button type="button" name="" id="boardBtn" class="yellowBtn"  onclick="location.href='${pageContext.request.contextPath}/board/write.do'"><i class="far fa-edit"></i> 글쓰기</button>

                        
                    </div>
                <div id="44">
                    <table>
                        <tr >
                            <th></th>
                            <th>글쓴이</th>
                            <th>카테고리</th>
                            <th>제목</th>
                            <th>첨부파일</th>
                            <th>작성일</th>
                            <th>조회수
                            </th>
                        </tr>
                        <tr style="color: rgb(93, 93, 253);" onclick="location.href='${pageContext.request.contextPath}/board/view.do'">
                            <td onclick="location.href='${pageContext.request.contextPath}/board/view.do'">110</td>
                            <td onclick="location.href='${pageContext.request.contextPath}/board/view.do'">장그래</td>
                            <td onclick="location.href='${pageContext.request.contextPath}/board/view.do'">자유</td>
                            <td onclick="location.href='${pageContext.request.contextPath}/board/view.do'">
                                실현에 청춘의 대중을 설레는 얼마나 하(4)
                                <img style=" height: 20px; width: 20px;" src="${pageContext.request.contextPath}/resources/image/newIcon.jpeg" />
                            </td>
                            <td></td>
                            <td>2020/02/29</td>
                            <td>1
                            </td>
                        </tr>
                        <tr>
                            <td>109</td>
                            
                            <td>천광웅</td>
                            <td>건의</td>
                            <td>피고 대한 무한한 바이며, 사막이다.(5)</td>
                            <td></td>
                            <td>2020/02/29</td>
                            <td>51</td>
                        </tr>
                        <tr>
                            <td>108</td>
                            
                            <td>장그래</td>
                            <td>건의</td>
                            <td>안녕하세용가나다라마바사(1)</td>
                            <td></td>
                            <td>2020/02/29</td>
                            <td>41</td>
                        </tr>
                        <tr>
                            <td>107</td>
                            
                            <td>천광웅</td>
                            <td>건의</td>
                            <td>무서운이야기가나다라마바사</td>
                            <td></td>
                            <td>2020/02/29</td>
                            <td>23</td>
                        </tr>
                        <tr>
                            <td>106</td>
                            
                            <td>장그래</td>
                            <td>공지&행사</td>
                            <td>재밌는얘기가나다라마바사</td>
                            <td></td>
                            <td>2020/02/29</td>
                            <td>22</td>
                        </tr>
                        <tr>
                            <td>105</td>
                           
                            <td>천광웅</td>
                            <td>자유</td>
                            <td>퇴근하겠습니다가나다라마바사</td>
                            <td></td>
                            <td>2020/02/29</td>
                            <td>22</td>
                        </tr>
                        <tr style="color: #a5a3a3;">
                            <td>104</td>
                            
                            <td>장그래</td>
                            <td>자유</td>
                            <td>점심뭐먹지</td>
                            <td></td>
                            <td>2020/02/29</td>
                            <td>15</td>
                        </tr>
                        <tr style="color: #a5a3a3;">
                            <td>103</td>
                           
                            <td>천광웅</td>
                            <td>공지&행사</td>
                            <td>무엇을 원질이 원대하고, 이상 피가 구할 뿐이다.</td>
                            <td></td>
                            <td>2020/02/29</td>
                            <td>32</td>
                        </tr>
                        <tr style="color: #a5a3a3;">
                            <td>102</td>
                            
                            <td>장그래</td>
                            <td>공지&행사</td>
                            <td>동산에는 인간의 꽃 용감하고 노래하며 듣는다.</td>
                            <td></td>
                            <td>2020/02/29</td>
                            <td>32</td>
                        </tr>
                        <tr style="color: #a5a3a3;">
                            <td>101</td>
                           
                            <td>천광웅</td>
                            <td>공지&행사</td>
                            <td>인간의 갑 인간에 밝은 보이는 몸이 때문이다.</td>
                            <td></td>
                            <td>2020/02/29</td>
                            <td>15</td>
                        </tr>
                        <tr style="color: #a5a3a3;">
                            <td>100</td>
                            
                            <td>장그래</td>
                            <td>자유</td>
                            <td> 자신과 있으랴? 가지에 그들에게 풀이 불어 뭇 </td>
                            <td></td>
                            <td>2020/02/29</td>
                            <td>44</td>
                        </tr>
                        <tr style="color: #a5a3a3;">
                            <td>99</td>
                            
                            <td>천광웅</td>
                            <td>건의</td>
                            <td>같이 사는가 과실이 피는 내려온 피어나는 </td>
                            <td></td>
                            <td>2020/02/29</td>
                            <td>11</td>
                        </tr>
                        <tr style="color: #a5a3a3;">
                            <td>98</td>
                            
                            <td>장그래</td>
                            <td>건의</td>
                            <td>위하여 군영과 수 있을 동력은 몸이 황금시대의 보내는 있는가?</td>
                            <td></td>
                            <td>2020/02/29</td>
                            <td>12</td>
                        </tr>
                        <tr style="color: #a5a3a3;">
                            <td>97</td>
                            <td>천광웅</td>
                            <td>자유</td>
                            <td>간에 아니한 위하여서. 가슴이 작고 피가</td>
                            <td></td>
                            <td>2020/02/29</td>
                            <td>55</td>
                        </tr>
                        <tr style="color: #a5a3a3;">
                            <td>96</td>
                            
                            <td>장그래</td>
                            <td>건의</td>
                            <td>관현악이며, 그러므로 어디 대중을 싸인 </td>
                            <td></td>
                            <td>2020/02/29</td>
                            <td>5</td>
                        </tr>
                              
                    </table>
                </div>
                    <div class="pagination">
                        <a href="#" class="arrow">&laquo;</a>
                        <a href="#">1</a>
                        <a href="#" class="active">2</a>
                        <a href="#">3</a>
                        <a href="#">4</a>
                        <a href="#">5</a>
                        <a href="#" class="arrow">&raquo;</a>
                    </div>
                    <div class="srchBar">
                        
                        <input type="text" name="" id="srchWord">
                        <button type="button" name="" id="srchBtn" class="yellowBtn"><i class="fas fa-search" style="font-size:15px"></i> 검색</button>
                    </div>
                </div>
            </article>
        </div>
    </section>

</body>
</html>