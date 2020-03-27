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
    
    <link href="${pageContext.request.contextPath }/resources/dateTimePicker/dist/css/datepicker.min.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath }/resources/css/reservation.css" rel="stylesheet" type="text/css">
        <script src="${pageContext.request.contextPath }/resources/dateTimePicker/dist/js/datepicker.min.js"></script>
	
        <script src="${pageContext.request.contextPath }/resources/dateTimePicker/dist/js/i18n/datepicker.ko.js"></script>
        <script>
            $(document).ready(function(){
            //아이콘 클릭 시 dateTimePicker focus
            	$('.starticon').click(function(){
                    $('#timepicker-start').focus();
                });
                $('.endicon').click(function(){
                    $('#timepicker-end').focus();
                });
                
                //체크된 회의실코드 input:hidden에 담아주기
                $('input[name="conf"]').click(function () {
                    let radioVal = $('input[name="conf"]:checked').val();
                	$('#croomCode').val(radioVal);
                	console.log($('#croomCode').val());
                });
            });
            
            


            // Initialization
            $('#my-element').datepicker(minutesStep)
            // Access instance of plugin
            $('#my-element').data('datepicker')

            // Create start date
            var start = new Date(),
                prevDay,
                startHours = 9;
        
            // 09:00 AM
            start.setHours(9);
            start.setMinutes(0);
        
            // If today is Saturday or Sunday set 10:00 AM
            if ([6, 0].indexOf(start.getDay()) != -1) {
                start.setHours(10);
                startHours = 10
            }
        
            $('#timepicker-start').datepicker({
                timepicker: true,
                language: 'ko',
                startDate: start,
                minHours: startHours,
                maxHours: 18,
                minutesStep: 30,
                onSelect: function (fd, d, picker) {
                	$(picker.el).trigger('change');
                	
                    // Do nothing if selection was cleared
                    if (!d) return;
                    
                    console.log(fd);
                    console.log(d);
                    console.log(picker);
                    
        
                    var day = d.getDay();
        
                    // Trigger only if date is changed
                    if (prevDay != undefined && prevDay == day) return;
                    prevDay = day;
        
                    // If chosen day is Saturday or Sunday when set
                    // hour value for weekends, else restore defaults
                    if (day == 6 || day == 0) {
                        picker.update({
                            minHours: 10,
                            maxHours: 16
                        })
                    } else {
                        picker.update({
                            minHours: 9,
                            maxHours: 18
                        })
                    }
                }
            
            });
            
            /* function requestCrawling() {
           	 if(e.key == 13){
           	 var 변수명 = $("").attr();
           	 var 변수명 = $(this).val();
           	 }
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
           }
            //ajax-smart 참고
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
        	});
            function requestCrawling2() {
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
        </script>
    <title>MSG :: 회의실 예약</title>
</head>
<style>
.center1200 li:first-of-type{color:#333;}
.saveId-container { display: inline; position: relative; padding-left: 25px; top:7px; left:110px; cursor: pointer; font-size: 20px;}
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
			    	<form action="${pageContext.request.contextPath }/res/confInsert.do" method="post">
				        <input type='text' id='timepicker-start' name='resUsedate' class='datepicker-here' data-language='ko' 
				                data-timepicker="true" data-date-format="yyyy-mm-dd D"  data-time-format="hh:ii"  autocomplete="off"/>
				                <i class='far fa-calendar-alt starticon' style='font-size:32px'></i>
				        <span>~</span>
				        <input type='text' id='timepicker-end' name='resReturndate' class='datepicker-here' data-language='ko' 
				                data-timepicker="true" data-date-format="yyyy-mm-dd D" data-time-format="hh:ii" autocomplete="off" minutesStep="10" />
				                <i class='far fa-calendar-alt endicon' style='font-size:32px'></i>
				        <input type="hidden" name="resUseDate" />
				        <input type="hidden" name="resReturnDate" />
				        <input type="hidden" name="resEnrolldate" />
				        <button id="getreserv"type="submit">예약하기</button>
				        <!-- <button  id="reservTest" onclick="requestAjax()"></button> -->
				        <table id="res-table">
				            <tr>
				                <th></th>
				                <th>회의실명</th>
				                <th>수용인원</th>
				                <th>선택</th>
				            </tr>
				            <c:forEach items="${cList }" var="c" varStatus="vs">
				            	<tr>
				            		<td>${vs.count }</td>
				            		<td>${c.croomName }</td>
				            		<td>${c.croomSize }</td>
				            		<td>
				            			<label class="saveId-container float" for="${c.croomCode }">
				            			<input type="radio" name="conf" id="${c.croomCode }" value="${c.croomCode }"/>
				            			<span class="saveId-checkmark"></span></label>
				            		</td>
				            	</tr>
				            </c:forEach>
				        </table>
				        <input type="hidden" id="croomCode" name="croomCode" />
				     </form>
			    </div>
                </article>
        </div>
    </section>
<script>
	function transform(time){
		var valuee = time.getFullYear().toString()+"-"+((time.getMonth()+1).toString().length==2?(time.getMonth()+1).toString():"0"+(time.getMonth()+1).toString())+"-"+(time.getDate().toString().length==2?time.getDate().toString():"0"+time.getDate().toString())+"T"+(time.getHours().toString().length==2?time.getHours().toString():"0"+time.getHours().toString())+":"+((parseInt(time.getMinutes()/5)*5).toString().length==2?(parseInt(time.getMinutes()/5)*5).toString():"0"+(parseInt(time.getMinutes()/5)*5).toString())+":00";
		return valuee;
		
	}
	//대여시작시간
	$('#timepicker-start').datepicker({
		onSelect: function onSelect (start) {
			
			//start : 2020-03-11 수 00:32
			//use : Wed Mar 11 2020 00:37:00 GMT+0900 (대한민국 표준시)
			
			let use = new Date(start.substr(0,11)+start.substr(13)); 
			console.log(use);
			
			use = transform(use);
			$("[name=resUseDate]").val(use);
			console.log($("[name=resUseDate]").val());
			
			 //date.getMonth() date.getDate()  date.getHours() date.getMinutes()
	    }
	});


	
	//반납시간
	$('#timepicker-end').datepicker({
		onSelect: function onSelect (end){
			
			let retrn = new Date(end.substr(0,11)+end.substr(13));
			console.log(retrn);
			
			retrn = transform(retrn);
			$("[name=resReturnDate]").val(retrn);
			console.log($("[name=resReturnDate]").val());
		}
	});
	
	$(document).ready(function(){
		$("#getreserv").click(function(){
			
			let now = new Date();
			now = transform(now);
			$("[name=resEnrolldate]").val(now);
		});
	});
</script>
</body>
</html>