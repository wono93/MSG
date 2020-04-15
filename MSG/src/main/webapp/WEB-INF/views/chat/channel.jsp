<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/channel.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/channelModify.css">
    <script src="${pageContext.request.contextPath }/resources/js/channelModify.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/channel.js"></script>
</head>
<body>
	<input type="hidden" name="chEx" value="${chEx }" id="inputChEx"/>
	<input type="hidden" name="regId" value="${regId }" id="inputRegId"/>
	<input type="hidden" name="userId" value="${userId }" id="inputUserId"/>
	<input type="hidden" name="chNo" value="${chNo }" id="inputChNo"/>
	<input type="hidden" name="chName" value="${chName }" id="inputChName"/>
	
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
				        <div id="channel-member-container">
				        </div>
				        <p id="channel-title"></p>
				        <p id="channel-ex"></p>
				        <div class="btnGrp">
					        <!-- <button id="video" class="button">화상회의</button> -->
					        <c:if test="${regId == memberLoggedIn.userId }">
						        <button id="addMemberModify" class="channel-button">채널 수정</button>
					        </c:if>
				        </div>
					</div>
					
				    <div id="channel-container"></div>
		        
			        <div id="channel-send-msg-container">
			            <textarea name="" id="channel-send-msg-content" cols="150" rows="5"></textarea>
			            <button onclick="channelSubmitFunction();" id="channel-send-msg-button" class="channel-button">전송</button>
			        </div>
		        </div>
			</article>
		</div>
    </section>    
    
    <div id="channelModifyModal" class="ch-modal">
   		<!-- Modal content -->
            <div class="ch-modal-content">
                <a href="#">
	                <img src="${pageContext.request.contextPath}/resources/image/X-icon.png" alt="" class="x-icon closeModify" id="close-btn">
                </a>
                <div id="ch-content">
                    <form action="${pageContext.request.contextPath}/chat/modifyChannel.do" method="Post">
                        <div class="channelGenTitle">
                            <h3>채널 수정</h3>
                            <a href="#">
	                            <img src="${pageContext.request.contextPath}/resources/upload/empImg/${memberLoggedIn.empImage}" id="ch-modify-aura" class="ch-member-img">
	                            <img src="${pageContext.request.contextPath}/resources/image/king.svg" id="ch-modify-head">
                            </a>
                        </div>

                        <input type="text" name="chName" class="ch-input" placeholder="채널명을 입력해주세요." required="required" tabindex="3" value="${chName }">
                        <input type="text" name="chEx" class="ch-input" placeholder="채널 소개란을 입력해주세요." required="required" tabindex="4" value="${chEx }">
                        <input type="hidden" name="regEmpNo" value="${memberLoggedIn.empNo }">
                        <input type="hidden" name="regId" value="${memberLoggedIn.userId }">
                        <input type="hidden" name="chNo" value="${chNo}">

					<div id="ch-member-list">
						<table id="ch-modify-member-table">
							<tr>
                          		<td><img src="/msg/resources/upload/empImg/${memberLoggedIn.empImage }" id="ch-member-list-img" class="ch-member-img"></td>
                           		<td>${memberLoggedIn.empName }</td>
                           		<td>${memberLoggedIn.deptName }</td>
                           		<td>${memberLoggedIn.jobName }</td>
                           		<td class="delNo">${memberLoggedIn.empNo }</td>
                           		<td></td>
								<input type="hidden" name="empNo" value="${memberLoggedIn.empNo }">
							</tr>
                        </table>
                 	</div>

                        <div class="channel_srchChBar">
                            <div class="channel_select-box">
                                <div class="channel_select-box__current" tabindex="1">
                                    <div class="channel_select-box__value">
                                        <input class="channel_select-box__input" type="radio" id="MT1" value="emp_name" name="chModifySearchType" checked="checked"/>
                                        <p class="channel_select-box__input-text">이름</p>
                                    </div>
                                    <div class="select-box__value">
                                        <input class="channel_select-box__input" type="radio" id="MT2" value="dept_name" name="chModifySearchType" />
                                        <p class="channel_select-box__input-text">부서</p>
                                    </div>
                                    <div class="channel_select-box__value">
                                        <input class="channel_select-box__input" type="radio" id="MT3" value="job_name" name="chModifySearchType" />
                                        <p class="channel_select-box__input-text">직위</p>
                                    </div>
                                    <img class="channel_select-box__icon"
                                        src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon"
                                        aria-hidden="true" />
                                </div>
                                <ul class="channel_select-box__list">
                                    <li>
                                        <label class="channel_select-box__option" for="MT1" aria-hidden="aria-hidden">이름</label>
                                    </li>
                                    <li>
                                        <label class="channel_select-box__option" for="MT2" aria-hidden="aria-hidden">부서</label>
                                    </li>
                                    <li>
                                        <label class="channel_select-box__option" for="MT3" aria-hidden="aria-hidden">직위</label>
                                    </li>
                                </ul>
                            </div>
                            <input type="text" name="chModifyKeyword" id="srchModifyChWord" tabindex="1">
                           	<a href="#" onclick="searchMemberModify();" tabindex="2">
	                           	<img src="${pageContext.request.contextPath}/resources/image/search-icon.png" id="ch-search-icon">
                           	</a>
                            <div class="chDivBtn">
                                <button type="button" class="ch-button" id="ch-delete-button" onclick="deleteChannel();">채널 삭제</button>
                                <button type="submit" class="ch-button">확인</button>
                            </div>
                        </div>
					</form>
				</div>
             </div>
		</div>
</body>
</html>