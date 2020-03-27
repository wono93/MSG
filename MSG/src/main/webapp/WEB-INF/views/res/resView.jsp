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
    
    <link href="${pageContext.request.contextPath }/resources/dateTimePicker/dist/css/datepicker.min.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath }/resources/css/reservation.css" rel="stylesheet" type="text/css">
        <script src="${pageContext.request.contextPath }/resources/dateTimePicker/dist/js/datepicker.min.js"></script>
        <script src="${pageContext.request.contextPath }/resources/dateTimePicker/dist/js/i18n/datepicker.ko.js"></script>
        <script>
            //아이콘 클릭 시 dateTimePicker focus
            $(function(){
                $('.startendicon').click(function(){
                    $("#timepicker-startend").focus();
                });
                
                //기본상태 : 회의실예약내역 + 차량예약내역
                $.ajax({
                	
                });
            });    
                
                $('#0').click(function(){
                	
                
		           	$.ajax({
		           			url:"${pageContext.request.contextPath}/crawling/crawlingTest1.do",	
		           	
		           			dataType : "json",
		           			data: { 데이터키 : 변수명},
		           			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
		           			success : data => {
		           				console.log(data);
		           				$table= $("#tableCL1");
		            				$.each(data, function(idx, value){					
		           					$tr = $("<tr></tr>");
		           					$td = $tr.append("<td>"+idx+"</td><td>"+value+"</td>");	
		           					$table.append($td);				
		           					console.log(idx);
		           					console.log(value);
		           					
		           					
		           				});
		            				
		           			},
		           			error : (x, s, e) => {
		           				//x : xhr
		           				//s : textStatus
		           				//e : errorThrown
		           				console.log("error");
		
		           			}			 
		           	});
		           
            });
           /*  //ajax-smart 참고
            $("#reservTest").click(function(){
        		console.log("테스트중입니다");
        		let reservation = {
        			resUsedate :$("#timepicker-start").val(),
        			resReturndate : $("#timepicker-end").val(),
        		}
        		$.ajax({
        			url:"${pageContext.request.contextPath}/res/test.do",
        			data:reservation,
        			dataType:"text",
        			success:data=>{
        				console.log(data);
        			},
        			error:(x,s,e)=>{
        				console.log(x,s,e);
        			}
        		});
        	}); */
            /* function requestCrawling2() {
           	$.ajax({
           			url:"${pageContext.request.contextPath}/res/test.do",	
           			dataType : "json",
           			method: "post",
           			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
           			success : data => {
           				console.log(data);
           				$table= $("#tableCL2");
            				$.each(data, function(idx, value){
           					console.log(idx);
           					console.log(value);
           					console.log(value.contentsName);
            					
           					$tr = $("<tr></tr>");
           					$td = $tr.append("<td>"+idx+"</td><td>"+value.contentsName+"</td>"+"<td><a href="+value.contentsHref+">"+value.contentsName+"</a></td>");	
           					$table.append($td);				
           					
           					
           				});
           				
           				
           				 
           			},
           			error : (x, s, e) => {
           				//x : xhr
           				//s : textStatus
           				//e : errorThrown
           				console.log("error");

           			}			 
           	});
           } */


            // Initialization
            $('#my-element').datepicker()
            // Access instance of plugin
            $('#my-element').data('datepicker')

        </script>
    <title>MSG :: 예약확인</title>
</head>
<style>

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
			                <%-- memberLoggedIn 의 관리자 여부에 따라 동작하는 controller method 다르게 할거임
			                <c:if test="${Integer.parseInt(param.num1) > Integer.parseInt(param.num2) }">
							<p>${Integer.parseInt(param.num1) }이 ${Integer.parseInt(param.num2) }보다 큽니다</p>
							</c:if> --%>
			                <li onclick="location.href='${pageContext.request.contextPath}/res/myResView.do'">예약확인</li>
			             </ul>
			    </div>
			    <div id="whitecontent">
			        <input type="text" data-range="true" data-multiple-dates-separator=" ~ " data-date-format="yyyy-m-d D"
			    			data-language="ko" id='timepicker-startend' class="datepicker-here"/>
			                <i class='far fa-calendar-alt startendicon' style='font-size:32px'></i>
			        
			        <div class="srchBar">
			                <div class="select-box">
			                    <div class="select-box__current" tabindex="1">
			                        <div class="select-box__value">
			                        <input class="select-box__input" type="radio" id="cconf" value="1" name="Ben" checked="checked"/>
			                        <p class="select-box__input-text">회의실</p>
			                        </div>
			                        <div class="select-box__value">
			                        <input class="select-box__input" type="radio" id="ccar" value="2" name="Ben" checked="checked"/>
			                        <p class="select-box__input-text">법인차량</p>
			                        </div>
			                        <div class="select-box__value">
			                        <input class="select-box__input" type="radio" id="wwhole" value="4" name="Ben" checked="checked"/>
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
			                <div>
				           		<table id="res-table">
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
				                    	<tr>
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
				                    		<c:set var="d" value="${r.howLong/60/24 }"/>
				                    		<fmt:parseNumber var="day" integerOnly="true" value="${d }"/>
				                    		<%-- <c:set var="h" value="${(r.howLong-d*60*24)/60 }"/> --%>
				                    		<c:set var="h" value="${(r.howLong)/60 }"/>
				                    		<fmt:parseNumber var="hour" integerOnly="true" value="${h }"/>
				                    		<%-- <c:set var="m" value="${r.howLong-d*60*24-h*60 }"/> --%>
				                    		<c:set var="m" value="${r.howLong }"/>
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
    <script>
    function hL(i){
    	i = parseInt(i);
    	return i;
    };
    </script>
</body>
</html>