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

 		function update(no, empNo, memberEmpno){
 				location.href = "${pageContext.request.contextPath}/board/iframeUpdate.do?boardNo="+no+"&empNo="+empNo+"&memberEmpno="+memberEmpno;
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
    <style>
    #yellowBtn{
	    background-color: #f4ca25;
	    border: none;
	    color: #333333;
	    padding: 9px 19px;
	    text-align: center;
	    text-decoration: none;
	    display: inline-block;
	    font-size: 14px;
	    font-weight: 600;
	    margin-right: 20px;
    	margin-top: 13px;
	}
    </style>
    
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
                     
                        <li onclick="location.href='${pageContext.request.contextPath}/board/list.do'">사내게시판</li>
                     </ul>
                </div>
                <div class="content">
                    <div class="control">
                        <div class="box"  background: #BDBDBD;">
                            <img   class="profile" src="${pageContext.request.contextPath }/resources/upload/empImg/${member.empImage}">
                        </div>
                        <div id="comLeft">
                            <div style="height:40px;" id="title">
                                <p name="title">
                                ${board.title }
                                 
                                
	                               <c:if test="${boardScrapCount == 0}">
									    <div style="">
											<p style="left: 238px; position: relative; top: -50px;">
												<a id="Scr" href="#ex1" onclick="" rel="modal:open">
													<i id="star1"  class="far fa-star" style="color:#999; font-size: 30px; "></i>
												</a>
											</p>
										</div>
									</c:if>
									<c:if test="${boardScrapCount != 0}">
										<div style="">
											<p style="left: 238px; position: relative; top: -50px;">
												<a id="Scr" href="#ex1" onclick="deleteFunction()" rel="">
													<i id="star1" class="fas fa-star" style="color:#999; font-size: 30px; "></i>
												</a>
											</p>
										</div>
									</c:if>
                                </p>
                                
                            </div>
				    <div>
				    <div style="top:77px;" id="member">
                                <p class="com3">${member.deptName }</p>
                           
                                <p class="com3">${member.jobName }</p>
                            	
                           
                                <p class="com3">${member.empName }</p>
                            
						
						</div>
						
				            <div style="bottom:200px; z-index: 100;" id="ex1" class="modal">
				            <p>Scrap memo</p>
				              <textarea style="width:427px; height:94px;" class="memo" id="memo" name="memo" rows="" cols=""></textarea>
				              <br><br>
				              <div>
				              <!-- 
							  <button id="send-dm-button" class="dmButton" rel="modal:close"
								onclick="submitFunction();">등록</button>
				               -->
							  	<a href="#" style="margin:0; margin-right:10px; height: 24PX; width: 48px;" id="grayBtn1" class="btn" rel="modal:close">닫기</a>
				              </div>
				              <div>
								<a href="#" style="margin:0; margin-right:10px; height: 24PX; width: 48px;" id="grayBtn1" class="btn" onclick="submitFunction();" rel="modal:close">등록</a>
				              </div>
							</div>
			        </div>
			        <style>
					.modal a.close-modal{
					  top: 13px;
			  right: 15px;
			  width: 20px;
					  background-image: url("${pageContext.request.contextPath }/resources/image/X-icon.png");
					  }
			        </style>
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
								 $('#star1').attr("class", 'fas fa-star');
								 $('#Scr').attr("onclick", "deleteFunction();");
								 $('#Scr').attr("rel", "");
							}
						});
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
								 $('#star1').attr("class", 'far fa-star');
								 $('#Scr').attr("onclick", "");
								 $('#Scr').attr("rel", "modal:open");
							}
						});console.log("스크랩취소");
					}
				</script>
                            
                            
                        </div>
                        <div id="comRight">
                            <div id="category">
								<p name="catag" >${board.catag } 게시판</p>
                            </div>
                            <div id="date">
                                <i class="fas fa-eye" id="eye">
                                </i>
                                <p name="cnt" class="com3" style="font-size: 18px; padding-right: 8px;">
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
                       				 <div style="text-align:left;">
                       				 	<a style="cursor:pointer;" onclick="fileDownload('${a.file}','${a.refile }');">
											<i style="color: orangered;"  class="fas fa-file-download"></i>
												${a.file }
										</a>
                       				 </div>
								</c:forEach>
							</c:if>
                    </div>
                    
                    <div>
                        <div style="margin-top:35px; width: 100%; height: 100%; z-index: 1; position: relative; 
                            display: inline-block;">
                             <c:if test="${memberLoggedIn.empNo == board.empNo || memberLoggedIn.authority eq 'H' || memberLoggedIn.authority eq 'A' }">
                            	<button style="z-index:78;" type="button" name="" id="grayBtn1" class="btn" onclick="update('${board.no}','${board.empNo }', '${memberLoggedIn.empNo }');">수정</button>
                            </c:if>
                            <form name="boardFrm" 
							  action="${pageContext.request.contextPath}/board/deleteBoard.do?boardNo=${board.no}" 
							  method="post" 
							  onsubmit="return boardValidate();"
							  enctype="multipart/form-data">
							  <c:if test="${memberLoggedIn.empNo == board.empNo || memberLoggedIn.authority eq 'H' || memberLoggedIn.authority eq 'A' }">
                            	<button style="z-index:78;" type="submit" name="" id="grayBtn1" class="btn">삭제</button>
                            	<input type="hidden" name="no" value="${board.no }" />
							  </c:if>
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
						  action="${pageContext.request.contextPath}/board/deleteComment.do?boardNo=${board.no }&empNo=${board.empNo}&memberEmpno=${memberLoggedIn.empNo}"
						  method="post"
						  onsubmit="return boardValidate();"
						  enctype="multipart/form-data">
		                        <div id="commentUser">
		                            <table>
		                                <tr>
		                                    <td style="padding-left: 0px; padding-right: 0px; width: 50px;">
		                                        <div class="box1" style="background: #BDBDBD;">
		                                        	<img class="profile" src="${pageContext.request.contextPath }/resources/upload/empImg/${c.empImage}">
		                                        </div>
		                                    </td>
	                                    	<td style="font-size:10px; text-align:left; position: relative; left: 8px; padding: 0; width: 166px;">
	                                    		${c.deptName} ${c.jobName}  ${c.empName }
	                                    	</td>
			                                   
		                                    <td style="font-size: 18px; padding-left: 20px;">${c.cmtContent }</td>
		                                    <td style="padding: 0; width: 166px; color: gray;">
		                                        ${c.date }
		                                        <br>
		                                        <input type="hidden" name="no" value="${c.no }">
		                                         <c:if test="${memberLoggedIn.empNo == c.empNo || memberLoggedIn.authority eq 'H' || memberLoggedIn.authority eq 'A' }">
		                                        	<button type="submit" name="" id="grayBtn3" class="btn">삭제</button>
		                                        </c:if>
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