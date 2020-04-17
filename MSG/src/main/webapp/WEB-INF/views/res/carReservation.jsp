<!DOCTYPE html>
<html lang="en">
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700&display=swap" rel="stylesheet">
    <script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/res_header.js"></script>
    
    <link href="${pageContext.request.contextPath }/resources/dateTimePicker/dist/css/datepicker.min.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath }/resources/css/reservation.css" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath }/resources/dateTimePicker/dist/js/datepicker.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/dateTimePicker/dist/js/i18n/datepicker.ko.js"></script>
     
    <title>MSG :: 차량 예약</title>
</head>
<style>
.center1200 li:nth-of-type(2){color:#333;}
.saveId-container { display: inline; position: relative; padding-left: 25px; top:7px; left:69px; cursor: pointer; font-size: 20px;}

</style>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <section>
        <div>
            <article>
			    <div class="center1200">
			        <h3>예약관리</h3>
			        
			            <ul>
			                <li onclick="location.href='${pageContext.request.contextPath}/res/confRes.do'">회의실</li>
			                <li onclick="location.href='${pageContext.request.contextPath}/res/carRes.do'">법인차량</li>
			                <li onclick="location.href='${pageContext.request.contextPath}/res/myResView.do'">예약확인</li>
			                <%-- <li onclick="location.href='${pageContext.request.contextPath}/res/myResView/'+ ${memberLoggedIn.empNo}+'/'+${memberLoggedIn.isManager}+">예약확인</li> --%>
			            </ul>
			    </div>
			    <div id="whitecontent">
			    	<form action="${pageContext.request.contextPath }/res/carResInsert.do" method="post" id="carResFrm">
				        <input type='text' id='timepicker-start-car' name="resUsedate" class='datepicker-here' data-language='ko' 
				                data-timepicker="true" data-date-format="yyyy-mm-dd D" data-time-format='hh:ii' autocomplete="off" minutesStep="10" placeholder="대여시작날짜/시간"/>
				                <i class='far fa-calendar-alt starticon' style='font-size:32px'></i>
				        <span>~</span>
				        <input type='text' id='timepicker-end-car' name="resReturndate" class='datepicker-here' data-language='ko' 
				                data-timepicker="true" data-date-format="yyyy-mm-dd D" data-time-format='hh:ii' autocomplete="off" minutesStep="10" placeholder="대여반납날짜/시간"/>
				                <i class='far fa-calendar-alt endicon' style='font-size:32px'></i>
				        <input type="hidden" name="resUseDate" />
				        <input type="hidden" name="resReturnDate" />
				        <input type="hidden" name="resEnrolldate" />
				         <input type="hidden" name="empNo" class="empNo" value='${memberLoggedIn.empNo}'/>
				        <input type="hidden" name="isManager" class="isManager" value="${memberLoggedIn.isManager}"/>
				      	<input type="hidden" name="carCode" id="carCode" />
				        <button id="getCarReserv"type="button">예약하기</button>
				        <table class="res-table">
				            <tr>
				                <th></th>
				                <th>카테고리</th>
				                <th>차종</th>
				                <th>차량번호</th>
				                <th>수용인원</th>
				                <th>선택</th>
				            </tr>
				            <c:forEach items="${list }" var="c" varStatus="vs">
				            	<tr class="ajaxHide-tr">
				            		<td>${vs.count }</td>
				            		<td>${c.carCate }</td>
				            		<td>${c.carCompany } / ${c.carType }</td>
				            		<td>${c.carNo }</td>
				            		<td>${c.carSize }</td>
				            		<td>
				            			<label class="saveId-container float" for="${c.carCode }">
				            			<input type="radio" name="car" id="${c.carCode }" value="${c.carCode }" onclick="intoCarCode();"/>
				            			<span class="saveId-checkmark"></span></label>
				            		</td>
				            	</tr> 
				            </c:forEach>
				        </table>
				      <button id="add-car" type="button">법인차량 추가</button>
			          <!-- <button id="update-car" type="button" >수정</button> -->
			          <button id="del-car" type="button">삭제</button>
			         
			          <%-- <c:if test="${memberLoggedIn.isManager eq 'N'}">
			          <div class="notManagerDiv"></div>
			          </c:if> --%>
				    </form>
			    </div>
            </article>
        </div>
    </section>
    <!-- 법인차량 추가 모달 -->
    <div id="addCarModal" class="ch-modal">
       	<div class="ch-modal-content">
                
               <img src="${pageContext.request.contextPath}/resources/image/X-icon.png" alt="" class="x-icon close carClose" id="close-btn">
               <div id="ch-content">
                    <form action="${pageContext.request.contextPath }/res/addCar.do" method="POST" id="addCarFrm"> 

                        <div class="channelGenTitle">
                            <h3>법인차량 추가</h3>
                        </div>
                        <div class="select-box-addCar">
		                    <div class="select-box__current" tabindex="1">
		                    	<div class="select-box__value">
		                        <input class="select-box__input" type="radio" id="CAR1" value="CAR1" name="car-cate_" checked="checked"/>
		                        <p class="select-box__input-text">경차</p>
		                        <div class="select-box__value">
		                        <input class="select-box__input" type="radio" id="CAR2" value="CAR2" name="car-cate_"/>
		                        <p class="select-box__input-text">세단</p>
		                        </div>
		                        <div class="select-box__value">
		                        <input class="select-box__input" type="radio" id="CAR3" value="CAR3" name="car-cate_" />
		                        <p class="select-box__input-text">SUV</p>
		                        </div>
		                         <div class="select-box__value">
		                        <input class="select-box__input" type="radio" id="CAR4" value="CAR4" name="car-cate_" />
		                        <p class="select-box__input-text">픽업트럭</p>
		                        </div>
		                        <div class="select-box__value">
		                        <input class="select-box__input" type="radio" id="none" value="" name="car-cate_" checked="checked"/>
		                        <p class="select-box__input-text">선택</p>
		                        </div>
		                        </div><img class="select-box__icon" src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon" aria-hidden="true"/>
		                    </div>
		                    <ul class="select-box__list">
		                        <li> <label class="select-box__option" for="CAR1" aria-hidden="aria-hidden">경차</label> </li>
		                        <li> <label class="select-box__option" for="CAR2" aria-hidden="aria-hidden">세단</label> </li>
		                        <li> <label class="select-box__option" for="CAR3" aria-hidden="aria-hidden">SUV</label> </li>
		                        <li> <label class="select-box__option" for="CAR4" aria-hidden="aria-hidden">픽업트럭</label> </li>
		                    </ul>
		                </div>
                        <input type="hidden" name="carCate" id="addCar-cate" />
                        <!-- <input type="hidden" name="carCode" id="car-seq"/> -->
                        <input type="text" name="carCompany" id="addCar-company" placeholder="제조사"/>
                        <input type="text" name="carType" id="addCar-type" placeholder="차종"/>
                        <input type="text" name="carNo" id="addCar-no" placeholder="새로운 차량의 차량번호를 입력해주세요."/>
                        <p>
						<div class="updown custom">
							수용인원
							<button type="button" class="minusBtn mLeft50" onclick="minus();">-</button>
							<input type="text" id="person" value="5" name="carSize" readonly="true" />
							<button type="button" class="plusBtn" onclick="plus();">+</button>
						</div>
						</p>
                        <input type="button" id="addBtn" class="doBtn" value="추가하기" onclick="carValidate();"/>
                    </form>
               	</div>
            </div>
     </div>
     <!-- 법인차량 수정 모달 -->
    <div id="updateCarModal" class="ch-modal">
       	<div class="ch-modal-content">
                
               <img src="${pageContext.request.contextPath}/resources/image/X-icon.png" alt="" class="x-icon close" id="close-btn">
               <div id="ch-content">
                    <form action="${pageContext.request.contextPath }/res/updateCar.do" method="POST" id="updateCarFrm"> 

                        <div class="channelGenTitle">
                            <h3>법인차량 수정</h3>
                        </div>
                        <div class="select-box-addCar">
		                    <div class="select-box__current" tabindex="1">
		                        <div class="select-box__value">
		                        <input class="select-box__input" type="radio" id="CAR1" value="CAR1" name="car-cate_" checked="checked"/>
		                        <p class="select-box__input-text">경차</p>
		                        </div>
		                        <div class="select-box__value">
		                        <input class="select-box__input" type="radio" id="CAR2" value="CAR2" name="car-cate_"/>
		                        <p class="select-box__input-text">세단</p>
		                        </div>
		                        <div class="select-box__value">
		                        <input class="select-box__input" type="radio" id="CAR3" value="CAR3" name="car-cate_" />
		                        <p class="select-box__input-text">SUV</p>
		                        </div>
		                         <div class="select-box__value">
		                        <input class="select-box__input" type="radio" id="CAR4" value="CAR4" name="car-cate_" />
		                        <p class="select-box__input-text">픽업트럭</p>
		                        </div>
		                        <div class="select-box__value">
		                        <input class="select-box__input" type="radio" id="" value="" name="car-cate_" checked="checked"/>
		                        <p class="select-box__input-text">선택</p>
		                        </div><img class="select-box__icon" src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon" aria-hidden="true"/>
		                    </div>
		                    <ul class="select-box__list">
		                        <li> <label class="select-box__option" for="CAR1" aria-hidden="aria-hidden">경차</label> </li>
		                        <li> <label class="select-box__option" for="CAR2" aria-hidden="aria-hidden">세단</label> </li>
		                        <li> <label class="select-box__option" for="CAR3" aria-hidden="aria-hidden">SUV</label> </li>
		                        <li> <label class="select-box__option" for="CAR4" aria-hidden="aria-hidden">픽업트럭</label> </li>
		                    </ul>
		                </div>
                        <input type="hidden" name="carCate" id="updateCar-cate" />
                        <input type="hidden" name="carCode" id="updateCar-code" />
                        <input type="text" name="carCompany" id="updateCar-company" placeholder="제조사"/>
                        <input type="text" name="carType" id="updateCar-type" placeholder="차종"/>
                        <input type="text" name="carNo" id="updateCar-no" placeholder="변경할 차량의 차량번호를 입력해주세요."/>
                        <p>
						<div class="updown custom">
							수용인원
							<button type="button" class="minusBtn mLeft50" onclick="minus();">-</button>
							<input type="text" id="person_" value="5" name="carSize" readonly="true" />
							<button type="button" class="plusBtn" onclick="plus();">+</button>
						</div>
						</p>
                        <input type="button" id="updateBtn" class="doBtn" value="수정하기" onclick="carValidate();"/>
                    </form>
               	</div>
            </div>
     </div>
     <script src="${pageContext.request.contextPath }/resources/js/res_footer.js"></script>  
</body>
</html>