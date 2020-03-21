<!DOCTYPE html>
<html lang="en">
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700&display=swap" rel="stylesheet">
    <script src="${pageContext.request.contextPath }/resources/dateTimePicker/dist/js/jquery-3.4.1.js"></script>
    <script src='https://kit.fontawesome.com/a076d05399.js'></script>
    <link href="${pageContext.request.contextPath }/resources/dateTimePicker/dist/css/datepicker.min.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath }/resources/css/reservation.css" rel="stylesheet" type="text/css">
        <script src="${pageContext.request.contextPath }/resources/dateTimePicker/dist/js/datepicker.min.js"></script>
	
        <script src="${pageContext.request.contextPath }/resources/dateTimePicker/dist/js/i18n/datepicker.ko.js"></script>
        <script>
            //아이콘 클릭 시 dateTimePicker focus
            $(function(){
                $('.starticon').click(function(){
                    $('#timepicker-start').focus();
                });
                $('.endicon').click(function(){
                    $('#timepicker-end').focus();
                });
            });


            // Initialization
            $('#my-element').datepicker()
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
        
            $('#timepicker-actions-exmpl').datepicker({
                timepicker: true,
                language: 'en',
                startDate: start,
                minHours: startHours,
                maxHours: 18,
                onSelect: function (fd, d, picker) {
                    // Do nothing if selection was cleared
                    if (!d) return;
        
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
            })
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
			                <li onclick="location.href='${pageContext.request.contextPath}/res/view.do'">예약확인</li>
			             </ul>
			    </div>
			    <div id="whitecontent">
			        <input type='text' id='timepicker-start' class='datepicker-here' data-language='ko' 
			                data-timepicker="true" data-date-format="yyyy-m-d D" data-time-format='hh:ii AA' autocomplete="off" minutesStep="10"/>
			                <i class='far fa-calendar-alt starticon' style='font-size:32px'></i>
			        <span>~</span>
			        <input type='text' id='timepicker-end' class='datepicker-here' data-language='ko' 
			                data-timepicker="true" data-date-format="yyyy-m-d D" data-time-format='hh:ii AA' autocomplete="off" minutesStep="10"/>
			                <i class='far fa-calendar-alt endicon' style='font-size:32px'></i>
			        <button id="getreserv"type="submit">예약하기</button>
			        <table id="res-table">
			            <tr>
			                <th></th>
			                <th>회의실명</th>
			                <th>수용인원</th>
			                <th>선택</th>
			            </tr>
			            <tr>
			                <td>1</td>
			                <td>A1</td>
			                <td>6</td>
			                <td>
			                    <label class="saveId-container float" for="one">
			                    <input type="radio" name="conf" id="one">
			                    <span class="saveId-checkmark"></span>
			       </label></td>
			            </tr>
			            <tr>
			                <td>2</td>
			                <td>A2</td>
			                <td>10</td>
			                <td>
			                        <label class="saveId-container float" for="two">
			                        <input type="radio" name="conf" id="two">
			                        <span class="saveId-checkmark"></span>
			                </td>
			            </tr>
			            <tr>
			                <td>3</td>
			                <td>B1</td>
			                <td>8</td>
			                <td>
			                        <label class="saveId-container float" for="three">
			                        <input type="radio" name="conf" id="three">
			                        <span class="saveId-checkmark"></span>
			                </td>
			            </tr>
			            <tr>
			                <td>4</td>
			                <td>B2</td>
			                <td>10</td>
			                <td>
			                    <label class="saveId-container float" for="four">
			                    <input type="radio" name="conf" id="four">
			                    <span class="saveId-checkmark"></span>
			                </td>
			            </tr>
			            <tr>
			                <td>5</td>
			                <td>C1</td>
			                <td>4</td>
			                <td>
			                        <label class="saveId-container float" for="five">
			                        <input type="radio" name="conf" id="five">
			                         <span class="saveId-checkmark"></span>
			                </td>
			            </tr>
			            <tr>
			                <td>6</td>
			                <td>C1</td>
			                <td>4</td>
			                <td>
			                        <label class="saveId-container float" for="six">
			                        <input type="radio" name="conf" id="six">
			                        <span class="saveId-checkmark"></span>
			                </td>
			            </tr>
			            <tr>
			                <td>7</td>
			                <td>C1</td>
			                <td>4</td>
			                <td>
			                        <label class="saveId-container float" for="seven">
			                        <input type="radio" name="conf" id="seven">
			                        <span class="saveId-checkmark"></span>
			                </td>
			            </tr>
			            <tr>
			                <td>8</td>
			                <td>C1</td>
			                <td>4</td>
			                <td>
			                        <label class="saveId-container float" for="eight">
			                        <input type="radio" name="conf" id="eight">
			                        <span class="saveId-checkmark"></span>
			                </td>
			            </tr>
			            <tr>
			                <td>9</td>
			                <td>C1</td>
			                <td>4</td>
			                <td>
			                        <label class="saveId-container float" for="nine">
			                        <input type="radio" name="conf" id="nine">
			                        <span class="saveId-checkmark"></span>
			                </td>
			            </tr>
			            <tr>
			                <td>10</td>
			                <td>C1</td>
			                <td>4</td>
			                <td>
			                        <label class="saveId-container float" for="ten">
			                        <input type="radio" name="conf" id="ten">
			                        <span class="saveId-checkmark"></span>
			                </td>
			            </tr>
			        </table>
			    </div>
                </article>
        </div>
    </section>
</body>
</html>