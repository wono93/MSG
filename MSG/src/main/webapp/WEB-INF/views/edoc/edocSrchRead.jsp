<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/edocSrchRead.css">
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/4c554cd518.js" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
    <title>edocSrchRead</title>
   	<script>
	$(document).ready(function(){
	    // Get the modal
	    var flowModal = document.getElementById("flowModal");
	    
	    // Get the button that opens the modal
	    var flowBtn = document.getElementById("flowBtn");
	    
	    // Get the <span> element that closes the modal
	    var flowConfirm = document.getElementById("flowBoxBtn");
	    var flowSpan = document.getElementById("closeBoxBtn");
	    
	    // When the user clicks on the button, open the modal
	    flowBtn.onclick = function() {
	      flowModal.style.display = "block";
	    }
	    
	    // When the user clicks on <span> (x), close the modal
	    flowSpan.onclick = function() {
	      flowModal.style.display = "none";
	    }
	    flowConfirm.onclick = function() {
	    	flowModal.style.display = "none";
	    }
	});
	</script>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<section class="edocJsp">
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

                        <div class="leftGrp">
                            <h1>${edocTitleFromPage }</h1>
                        </div>
                        <div class="rightGrp">
                            <button type="button" name="" id="flowBtn" class="whiteBtn commonBtn" >결재선</button>
                            <button type="button" name="" id="listBtn" class="whiteBtn commonBtn" onclick="location.href='${pageContext.request.contextPath}/edoc/srch.do'">목록</button>
                        </div>
                    </div>
                    <div class="tbRow">
						<iframe src="getHiddenAddr.do?attachId=${attachId }" frameborder="0" style="width:88%;height:100%">
						</iframe>
                    </div>
                </div>
            </article>
        </div>
    </section>
   	<div id="flowModal" class="modal">
		<!-- Modal content -->
		<div class="modal-content">
			<div class="flowTitle">
				<h1>결재선</h1>
			</div>
			<div class="flowTbDiv">
				<form action="${pageContext.request.contextPath }/edoc/flowExe.do" method="post" accept-charset="UTF-8">
					<table class="flowModalTb">
					<tr>
						<th>유형</th>
	 					<th>이름</th>
						<th>결재의견</th>
						<th>결재여부</th>
						<th>결재일</th>
					</tr>
					<c:forEach items="${edocFlowExList }" var="EdocFlow" >
					<c:if test="${EdocFlow.flowCd eq 'F1'}">
					<tr>
						<td>결재자</td>
						<td>${EdocFlow.deptName } <br />  ${EdocFlow.jobName } ${EdocFlow.empName }</td>
						<c:choose>
						<c:when test="${EdocFlow.flowSt eq 'Y'}">
							<td>${EdocFlow.flowCmt }</td>
							<td>결재</td>
							<td>${EdocFlow.flowDt }</td>
						</c:when>
						<c:when test="${EdocFlow.flowSt eq 'N'}">
							<td>${EdocFlow.flowCmt }</td>
							<td>반려</td>
							<td>${EdocFlow.flowDt }</td>			
						</c:when>
						<c:otherwise>
							<c:choose>
							<c:when test="${EdocFlow.flowEmpNo eq memberLoggedIn.empNo }">
							<td>
								<textarea name="flowCmt" rows="3" cols="50" placeholder="결재의견을 입력하세요"></textarea>
							</td>
							<td>
								<div id="selectFlow" class="select-box">
									<div id="selectFlowSt" class="select-box__current" tabindex="1">
										<div class="select-box__value">
											<input class="select-box__input" type="radio" id="flowN"
												value="N" name="flowSt" />
											<p class="select-box__input-text">반려</p>
										</div>
										<div class="select-box__value">
											<input class="select-box__input" type="radio" id="flowY"
												value="Y" name="flowSt" checked="checked" />
											<p class="select-box__input-text">결재</p>
										</div>
										<img class="select-box__icon"
											src="http://cdn.onlinewebfonts.com/svg/img_295694.svg"
											alt="Arrow Icon" aria-hidden="true" />
									</div>
									<ul id="selectFlowStUl" class="select-box__list">
										<li><label class="select-box__option" for="flowY"
											aria-hidden="aria-hidden">결재</label></li>
										<li><label class="select-box__option" for="flowN"
											aria-hidden="aria-hidden">반려</label></li>
									</ul>
								</div>
							</td>
							<td>
								<input type="hidden" name="flowEmpNo" value="${EdocFlow.flowEmpNo}"/>
								<input type="hidden" name="flowCd" value="${EdocFlow.flowCd}"/>
								<input type="hidden" name="edocId" value="${EdocFlow.edocId}"/>
								<input type="hidden" name="edocTitleFromPage" value="${edocTitleFromPage }"/>
								<button type="submit">제출</button>
							</td>						
							</c:when>
							<c:otherwise>
							<td> </td>
							<td> </td>
							<td> </td>
							</c:otherwise>						
							</c:choose>
						</c:otherwise>
						</c:choose>
					</tr>		
					</c:if>
					<c:if test="${EdocFlow.flowCd eq 'F2'}">
					<tr>
						<td>전결자</td>
						<td>${EdocFlow.deptName } <br />  ${EdocFlow.jobName } ${EdocFlow.empName }</td>
						<c:choose>
						<c:when test="${EdocFlow.flowSt eq 'Y'}">
							<td>${EdocFlow.flowCmt }</td>
							<td>전결</td>
							<td>${EdocFlow.flowDt }</td>
						</c:when>
						<c:when test="${EdocFlow.flowSt eq 'N'}">
							<td>${EdocFlow.flowCmt }</td>
							<td>반려</td>
							<td>${EdocFlow.flowDt }</td>			
						</c:when>
						<c:otherwise>
							<c:choose>
							<c:when test="${EdocFlow.flowEmpNo eq memberLoggedIn.empNo }">
							<td>
								<textarea name="flowCmt" rows="3" cols="50" placeholder="전결의견을 입력하세요"></textarea>
							</td>
							<td>
								<div id="selectFlow" class="select-box">
									<div id="selectFlowSt" class="select-box__current" tabindex="1">
										<div class="select-box__value">
											<input class="select-box__input" type="radio" id="flowN"
												value="N" name="flowSt" />
											<p class="select-box__input-text">반려</p>
										</div>
										<div class="select-box__value">
											<input class="select-box__input" type="radio" id="flowY"
												value="Y" name="flowSt" checked="checked" />
											<p class="select-box__input-text">전결</p>
										</div>
										<img class="select-box__icon"
											src="http://cdn.onlinewebfonts.com/svg/img_295694.svg"
											alt="Arrow Icon" aria-hidden="true" />
									</div>
									<ul id="selectFlowStUl" class="select-box__list">
										<li><label class="select-box__option" for="flowY"
											aria-hidden="aria-hidden">전결</label></li>
										<li><label class="select-box__option" for="flowN"
											aria-hidden="aria-hidden">반려</label></li>
									</ul>
								</div>
							</td>
							<td>
								<input type="hidden" name="flowEmpNo" value="${EdocFlow.flowEmpNo}"/>
								<input type="hidden" name="flowCd" value="${EdocFlow.flowCd}"/>
								<input type="hidden" name="edocId" value="${EdocFlow.edocId}"/>
								<input type="hidden" name="edocTitleFromPage" value="${edocTitleFromPage }"/>
								<button type="submit">제출</button>
							</td>						
							</c:when>
							<c:otherwise>
							<td> </td>
							<td> </td>
							<td> </td>
							</c:otherwise>						
							</c:choose>
						</c:otherwise>
						</c:choose>	
					</tr>		
					</c:if>
					</c:forEach>
					<c:forEach items="${edocFlowExList }" var="EdocFlow" >
					<c:if test="${EdocFlow.flowCd eq 'F3'}">
					<tr>
						<td>협조자</td>
						<td>${EdocFlow.deptName } <br />  ${EdocFlow.jobName } ${EdocFlow.empName }</td>
						<c:choose>
						<c:when test="${EdocFlow.flowSt eq 'Y'}">
							<td>${EdocFlow.flowCmt }</td>
							<td>결재</td>
							<td>${EdocFlow.flowDt }</td>
						</c:when>
						<c:when test="${EdocFlow.flowSt eq 'N'}">
							<td>${EdocFlow.flowCmt }</td>
							<td>반려</td>
							<td>${EdocFlow.flowDt }</td>			
						</c:when>
						<c:otherwise>
							<c:choose>
							<c:when test="${EdocFlow.flowEmpNo eq memberLoggedIn.empNo }">
							<td>
								<textarea name="flowCmt" rows="3" cols="50" placeholder="협조의견을 입력하세요"></textarea>
							</td>
							<td>
								<div id="selectFlow" class="select-box">
									<div id="selectFlowSt" class="select-box__current" tabindex="1">
										<div class="select-box__value">
											<input class="select-box__input" type="radio" id="flowN"
												value="N" name="flowSt" />
											<p class="select-box__input-text">반려</p>
										</div>
										<div class="select-box__value">
											<input class="select-box__input" type="radio" id="flowY"
												value="Y" name="flowSt" checked="checked" />
											<p class="select-box__input-text">협조</p>
										</div>
										<img class="select-box__icon"
											src="http://cdn.onlinewebfonts.com/svg/img_295694.svg"
											alt="Arrow Icon" aria-hidden="true" />
									</div>
									<ul id="selectFlowStUl" class="select-box__list">
										<li><label class="select-box__option" for="flowY"
											aria-hidden="aria-hidden">협조</label></li>
										<li><label class="select-box__option" for="flowN"
											aria-hidden="aria-hidden">반려</label></li>
									</ul>
								</div>
							</td>
							<td>
								<input type="hidden" name="flowEmpNo" value="${EdocFlow.flowEmpNo}"/>
								<input type="hidden" name="flowCd" value="${EdocFlow.flowCd}"/>
								<input type="hidden" name="edocId" value="${EdocFlow.edocId}"/>
								<input type="hidden" name="edocTitleFromPage" value="${edocTitleFromPage }"/>
								<button type="submit">제출</button>
							</td>						
							</c:when>
							<c:otherwise>
							<td> </td>
							<td> </td>
							<td> </td>
							</c:otherwise>						
							</c:choose>
						</c:otherwise>
						</c:choose>
					</tr>
					</c:if>
					</c:forEach>
					</table>
				</form>
				<div class="divBtn">
					<button type="button" id="flowBoxBtn" class="whiteBtn commonBtn">확인</button>
					<button type="button" id="closeBoxBtn"
						class="close whiteBtn commonBtn">취소</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>