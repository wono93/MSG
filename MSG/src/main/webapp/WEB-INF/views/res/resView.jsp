<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700&display=swap" rel="stylesheet">
    <script src="${pageContext.request.contextPath }/resources/dateTimePicker/dist/js/jquery-3.4.1.js"></script>
    <script src="${pageContext.request.contextPath }/resources/dateTimePicker/dist/js/datepicker.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/dateTimePicker/dist/js/i18n/datepicker.ko.js"></script>
    <script src="${pageContext.request.contextPath }/resources/contextMenu/dist/jquery.ui.position.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/contextMenu/dist/jquery.contextMenu.min.js"></script>
    
    <link href="${pageContext.request.contextPath }/resources/dateTimePicker/dist/css/datepicker.min.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath }/resources/contextMenu/dist/jquery.contextMenu.min.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath }/resources/css/reservation.css" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath }/resources/js/res_header.js"></script>
    <title>MSG :: 예약확인</title>
</head>
<style>
.center1200 li:nth-of-type(3){color:#333;}
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
			             </ul>
			    </div>
			    <div id="whitecontent">
			        <input type="text" data-range="true" data-multiple-dates-separator=" ~ " data-date-format="yyyy-mm-dd D"
			    			name="srchDate"
			    			data-language="ko" id='timepicker-startend' class="datepicker-here"/>
	                <i class='far fa-calendar-alt startendicon' style='font-size:32px'></i>
			        
			        
			        <div class="srchBar">
			                <div class="select-box">
			                    <div class="select-box__current" tabindex="1">
			                        <div class="select-box__value">
			                        <input class="select-box__input" type="radio" id="cconf" value="1" name="cate"/>
			                        <p class="select-box__input-text">회의실</p>
			                        </div>
			                        <div class="select-box__value">
			                        <input class="select-box__input" type="radio" id="ccar" value="2" name="cate" />
			                        <p class="select-box__input-text">법인차량</p>
			                        </div>
			                        <div class="select-box__value">
			                        <input class="select-box__input" type="radio" id="wwhole" value="4" name="cate" checked="checked"/>
			                        <p class="select-box__input-text">전체</p>
			                        </div><img class="select-box__icon" src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon" aria-hidden="true"/>
			                    </div>
			                    <ul class="select-box__list">
			                        <li>
			                        <label class="select-box__option" for="wwhole" aria-hidden="aria-hidden">전체</label>
			                        </li>
			                        <li>
			                        <label class="select-box__option" for="cconf" aria-hidden="aria-hidden">회의실</label>
			                        </li>
			                        <li>
			                        <label class="select-box__option" for="ccar" aria-hidden="aria-hidden">법인차량</label>
			                        </li>
			                    </ul>
			                </div>
			                <div id="rList-div" class="haveNoRes">
				           		<table class="res-table all-res">
				                    <tr>
				                        <th class="narrow-td"></th>
				                        <th>구분</th>
				                        <th>대여명</th>
				                        <th class="narrow-td">수용</th>
				                        <th>대여시간</th>
				                        <th class="wide-td">대여시작</th>
				                        <th class="wide-td">대여종료</th>
				                    </tr>
				                    <c:forEach items="${rList }" var="r" varStatus="vs">
				                    	<tr class="ajaxHide-tr">
				                    		<td class="narrow-td">${vs.count }</td>
				                    		<%-- <c:if test="${Integer.parseInt(param.num1) > Integer.parseInt(param.num2) }"> --%>
				                    		<c:if test="${fn:contains({r.thingCode},'CONF') }">
											<td>회의실</td>
											</c:if>
				                    		<c:if test="${fn:contains({r.thingCode},'CAR') }">
											<td>법인차량</td>
											</c:if>
				                    		<td>${r.thingName }</td>
				                    		<td class="narrow-td">${r.thingSize }</td>
				                    		<c:set var="d" value="${r.howLong / 60 / 24 }"/>
				                    		<fmt:parseNumber var="day" integerOnly="true" value="${d }"/>
				                    		<c:set var="h" value="${(r.howLong) / 60 % 24 }"/>
				                    		<fmt:parseNumber var="hour" integerOnly="true" value="${h }"/>
				                    		<c:set var="m" value="${r.howLong % 60 }"/>
				                    		<fmt:parseNumber var="min" integerOnly="true" value="${m }"/>
				                    		<td>
				                    			<c:if test="${day > 0 }">${day }일 
				                    			</c:if>
				                    			<c:if test="${hour > 0 }">${hour }시간 
				                    			</c:if>
				                    			<c:if test="${min > 0 }">${min }분
				                    			</c:if>
				                    		</td>
				                    		<td class="wide-td"><fmt:formatDate value="${r.resUseDate }" type="both" pattern="yyyy-MM-dd (E) HH : mm"/></td>
				                    		<td class="wide-td"><fmt:formatDate value="${r.resReturnDate }" type="both" pattern="yyyy-MM-dd (E) HH : mm"/></td>
				                    		<td class="displayNone">${r.thingCode }</td>
				                    	</tr>
				                    </c:forEach>
					            </table>
					            <div class="pagingg">
					                <div class="pagination">
					                    <a href="#" class="arrow">&laquo;</a>
					                    <a href="#">1</a>
					                    <a href="#" class="active">2</a>
					                    <a href="#">3</a>
					                    <a href="#">4</a>
					                    <a href="#">5</a>
					                    <a href="#" class="arrow">&raquo;</a>
					                </div>        
					            </div>
					        </div>
					         <div id="confList-div" class="haveNoRes">
				           		<table class="res-table conf-res">
				                    <tr>
				                        <th class="narrow-td"></th>
				                        <th>구분</th>
				                        <th>대여명</th>
				                        <th class="narrow-td">수용</th>
				                        <th>대여시간</th>
				                        <th class="wide-td">대여시작</th>
				                        <th class="wide-td">대여종료</th>
				                    </tr>
				                    <c:forEach items="${confList }" var="c" varStatus="vs">
				                    	<tr class="ajaxHide-tr">
				                    		<td class="narrow-td">${vs.count }</td>
											<td>회의실</td>
				                    		<td>${c.thingName }</td>
				                    		<td class="narrow-td">${c.thingSize }</td>
				                    		<c:set var="d" value="${c.howLong/60/24 }"/>
				                    		<fmt:parseNumber var="day" integerOnly="true" value="${d }"/>
				                    		<c:set var="h" value="${(c.howLong) / 60 % 24 }"/>
				                    		<fmt:parseNumber var="hour" integerOnly="true" value="${h }"/>
				                    		<c:set var="m" value="${c.howLong % 60 }"/>
				                    		<fmt:parseNumber var="min" integerOnly="true" value="${m }"/>
				                    		<td>
				                    			<c:if test="${day > 0 }">${day }일 
				                    			</c:if>
				                    			<c:if test="${hour > 0 }">${hour }시간 
				                    			</c:if>
				                    			<c:if test="${min > 0 }">${min }분
				                    			</c:if>
				                    		</td>
				                    		<td class="wide-td"><fmt:formatDate value="${c.resUseDate }" type="both" pattern="yyyy-MM-dd (E) HH : mm"/></td>
				                    		<td class="wide-td"><fmt:formatDate value="${c.resReturnDate }" type="both" pattern="yyyy-MM-dd (E) HH : mm"/></td>
				                    		<td class="displayNone">${c.thingCode }</td>
				                    	</tr>
				                    </c:forEach>
					            </table>
					            <div class="pagingg">
					                <div class="pagination">
					                    <a href="#" class="arrow">&laquo;</a>
					                    <a href="#">1</a>
					                    <a href="#" class="active">2</a>
					                    <a href="#">3</a>
					                    <a href="#">4</a>
					                    <a href="#">5</a>
					                    <a href="#" class="arrow">&raquo;</a>
					                </div>        
					            </div>
					        </div>
					         <div id="carList-div" class="haveNoRes">
				           		<table class="res-table car-res">
				                    <tr>
				                        <th class="narrow-td"></th>
				                        <th>구분</th>
				                        <th>대여명</th>
				                        <th class="narrow-td">수용</th>
				                        <th>대여시간</th>
				                        <th class="wide-td">대여시작</th>
				                        <th class="wide-td">대여종료</th>
				                    </tr>
				                    <c:forEach items="${carList }" var="r" varStatus="vs">
				                    	<tr class="ajaxHide-tr">
				                    		<td class="narrow-td">${vs.count }</td>
											<td>법인차량</td>
				                    		<td>${r.thingName }</td>
				                    		<td class="narrow-td">${r.thingSize }</td>
				                    		<c:set var="d" value="${r.howLong/60/24 }"/>
				                    		<fmt:parseNumber var="day" integerOnly="true" value="${d }"/>
				                    		<c:set var="h" value="${(r.howLong) / 60 % 24 }"/>
				                    		<fmt:parseNumber var="hour" integerOnly="true" value="${h }"/>
				                    		<c:set var="m" value="${r.howLong % 60 }"/>
				                    		<fmt:parseNumber var="min" integerOnly="true" value="${m }"/>
				                    		<td>
				                    			<c:if test="${day > 0 }">${day }일 
				                    			</c:if>
				                    			<c:if test="${hour > 0 }">${hour }시간 
				                    			</c:if>
				                    			<c:if test="${min > 0 }">${min }분
				                    			</c:if>
				                    		</td>
				                    		<td class="wide-td resUseDate"><fmt:formatDate value="${r.resUseDate }" type="both" pattern="yyyy-MM-dd (E) HH : mm"/></td>
				                    		<td class="wide-td resReturnDate"><fmt:formatDate value="${r.resReturnDate }" type="both" pattern="yyyy-MM-dd (E) HH : mm"/></td>
				                    		<td class="displayNone">${r.thingCode }</td>
				                    	</tr>
				                    </c:forEach>
					            </table>
					            <div class="pagingg">
					                <div class="pagination">
					                    <a href="#" class="arrow">&laquo;</a>
					                    <a href="#">1</a>
					                    <a href="#" class="active">2</a>
					                    <a href="#">3</a>
					                    <a href="#">4</a>
					                    <a href="#">5</a>
					                    <a href="#" class="arrow">&raquo;</a>
					                </div>        
					            </div>
					        </div>
			    	</div>
			    </div>
            </article>
        </div>
    </section>
    
    <script src="${pageContext.request.contextPath }/resources/js/res_footer.js"></script>
    <script>
    
    
	
	
	 $(document).ready(function(){
		
		 //어우씨,, 대여시작 == 대여종료면 대여종료에서 0000-00-00 (금) 빼기 실패쓰
         /* var eTime = $(".resReturnDate");   //.text() : 2020-03-31 (화) 14 : 15
         var eTimeSibling = eTime.prev();
         var sTime = $(".resUseDate");  //.text() : 2020-04-09 (목) 14 : 50
         
         console.log(eTime.html().substr(0,10));
         console.log(eTimeSibling.html().substr(0,10));
         console.log(sTime.html().substr(0,10));
         
         
         if(eTimeSibling.text().substr(0,10) == sTime.text().substr(0,10)){
      	   eTime.html(eTime.html().substr(16));
         } 
          */
         
	 });
    </script>
</body>
</html>