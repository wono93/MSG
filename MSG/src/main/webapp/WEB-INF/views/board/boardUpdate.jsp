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
       
        function boardValidate(){
        	var content = $("[name=content]").val();
        	if(content.trim().length==0){
        		alert("내용을 입력하세요");
        		return false;
        	}
        	return true;
        }

        function update(no, empNo){
			location.href = "${pageContext.request.contextPath}/board/update.do?boardNo="+no+"&empNo="+empNo;
		}
        
		$(()=>{
		        	
	        	$("[name=upFile]").on("change", e => {
	        		let $file = $(e.target); //사용자가 작성한 file input 태그
	        		
	        		//취소한 경우
	        		if($file.prop('files')[0] === undefined){
	        			$file.next(".custom-file-label").html("파일을 선택하세요.");
	        		}
	        		else{
	        			let fileName = $file.prop('files')[0].name;
	        			$file.next(".custom-file-label").html(fileName);
	        		}
	        	});
	        });
		
      </script>
    <title>boardWrite</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<form name="boardFrm" 
		  action="${pageContext.request.contextPath}/board/update.do?boardNo=${board.no}&empNo=${board.empNo}" 
		  method="post"
		  onsubmit="return boardValidate();"
		  enctype="multipart/form-data">
    <section>
        <div>
        <input type="hidden" name="no" value="${board.no }" />
        
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
                                <input class="select-box__input" name="catag" type="radio" id="asd3" value="건의" checked="checked"/>
                                <p class="select-box__input-text">건의사항</p>
                                </div>
                                <div class="select-box__value">
                                <input class="select-box__input" name="catag" type="radio" id="asd4" value="자유" checked="checked"/>
                                <p class="select-box__input-text">자유 게시판</p>
                                </div>
                                <div class="select-box__value">
                                <input class="select-box__input" name="catag" type="radio" id="asd5" value="공지,행사" checked="checked"/>
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
                                <label class="select-box__option" for="asd3" aria-hidden="aria-hidden">건의사항</label>
                                </li>
                                <li>
                                <label class="select-box__option" for="asd4" aria-hidden="aria-hidden">자유 게시판</label>
                                </li>
                                <li>
                                <label class="select-box__option" for="asd5" aria-hidden="aria-hidden">공지사항 & 행사정보</label>
                                </li>
                                <!-- <li>
                                <label class="select-box__option" for="2" aria-hidden="aria-hidden">문서종류</label>
                                </li> -->
                            </ul>
                        
                        <div id="boardTitle">
                            <input type="text" name="title" id="srchWord" value="${board.title }">
                            
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
                
                <div id="api">
                      <div style="width: 914px; margin-left: 1px;">
                        <textarea id="summernote" name="content">${board.content }</textarea>
                      </div>
                </div>
                 <!--
								<button type="button" style="text-align: left;" onclick="fileDownload('${a.file}','${a.refile }');">
									첨부파일${vs.count} - ${a.file }
								</button>--> 
                <div id="file">
                	<div id="fileDiv">
                		<c:if test="${board.attachList[0].no != 0 }" >
							<c:forEach items="${board.attachList}" var="a" varStatus="vs">
								<p>
									<button type="file" style="text-align: left;">
										${a.file }
									</button>
				                 	<a style="" href="#this" class="btn" id="delete" name="delete">삭제</a>
		                    	</p>
		                    	<br>
							</c:forEach>
						</c:if>
		                    <p>
			                    <input type="file" id="upFile0" name="upFile">
				                 <a style="float:center;" href="#this" class="btn" id="delete" name="delete">삭제</a>
		                    </p>
                	</div>
                    <!-- <input type="file"/> -->
	                <br/><br/>
	                <a style="float:left;" href="#this" class="btn" id="addFile">파일 추가</a> 
                 </div>
	        <script type="text/javascript">
	
	        var gfv_count = 1;
	        $(document).ready(function(){
		        $("#addFile").on("click", function(e){ //파일 추가 버튼 
		        	e.preventDefault(); fn_addFile(); 
		        	});
		        $("a[name='delete']").on("click", function(e){ //삭제 버튼 e.preventDefault(); 
			        fn_deleteFile($(this)); 
			        });
	        });
	        
	        function fn_addFile(){ 
	        	var str = "<p><input type='file' id='upFile"+(gfv_count++)+"' name='upFile'><a href='#this' class='btn' name='delete'>삭제</a></p>";
	        	$("#fileDiv").append(str); 
	        	$("a[name='delete']").on("click", function(e){//삭제 버튼
	        		e.preventDefault(); fn_deleteFile($(this)); 
	        		}); 
	        	}
	        function fn_deleteFile(obj){
	        	obj.parent().remove(); 
	        	}
	
	      </script>
                    <div class="srchBar">
                        <button type="button" name="" id="grayBtn" class="btn" onclick="location.href='${pageContext.request.contextPath}/board/view.do?boardNo=${board.no }&empNo=${board.empNo }'"> 취  소 </button>
                        <button type="submit" name="" id="yellowBtn" class="btn" onclick="update('${board.no}', '${board.empNo }');">수정하기</button>
                    </div>
                </div>
            	
            </article>
        </div>
    </section>
            </form>

</body>
</html>