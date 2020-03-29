<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/edocSrch.css">
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/4c554cd518.js" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
    <title>srchForm</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <section>
        <div>
            <article>
                <div class="subNav">
                    <h3>전자결재</h3>
                    <ul>
                        <li onclick="location.href='${pageContext.request.contextPath}/edoc/srch.do'">문서검색</li>
                        <li onclick="location.href='${pageContext.request.contextPath}/edoc/list.do'">내문서함</li>
                        <li onclick="location.href='${pageContext.request.contextPath}/edoc/write.do'">문서기안</li>
                     </ul>
                </div>
                <div class="content">
                    <div class="control">
                    	<p>총 ${totalContents }건의 전자문서가 있습니다.</p>
                    </div>
                    <table>
                        <tr>
                            <th>문서ID</th>
                            <th>문서종류</th>
                            <th>제목</th>
                            <th>기안자</th>
                            <th>보안등급</th>
                            <th>기안일</th>
                            <th>보존연한</th>
                        </tr>
						<c:forEach items="${list }" var="ed">
						<tr data-edoc-no="${ed.edocId }">
							<td>${ed.edocId }</td>
							<td>${ed.formNm }</td>
							<td>${ed.edocTitle }</td>
							<td>${ed.empName }</td>
							<td>${ed.secuNm }</td>		
							<td>${ed.edocDt }</td>		
							<td>${ed.prsvAmt }년</td>		
						</tr>
						</c:forEach>
                    </table>
                    <div class="pagination">
						${pageBar }
                    </div>
                    <div class="srchBar">
                        <div class="select-box">
                            <div class="select-box__current" tabindex="1">
                                <div class="select-box__value">
                                <input class="select-box__input" type="radio" id="D0" value="edoc_title" name="Ben"/>
                                <p class="select-box__input-text">제목</p>
                                </div>
                                <div class="select-box__value">
                                <input class="select-box__input" type="radio" id="D1" value="emp_name" name="Ben"/>
                                <p class="select-box__input-text">기안자</p>
                                </div>
                                <div class="select-box__value">
                                <input class="select-box__input" type="radio" id="D2" value="form_nm" name="Ben"/>
                                <p class="select-box__input-text">문서종류</p>
                                </div>
                                <div class="select-box__value">
                                <input class="select-box__input" type="radio" id="D3" value="edoc_id" name="Ben"/>
                                <p class="select-box__input-text">문서ID</p>
                                </div>
                                <div class="select-box__value">
                                <input class="select-box__input" type="radio" id="D4" value="all" name="Ben" checked="checked"/>
                                <p class="select-box__input-text">전체</p>
                                </div><img class="select-box__icon" src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon" aria-hidden="true"/>
                            </div>
                            <ul class="select-box__list">
                                <li>
                                <label class="select-box__option" for="D4" aria-hidden="aria-hidden">전체</label>
                                </li>
                                <li>
                                <label class="select-box__option" for="D0" aria-hidden="aria-hidden">제목</label>
                                </li>
                                <li>
                                <label class="select-box__option" for="D1" aria-hidden="aria-hidden">기안자</label>
                                </li>
                                <li>
                                <label class="select-box__option" for="D2" aria-hidden="aria-hidden">문서종류</label>
                                </li>
								<li>
                                <label class="select-box__option" for="D3" aria-hidden="aria-hidden">문서ID</label>
                                </li>
                            </ul>
                        </div>
                        <input type="text" name="" id="srchWord">
                        <button type="button" name="" id="srchBtn" class="yellowBtn"><i class="fas fa-search" style="font-size:15px"></i> 검색</button>
                    </div>
                </div>
            </article>
        </div>
    </section>
    <script>

    $(document).ready(function(){
		$("tr[data-edoc-no]").on("click", function() {
			let edocId = $(this).attr("data-edoc-no");
			console.log(edocId);
			location.href="${pageContext.request.contextPath}/edoc/srchDtl.do?edocId="+edocId;
		});
		
 	});

    
    </script>
</body>
</html>