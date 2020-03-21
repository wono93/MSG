<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/boardWrite.css">
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/4c554cd518.js" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.16/dist/summernote.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.16/dist/summernote.min.js"></script> 
    <script>
        $(document).ready(function() {
            $('#summernote').summernote({
            height: 380,                 // set editor height
            minHeight: 380,             // set minimum height of editor
            maxHeight: 380,             // set maximum height of editor
            focus: true                  // set focus to editable area after initializing summernote
             });
        });
       
      </script>
    <title>boardWrite</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <section>
        <div>
            <article style="width: 1200; height: 100%;">
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
                        
                        <div class="boardBB">
                            <p class="com4">게시판</p>
                            <p class="com4">제 목</p>
                        </div>
                   

                    <div class="boardBC">
                    </div>
                        <div style="top: 20px;" id="first1" class="select-box1">
                           <!--<div id="boardBB">-->
                                
                            <div style="width: 403px;" class="select-box__current" tabindex="1">
                                <div class="select-box__value">
                                <input class="select-box__input" type="radio" id="3" value="1" name="Ben1" checked="checked"/>
                                <p class="select-box__input-text">건의사항</p>
                                </div>
                                <div class="select-box__value">
                                <input class="select-box__input" type="radio" id="4" value="2" name="Ben1" checked="checked"/>
                                <p class="select-box__input-text">자유 게시판</p>
                                </div>
                                <div class="select-box__value">
                                <input class="select-box__input" type="radio" id="5" value="3" name="Ben1" checked="checked"/>
                                <p class="select-box__input-text">공지사항 & 행사정보</p>
                            </div>
                                <img class="select-box__icon" src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon" aria-hidden="true"/>
                                <!-- <div class="select-box__value">
                                <input class="select-box__input" type="radio" id="3" value="4" name="Ben" checked="checked"/>
                                <p class="select-box__input-text">전체</p>
                                </div> -->
                            </div>
                       
                        
                            <ul class="select-box__list">
                                <li>
                                <label class="select-box__option" for="3" aria-hidden="aria-hidden">건의사항</label>
                                </li>
                                <li>
                                <label class="select-box__option" for="4" aria-hidden="aria-hidden">자유 게시판</label>
                                </li>
                                <li>
                                <label class="select-box__option" for="5" aria-hidden="aria-hidden">공지사항 & 행사정보</label>
                                </li>
                                <!-- <li>
                                <label class="select-box__option" for="2" aria-hidden="aria-hidden">문서종류</label>
                                </li> -->
                            </ul>
                        
                        <div id="boardTitle">
                            <input type="text" name="" id="srchWord">
                        </div>
                        
                    </div>
                    <div id="boardBD">
                        <p class="com3">작성자</p>
                        <p class="com3">사업부1팀</p>
                        <p class="com3">사원</p>
                        <p class="com3">장그래</p>
                        <p class="com3"></p>
                        <div class="box" style="background: #BDBDBD;">
                            <img class="profile" src="${pageContext.request.contextPath}/resources/image/worker.jpg">
                        </div>
                    </div>
                            
                          
                    
                </div>
                <div id="file">
                    <!-- <input type="file"/> -->
                    <p id="com5">
                        여기로 파일을 끌고 오거나 직접 선택 
                        
                        <button type="button" name="" id="grayBtn1" class="btn" style="bottom: 10px;">첨부파일</button>
                    </p>
                    <p id="com5">0 MB / 50MB</p>
                </div>
                <div id="api">
                    <form method="post" style="width: 914px; margin-left: 1px;">
                        <textarea id="summernote" name="editordata"></textarea>
                      </form>
                </div>
                <style>
                   
                </style>
                    <div class="srchBar">
                        <button type="button" name="" id="grayBtn" class="btn" onclick="location.href='${pageContext.request.contextPath}/board/list.do'"> 취  소 </button>
                        <button type="button" name="" id="yellowBtn" class="btn">글쓰기</button>
                    </div>
                </div>
            </article>
        </div>
    </section>

</body>
</html>