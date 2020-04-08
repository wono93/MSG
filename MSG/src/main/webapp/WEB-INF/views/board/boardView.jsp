<!DOCTYPE html>
	
<html lang="en">
	<%@page import="com.kh.msg.member.model.vo.Member"%>
	<%@page import="java.text.SimpleDateFormat"%>
	<%@page import="java.util.Date"%>
	<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/boardView.css">
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/4c554cd518.js" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
    
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
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
                                <p name="title">
                                ${board.title }
                                </p>
                            </div>
                            
				    <div>
						<c:if test="${board.no != boardScrap.no && boardScrap.empNo != memberLoggedIn.empNo }">
							<p>
								<a id="Scr" href="#ex1" onclick="" rel="modal:open">
									<img id="star1" class="myImg" src="${pageContext.request.contextPath}/resources/image/star1.png" width="50" height="50">
								</a>
							</p>
						</c:if>
						<c:if test="${board.no == boardScrap.no && boardScrap.empNo == memberLoggedIn.empNo }">
							<p>
								<a id="Scr" href="#ex1" onclick="deleteFunction()" rel="">
									<img id="star1" class="myImg" src="${pageContext.request.contextPath}/resources/image/star0.jpg" width="50" height="50">
								</a>
							</p>
						</c:if>
				            <div style="bottom:200px; z-index: 100;" id="ex1" class="modal">
				              <textarea class="memo" id="memo" name="memo" rows="" cols=""></textarea>
				              <div>
				              <!-- 
							  <button id="send-dm-button" class="dmButton" rel="modal:close"
								onclick="submitFunction();">등록</button>
				               -->
								<a href="#" onclick="submitFunction();" rel="modal:close">등록</a>
				              </div>
				              <div>
							  <a href="#"  rel="modal:close">닫기</a>
				              </div>
							</div>
			        </div>

				<script>
				 $('a[href="#ex7"]').click(function(event) {
				      event.preventDefault();
				 
				      $(this).modal({
				        fadeDuration: 250
				      });
				    });
				 
				 function submitFunction() {
						var memberEmpno = ${memberLoggedIn.empNo};
						var boardNo = ${board.no};
						var memo = hdjq("#memo").val();
						
						hdjq.ajax({
							type : "POST",
							url : "./insertScrap.do",
							data : {
								boardNo : encodeURIComponent(boardNo),
								memberEmpno : encodeURIComponent(memberEmpno),
								memo : encodeURIComponent(memo)
							},
							success : function(result) {
								 $('#star1').attr("src", '${pageContext.request.contextPath}/resources/image/star0.jpg');
								 $('#Scr').attr("onclick", "deleteFunction();");
								 $('#Scr').attr("rel", "");
							}
						});
						alert("스크랩 등록");
					}
				 
				 
				 
				 function deleteFunction() {
						var memberEmpno = ${memberLoggedIn.empNo};
						var boardNo = ${board.no};
						
						hdjq.ajax({
							type : "POST",
							url : "./deleteScrap.do",
							data : {
								boardNo : encodeURIComponent(boardNo),
								memberEmpno : encodeURIComponent(memberEmpno),
							},
							success : function(result) {
								 $('#star1').attr("src", '${pageContext.request.contextPath}/resources/image/star1.png');
								 $('#Scr').attr("onclick", "");
								 $('#Scr').attr("rel", "modal:open");
							}
						});
						alert("스크랩 취소");
					}
				</script>
							
							
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
                        <div style="margin-top:35px; width: 100%; height: 100%; z-index: 77; position: relative; 
                            display: inline-block;">
                            
                            <button style="z-index:78;" type="button" name="" id="grayBtn1" class="btn" onclick="update('${board.no}','${board.empNo }');">수정</button>
                            
                            <form name="boardFrm" 
							  action="${pageContext.request.contextPath}/board/deleteBoard.do" 
							  method="post" 
							  onsubmit="return boardValidate();"
							  enctype="multipart/form-data">
							  
                            	<button style="z-index:78;" type="submit" name="" id="grayBtn1" class="btn">삭제</button>
                            	<input type="hidden" name="no" value="${board.no }" />
							</form>
                        </div>
                    </div>
                    <div style="height: 100%;" id="commentContent">
                        <div id="commentCnt">
                            <p class="com5">${countComment } 개의 댓글</p>
                            <br>
                        </div>
                      
                       	
						<c:forEach items="${commentList}" var="c">
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
				                                    
	                                    	<td style="padding: 0; width: 166px;">
	                                    		${c.deptCd} ${c.jobCd}  ${c.empName }
	                                    	</td>
						                                 
			                                   
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
							
                        <form name="boardFrm" 
						  action="${pageContext.request.contextPath}/board/insertComment.do?boardNo=${board.no}&empNoReturn=${board.empNo}&memberEmpno=${memberLoggedIn.empNo}"
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