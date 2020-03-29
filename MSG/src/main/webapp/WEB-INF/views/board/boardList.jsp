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
    
    <script>
    
    $(()=>{
    	$("tr[data-board-no]").on("click", function(e){
    		console.log(this, e.target);//tr, td
    		let boardNo = $(this).attr("data-board-no"); 
    		console.log(boardNo);
    		
    		location.href = "${pageContext.request.contextPath}/board/view.do?boardNo="+boardNo;
    	});
    });
   /* 
    function selChange() {
		var sel = document.getElementById('cntPerPage').value;
		location.href="${pageContext.request.contextPath}/board/list.do?nowPage=${paging.nowPage}&cntPerPage="+sel;
	}*/
    </script>
    <script type="text/javascript">
    	$(document).ready(function(){
    		$("#catag1").click(function(){
			    var catag = 
    			
    			$.ajax({
    				type:"POST",
    				url:'${pageContext.request.contextPath}/board/list.do',
    				data : catag,
    				success: function(){
    					alert("완료!");
    		            window.opener.location.reload();
    		            self.close();
    				}
    			});
    		});
    		$("#catag2").click(function(){
    			$.ajax({
    				type:"POST",
    				url:'${pageContext.request.contextPath}/board/list.do',
    				success: function(){
    					alert("완료!");
    		            window.opener.location.reload();
    		            self.close();
    				}
    			});
    		});
    		
    	});
    	
    </script>
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
                                    <input class="select-box__input" type="radio" id="asd3" value="1" name="Ben1" checked="checked"/>
                                    <p class="select-box__input-text">전체 보기</p>
                                </div>
                                <div class="select-box__value">
                                    <input class="select-box__input" type="radio" id="asd4" value="2" name="Ben1" checked="checked"/>
                                    <p class="select-box__input-text">건의사항</p>
                                </div>
                                <div class="select-box__value">
                                    <input class="select-box__input" type="radio" id="asd5" value="3" name="Ben1" checked="checked"/>
                                    <p class="select-box__input-text">공지&행사</p>
                                </div>
                                 <div class="select-box__value">
                                    <input class="select-box__input" type="radio" id="asd6" value="4" name="Ben1" checked="checked"/>
                                    <p class="select-box__input-text">자유게시판</p>
                                </div> 
                                <img class="select-box__icon" src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon" aria-hidden="true"/>
                            </div>
                            
                            <ul class="select-box__list">
                                <div id="1">
                                    <li>
                                        <label id="catag1" class="select-box__option" for="asd3" aria-hidden="aria-hidden">
                                        		전체보기
                                        	<input type="hidden" id="catagg1" name="catag" value="%%"/>		
                                      	</label>
                                    </li>
                                </div>
                                <div id="2">
                                    <li>
                                        <label id="catag2" class="select-box__option" for="asd4" aria-hidden="aria-hidden">
                                       		건의사항
                                       		<input type="hidden" name="catag" value="건의"/>		
                                      	</label>
                                    </li>
                                </div>
                                <div id="3">
                                    <li>
                                        <label id="catag3" class="select-box__option" for="asd5" aria-hidden="aria-hidden">
                                        	공지&행사
                                        	<input type="hidden" name="catag" value="공지,행사"/>		
                                        </label>
                                    </li>
                                </div>
                                <div id="4">
                                    <li>
                                        <label  id="catag4" class="select-box__option" for="asd6" aria-hidden="aria-hidden">
                                        	자유게시판
                                        	<input type="hidden" name="catag" value="자유"/>		
                                        </label>
                                    </li>
                                </div>
                            </ul>
                        </div>


                        <div class="select-box">
                            <div class="select-box__current" tabindex="1">
                                <div class="select-box__value">
                                    <input class="select-box__input" type="radio" id="asd0" value="1" name="Ben" checked="checked"/>
                                    <p class="select-box__input-text">모두 보기</p>
                                </div>
                                <div class="select-box__value">
                                    <input class="select-box__input" type="radio" id="asd1" value="2" name="Ben" checked="checked"/>
                                    <p class="select-box__input-text">내가 쓴 글</p>
                                </div>
                                <div class="select-box__value">
                                    <input class="select-box__input" type="radio" id="asd2" value="3" name="Ben" checked="checked"/>
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
                                    <label class="select-box__option" for="asd0" aria-hidden="aria-hidden">모두 보기</label>
                                </li>
                                <li>
                                    <label class="select-box__option" for="asd1" aria-hidden="aria-hidden">내가 쓴 글</label>
                                </li>
                                <li>
                                    <label class="select-box__option" for="asd2" aria-hidden="aria-hidden">스크랩 글</label>
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
                       
                        <c:forEach items="${viewAll }" var="b">
	                        <tr style="z-index:999; color: rgb(93, 93, 253);" data-board-no="${b.no}">
						  
	                            <td>${b.no }</td>
	                            <td>${b.empNo }</td>
	                            <td>${b.catag }</td>
	                            <td>
	                                ${b.title }
	                                <img style=" height: 20px; width: 20px;" src="${pageContext.request.contextPath}/resources/image/newIcon.jpeg" />
	                            </td>
	                            <td></td>
	                            <td>${b.date }</td>
	                            <td>${b.cnt }
	                            	<input type="hidden" name="no" value="${b.no }"/>
	                            </td>
	                        </tr>
                        </c:forEach>
                    </table>
                </div>
                    <!-- 
                        <a href="#" class="arrow">&laquo;</a>
                        <a href="#">1</a>
                        <a href="#" class="active">2</a>
                        <a href="#">3</a>
                        <a href="#">4</a>
                        <a href="#">5</a>
                        <a href="#" class="arrow">&raquo;</a>
                         -->
                    <div class="pagination">
                    <c:if test="${paging.startPage != 1 }">
						<a href="${pageContext.request.contextPath}/board/list.do?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}" class="arrow">&laquo;</a>
					</c:if>
					<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
						<c:choose>
							<c:when test="${p == paging.nowPage }">
								<a class="active">${p }</a>
							</c:when>
							<c:when test="${p != paging.nowPage }">
								<a href="${pageContext.request.contextPath}/board/list.do?nowPage=${p }&cntPerPage=${paging.cntPerPage}" >${p }</a>
							</c:when>
						</c:choose>
					</c:forEach>
					<c:if test="${paging.endPage != paging.lastPage}">
						<a href="${pageContext.request.contextPath}/board/list.do?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}" class="arrow">&raquo;</a>
					</c:if>
					</div>
					
                    <div class="srchBar">
                        <input type="text" name="" id="srchWord">
                        <button type="button" name="" id="srchBtn" class="yellowBtn"><i class="fas fa-search" style="font-size:15px"></i> 검색</button>
                    </div>
                    
                   
					<div style="float: right;">
						<select id="cntPerPage" name="sel" onchange="selChange()">
							<option value="5"
								<c:if test="${paging.cntPerPage == 5}">selected</c:if>>5줄 보기</option>
							<option value="10"
								<c:if test="${paging.cntPerPage == 10}">selected</c:if>>10줄 보기</option>
							<option value="15"
								<c:if test="${paging.cntPerPage == 15}">selected</c:if>>15줄 보기</option>
							<option value="20"
								<c:if test="${paging.cntPerPage == 20}">selected</c:if>>20줄 보기</option>
						</select>
					</div> <!-- 옵션선택 끝 -->

                </div>
            </article>
        </div>
    </section>
</body>
</html>