<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath }/resources/css/datepicker.min.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath }/resources/css/select_box.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath }/resources/css/paging.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath }/resources/css/hrBoard.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath }/resources/css/timepicker.custom.css" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/datepicker.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/datepicker.ko.js"></script>
    
    <style>
        

    </style>
    <title>MSG :: 근태 관리</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<section>
		<div>
			<article>
                <div class="subNav">
                    <h3>인사관리</h3>
                    <ul>
                        <li onclick="location.href='${pageContext.request.contextPath}/member/list.do'">근태관리</li>
                        <li onclick="location.href='${pageContext.request.contextPath}/member/io.do'">출입기록</li>
                        <li onclick="location.href='${pageContext.request.contextPath}/member/org.do'">조직도</li>
	                    <li onclick="location.href='${pageContext.request.contextPath}/leave/update.do'">휴가관리</li>
                        <li onclick="location.href='${pageContext.request.contextPath}/leave/list.do'">휴가내역</li>
                     </ul>
                </div>
			    <div class="content">
			        <div class="control">
			            <h2>조회날짜</h2>
			            <input type='text' id='timepicker-start' name="src-date-start" class='datepicker-here' data-language='ko' 
			                    data-date-format="yyyy-mm-dd" autocomplete="off"/>
			                    <i class='far fa-calendar-alt starticon' style='font-size:32px'></i>
			            <span>~</span>
			            <input type='text' id='timepicker-end' name="src-date-end" class='datepicker-here' data-language='ko' 
			                    data-date-format="yyyy-mm-dd" autocomplete="off" />
			            <i class='far fa-calendar-alt endicon' style='font-size:32px'></i>
			            <h1>총 영업일  ${bsnsDay } 일</h1>
			        </div>
			        <table class="board">
			            <tr>
			                <th></th>
			                <th>부서</th>
			                <th>이름</th>
			                <th>출근일</th>
			                <th>휴가</th>
			                <th>지각</th>
			                <th>결근</th>
			                <th>조퇴</th>
			            </tr>
			            <c:forEach items="${list }" var="hr" varStatus="vs">
				            <tr onclick="location.href='${pageContext.request.contextPath}/member/select.do'">
				                <td>${vs.count }</td>
				                <td>${hr.deptName }</td>
				                <td>${hr.empName }</td>
				                <td>${bsnsDay - hr.vctnCount }</td>
				                <td>${hr.vctnCount }일</td>
				                <td>${hr.lateCount }일</td>
				                <td>${hr.absentCount }일</td>
				                <td>${hr.leaveCount }일</td>
				            </tr>
			            </c:forEach>
			        </table>
			        <div class="pagination">
			            <a href="emp_info.html" class="arrow">&laquo;</a>
			            <a href="emp_info.html">1</a>
			            <a href="emp_info.html" class="active">2</a>
			            <a href="emp_info.html">3</a>
			            <a href="emp_info.html">4</a>
			            <a href="emp_info.html">5</a>
			            <a href="emp_info.html" class="arrow">&raquo;</a>
			        </div>
			        <div class="srchBar">
			            <div class="select-box">
			                <div class="select-box__current" tabindex="1">
			                    <div class="select-box__value">
			                        <input class="select-box__input" type="radio" id="1" value="1" name="Ben"
			                            checked="checked" />
			                        <p class="select-box__input-text">전체</p>
			                    </div>
			                    <div class="select-box__value">
			                        <input class="select-box__input" type="radio" id="2" value="2" name="Ben"
			                            />
			                        <p class="select-box__input-text">부서</p>
			                    </div>
			                    <div class="select-box__value">
			                        <input class="select-box__input" type="radio" id="3" value="3" name="Ben"
			                            />
			                        <p class="select-box__input-text">직위</p>
			                    </div>
			                    <div class="select-box__value">
			                        <input class="select-box__input" type="radio" id="4" value="4" name="Ben"
			                            />
			                        <p class="select-box__input-text">사번</p>
			                    </div><img class="select-box__icon"
			                        src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon"
			                        aria-hidden="true" />
			                </div>
			                <ul class="select-box__list">
			                    <li>
			                        <label class="select-box__option" for="1" aria-hidden="aria-hidden">전체</label>
			                    </li>
			                    <li>
			                        <label class="select-box__option" for="2" aria-hidden="aria-hidden">부서</label>
			                    </li>
			                    <li>
			                        <label class="select-box__option" for="3" aria-hidden="aria-hidden">직위</label>
			                    </li>
			                    <li>
			                        <label class="select-box__option" for="4" aria-hidden="aria-hidden">사번</label>
			                    </li>
			                </ul>
			            </div>
			            <input type="text" name="" id="srchWord">
			            <button type="button" name="" id="srchBtn" class="yellowBtn"><i class="fas fa-search"
			                    style="font-size:15px"></i> 검색</button>
			        </div>
			        
			    </div>
			
			</article>
		</div>	
	</section>
	<script>
		//광역변수 선언
	    let startDate;
	    let endDate; 
	    
        //아이콘 클릭 시 dateTimePicker focus
		$( document ).ready(function(){
	        
            $('.starticon').click(function(){
                $('#timepicker-start').focus();
            });
            $('.endicon').click(function(){
                $('#timepicker-end').focus();
            });
            
            $("#timepicker-start").val("${srcDateStart}");
            $("#timepicker-end").val("${srcDateEnd}");
        });

        
        $("#timepicker-start").datepicker({
        	onSelect: function onSelect(start){
       		 	startDate = start;
        		if(startDate !== undefined && endDate !== undefined){
        			validate(startDate,endDate);
        		}
        	},
        	maxDate: new Date()
        });
        $("#timepicker-end").datepicker({
        	onSelect: function onSelect(end){
        		endDate = end;
        		if(startDate !== undefined && endDate !== undefined){
        			validate(startDate,endDate);
        		}
        	},
        	maxDate: new Date()
        });
        
        //날짜로 변환
        function toDate(strDate){
        	var y = strDate.substr(0, 4);
   		    var m = strDate.substr(5, 2);
   		    var d = strDate.substr(8, 2);
   		    
   		 	return new Date(y,m-1,d);
        }
        
        //유효성검사
        function validate(startDate,endDate){
        	var dstartDate = toDate(startDate);
        	var dendDate = toDate(endDate);
        	
        	//검색하고자 하는 시작날짜가 종료날짜보다 나중인 경우
        	if (+dstartDate > +dendDate){
        		alert("날짜를 다시 지정해주세요");
        	}else{
        		var bsnsDay = calcDate(dstartDate,dendDate);
        		location.href="${pageContext.request.contextPath}/member/empLogList.do?startDate="+startDate+
        				"&endDate="+endDate+
        				"&bsnsDay="+bsnsDay;
        	}
        }
        
        function calcDate(date1,date2) {
          /*   var date1 = new Date(2017, 10, 30); // 2017-11-30
            var date2 = new Date(2017, 11, 6); // 2017-12-6 */

            var count = 0;

	        while(true) {  
	            var temp_date = date1;
	            if(temp_date.getTime() > date2.getTime()) {
	                alert("count : " + count);
	                break;
	            } else {
	                var tmp = temp_date.getDay();
	                if(tmp == 0 || tmp == 6) {
	                    // 주말
	                    console.log("주말");
	                } else {
	                    // 평일
	                    console.log("평일");
	                    count++;         
	                }
	                temp_date.setDate(date1.getDate() + 1); 
	            }
	        }
	        return count;
        }
        
    </script>
</body>
</html>