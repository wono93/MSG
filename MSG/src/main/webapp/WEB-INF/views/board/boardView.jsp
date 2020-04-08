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
    	function fileDownload(oName, rName){
        		//한글파일명이 있을 수 있으므로, 명시적으로 encoding
        		oName = encodeURIComponent(oName);
        		location.href="${pageContext.request.contextPath}/board/fileDownload.do?oName="+oName+"&rName="+rName;
        	}

 		function update(no, empNo){
 				location.href = "${pageContext.request.contextPath}/board/update.do?boardNo="+no+"&empNo="+empNo;
 			}
		 		
		
		function insertComment(no){
				location.href = "${pageContext.request.contextPath}/board/insertComment.do?boardNo="+no;
			}
		
		/*
		function insertScrap(no){
			location.href = "${pageContext.request.contextPath}/board/insertScrap.do?boardNo="+no;
			}
		*/
    </script>
    <!-- 
		    $(document).ready(function () {
		 		
		 		$("fileDownload").on("click", function(oName, rName){ //파일 추가 버튼 
		 			oName = encodeURIComponent(oName);
	        		location.href="${pageContext.request.contextPath}/board/fileDownload.do?oName="+oName+"&rName="+rName;
		        	});
		 		$("update").on("click", function(no){ //파일 추가 버튼 
		 			location.href = "${pageContext.request.contextPath}/board/update.do?boardNo="+no;
		        	});
		 		
		        var heartval = ${heart};
		
		        if(heartval>0) {
		            console.log(heartval);
		            $("#heart").prop("src", "${pageContext.request.contextPath}/resources/image/star1.png");
		            $(".heart").prop('name',heartval)
		        }
		        
		        else {
		            console.log(heartval);
		            $("#heart").prop("src", "${pageContext.request.contextPath}/resources/image/star0.jpg");
		            $(".heart").prop('name',heartval)
		        }
		
		        $(".heart").on("click", function () {
		
		            var that = $(".heart");
		
		            var sendData = {'boardNo' : '${board.no}','heart' : that.prop('name')};
		            $.ajax({
		                url :'/board/view.do',
		                type :'POST',
		                data : sendData,
		                success : function(data){
		                    that.prop('name',data);
		                    if(data==1) {
		                        $('#heart').prop("src","${pageContext.request.contextPath}/resources/image/star1.png");
		                    }
		                    else{
		                        $('#heart').prop("src","${pageContext.request.contextPath}/resources/image/star0.jpg");
		                    }
		
		
		                }
		            });
		        });
		    });
		 		-->
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
                                <p name="title">
                                ${board.title }
                                </p>
                            </div>

                           
							<!-- 1은 현재로그인한 사용자 -->
							<div id="star">
						       <a class="btn btn-outline-dark heart">
						           <img style="width: 30px; height: 30px;" id="heart" src="">
						       </a>
						   </div>
					

                            <div id="member">
                                <p class="com3">${member.deptCd }</p>
                                <p class="com3">${member.jobCd }</p>
                                <p class="com3">${member.empName }</p>
                            </div>
                            
                        </div>
                        <div id="comRight">
                            <div id="category">
								<p name="catag" >${board.catag }</p>
                            </div>
                            <div id="date">
                                <i class="fas fa-eye" id="eye">
                                </i>
                                <p name="cnt" class="com3" style="font-size: 22px; padding-right: 8px;">
                                ${board.cnt }
                                </p>
                                <p name="date" class="com3">
                                ${board.bdate }
                                </p>
                            </div>
                        </div>
                    </div>
                <div id="boardContentH">
                    <div id="boardContent">
                        <p name="content" class="com4">
                        	${board.content }
                        </p>
                        <c:if test="${board.attachList[0].no != 0 }" >
							<c:forEach items="${board.attachList}" var="a" varStatus="vs">
							
								<button type="button" style="text-align: left;" onclick="fileDownload('${a.file}','${a.refile }');">
									첨부파일${vs.count} - ${a.file }
								</button>
							</c:forEach>
						</c:if>
                    </div>
                    
                    <div>
                        <div style="margin-top:35px; width: 100%; height: 100%; z-index: 100; position: relative; 
                            display: inline-block;">
                            
                            <button type="button" name="" id="grayBtn1" class="btn" onclick="update('${board.no}','${board.empNo }');">수정</button>
                            
                            <form name="boardFrm" 
							  action="${pageContext.request.contextPath}/board/deleteBoard.do" 
							  method="post" 
							  onsubmit="return boardValidate();"
							  enctype="multipart/form-data">
							  
                            	<button type="submit" name="" id="grayBtn1" class="btn">삭제</button>
                            	<input type="hidden" name="no" value="${board.no }" />
							</form>
                        </div>
                    </div>
                    <div style="height: 100%;" id="commentContent">
                        <div id="commentCnt">
                            <p class="com5">2 개의 댓글</p>
                            <br>
                        </div>
                        
                       	 <c:if test="${board.commentList[0].no != null }" >
						<c:forEach items="${board.commentList}" var="c">
							<form name="boardFrm" 
						  action="${pageContext.request.contextPath}/board/deleteComment.do?boardNo=${board.no }&empNo=${board.empNo}"
						  method="post" 
						  onsubmit="return boardValidate();"
						  enctype="multipart/form-data">
		                        <div id="commentUser">
		                            <table>
		                                <tr>
		                                    <td style="padding-left: 0px; padding-right: 0px; width: 50px;">
		                                        <div class="box1" style="background: #BDBDBD;">
		                                        <img class="profile" src="${pageContext.request.contextPath}/resources/image/worker.jpg">
		                                        </div>
		                                    </td>
			                                    <c:forEach begin="0" end="0" items="${commentList }" var="co">
				                                    <c:forEach begin="0" end="0" items="${memberList }" var="m">
						                                    <c:if test="${co.empNo == m.empNo}">
						                                    	<td style="padding: 0; width: 166px;">
						                                    		${m.deptCd} ${m.jobCd}  ${m.empName }
						                                    	</td>
						                                    </c:if>
				                                    </c:forEach>
			                                    </c:forEach>
		                                    <td style="font-size: 22px; padding-left: 20px;">${c.cmtContent }</td>
		                                    <td style="padding: 0; width: 166px; color: gray;">
		                                        ${c.date }
		                                        <br>
		                                        <input type="hidden" name="no" value="${c.no }">
		                                        <button type="submit" name="" id="grayBtn3" class="btn">삭제</button>
		                                    </td>
		                                </tr>
		                            </table>
		                        </div>
		                        </form>
	                       </c:forEach>
							</c:if>
		  				
                        <form name="boardFrm" 
						  action="${pageContext.request.contextPath}/board/insertComment.do?boardNo=${board.no}&empNo=${board.empNo}"
						  method="post" 
						  onsubmit="return boardValidate();"
						  enctype="multipart/form-data">
                        <div id="commentUser">
                        <input type="hidden" name="brdNo" value="${board.no }"/>
                            <table>
                                <tr>
                                    <td style="width: 720px;">
                                    <div>
                                        <textarea name="cmtContent" id="inputWrd"></textarea>
                                        </div>
                                    </td>
                                    <td>
                                    	<input type="hidden" value="${memberLoggedIn.empNo}" name="empNo"/>
                                        <button style="margin-bottom: 12px; bottom: 10px;
                                        right: 22px;" type="submit" name="" id="grayBtn2" class="yellowBtn">
                                          		  댓글등록
                                        </button>                        
                                    </td>
                                </tr>
                            </table>
                        </div>
                       </form>
                    </div>
                </div>
                </div>
            </div>
         </article>
    </section>

</body>
</html>