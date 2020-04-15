<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@page import="com.kh.msg.member.controller.MemberController"%>
	<%@page import="com.kh.msg.member.model.vo.LoginVO"%>
	<%@page import="com.kh.msg.member.model.vo.OrgChart"%>
	<%@page import="java.util.ArrayList"%>
	<%@page import="com.kh.msg.chat.model.vo.DirectMsg"%>
	<%@page import="java.util.List"%>
	<%@page import="java.util.Enumeration" %>
<html lang="en">
<%
	//OrgChart oc = null;
	//if(session.getAttribute("memberLoggedIn") != null){
	//	oc = (OrgChart)session.getAttribute("memberLoggedIn");	
	//}
	OrgChart oc = (OrgChart)session.getAttribute("memberLoggedIn");
	String userId = oc.getUserId();
	int empNo = oc.getEmpNo();
%>

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
			function gogo(no, empNo, memberEmpno){
	        	parent.location.href="${pageContext.request.contextPath}/board/view.do?boardNo="+no+"&empNo="+empNo+"&memberEmpno="+memberEmpno;
	        	location.reload();
	        }
      </script>
    <style>
	                .file_input label {
					    position:relative;
					    cursor:pointer;
					    display:inline-block;
					    vertical-align:middle;
					    overflow:hidden;
					    width:100px;
					    height:30px;
					    background:#777;
					    color:#fff;
					    text-align:center;
					    line-height:30px;
					}
					.file_input label input {
					    position:absolute;
					    width:0;
					    height:0;
					    overflow:hidden;
					}
					.file_input input[type=text] {
					    vertical-align:middle;
					    display:inline-block;
					    width:400px;
					    height:28px;
					    line-height:28px;
					    font-size:11px;
					    padding:0;
					    border:0;
					    border:1px solid #777;
					}
                 </style>
    <section style="height:100%">
        <div style="height:100%">
        
        
            <article style="width: 1200; height: 100%;">
             <div style="display: inline-block;
			    width: 1020px;
			    height: 100%;
			    vertical-align: middle;
			    border: 1px solid black;
			    background-color: #fefefe;" class="content">
		        <form name="boardFrm" 
				  action="${pageContext.request.contextPath}/board/update.do?boardNo=${board.no}&empNo=${board.empNo}&memberEmpno=${memberLoggedIn.empNo}" 
				  method="post"
				  onsubmit="return boardValidate();"
				  enctype="multipart/form-data" target="iframeWrite1">        
        <input type="hidden" name="no" value="${board.no }" />          
               
                    <div style="position:relative; height:150px; left:15px;"  class="control">
                        
                        <div class="boardBB">
                            <p class="com4">게시판</p>
                            <p class="com4">제 목</p>
                        </div>
                   
                    <div class="boardBC">
				 
                    </div>
                        <div style="top: 20px; z-index: 1;" id="first1" class="select-box1">
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
                        <p class="com3">${memberLoggedIn.deptCd}</p>
                        <p class="com3">${memberLoggedIn.jobCd}</p>
                        <p class="com3">${memberLoggedIn.empName}</p>
                        <p class="com3"></p>
                        <div class="box" style="background: #BDBDBD;">
                            <img class="profile" src="${pageContext.request.contextPath }/resources/upload/empImg/${memberLoggedIn.empImage}">
                        </div>
                    </div>
                </div>
                 <hr>
                
	                <div style=" border: 1px solid black; margin-left:50px; margin-top:35px; height:70px; width:915px;" class="file_input" id="fileDiv">
	                			<label style="cursor:pointer; margin-top:20px;">
	                				파일 첨부
			                    	<input type="file" id="upFile0"  name="upFile" multiple="multiple">
	                			</label>
	             			  	<input style="margin-top:16px;" type="text" readonly="readonly" title="File Route">
	               	</div>
                 <div style="margin-left:48px; margin-top:11px" id="api">
                      <div style="width: 914px; margin-left: 1px;">
                        <textarea id="summernote" name="content">${board.content }</textarea>
                      </div>
                </div>
                 
	        <script type="text/javascript">
	        $('.file_input input[type=file]').change(function() {
		        var fileName = $(this).val();
		        var fileCount = $(this).get(0).files.length;
		        if($(this).get(0).files.length == 1){
		            $('.file_input input[type=text]').val(fileName);
		        }
		        else {
		            $('.file_input input[type=text]').val('파일 '+fileCount+'개');
		        }
		    });

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
	        	var str = "<p><input type='file' id='upFile"+(gfv_count++)+"' name='upFile'><a href='#this' class='btn' name='delete'>삭제</a></p><hr>";
	        	$("#fileDiv").append(str); 
	        	$("a[name='delete']").on("click", function(e){//삭제 버튼
	        		e.preventDefault(); fn_deleteFile($(this)); 
	        		}); 
	        	}
	        function fn_deleteFile(obj){
	        	obj.parent().remove(); 
	        	}
	
	      </script>
                    <div id="writebtn" style="position:relative;"  class="srchBar">
                        <button type="button" name="" id="grayBtn" class="btn" onclick="location.href='${pageContext.request.contextPath}/board/view.do?boardNo=${board.no }&empNo=${board.empNo }&memberEmpno=${memberLoggedIn.empNo }'"> 취  소 </button>
                        <button type="submit"  onclick="gogo('${board.no}', '${board.empNo }','${memberLoggedIn.empNo }');" name="" id="yellowBtn" class="btn" >수정하기</button>
                    </div>
		            </form>
                </div>
            	
            </article>
        </div>
    </section>