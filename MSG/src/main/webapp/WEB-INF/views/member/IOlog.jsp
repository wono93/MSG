<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
    <link href="${pageContext.request.contextPath }/resources/css/empLog.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath }/resources/css/IOlog.css" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/datepicker.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/datepicker.ko.js"></script>
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
    <style>
        

    </style>
    <title>MSG :: 출입기록</title>
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
			            <input type='text' id='timepicker-start' class='datepicker-here' data-language='ko' 
			                    data-date-format="yyyy-m-d" autocomplete="off" minutesStep="10"/>
			                    <i class='far fa-calendar-alt starticon' style='font-size:32px'></i>
			            <span>~</span>
			            <input type='text' id='timepicker-end' class='datepicker-here' data-language='ko' 
			                    data-date-format="yyyy-m-d" autocomplete="off" minutesStep="10"/>
			            <i class='far fa-calendar-alt endicon' style='font-size:32px'></i>
			        </div>
			        <hr class="boardHr" />
			        <div class="logView">
			            <ol>
			                <li>2020-03-14:08:59:1 @ 168.0.1.1 by 송종기 (IN)</li>
			                <li>2020-03-14:08:59:2 @ 168.0.1.2 by 선동일 (IN)</li>
			                <li>2020-03-14:08:59:3 @ 168.0.1.3 by 정나라 (IN)</li>
			                <li>2020-03-14:08:59:4 @ 168.0.1.4 by 윤하늘 (IN)</li>
			                <li>2020-03-14:08:59:5 @ 168.0.1.5 by 공휴진 (IN)</li>
			                <li>2020-03-14:08:59:6 @ 168.0.1.6 by 장동진 (IN)</li>
			                <li>2020-03-14:08:59:7 @ 168.0.1.7 by 박부검 (IN)</li>
			                <li>2020-03-14:08:59:8 @ 168.0.1.8 by 정해일 (IN)</li>
			                <li>2020-03-14:08:59:9 @ 168.0.1.9 by 박해진 (IN)</li>
			                <li>2020-03-14:08:59:10 @ 168.0.1.10 by 조성우 (OUT)</li>
			                <li>2020-03-14:08:59:11 @ 168.0.1.11 by 송종기 (OUT)</li>
			                <li>2020-03-14:08:59:12 @ 168.0.1.12 by 선동일 (OUT)</li>
			                <li>2020-03-14:08:59:13 @ 168.0.1.13 by 정나라 (OUT)</li>
			                <li>2020-03-14:08:59:14 @ 168.0.1.14 by 윤하늘 (OUT)</li>
			                <li>2020-03-14:08:59:15 @ 168.0.1.15 by 장동진 (OUT)</li>
			                <li>2020-03-14:08:59:16 @ 168.0.1.16 by 박부검 (OUT)</li>
			                <li>2020-03-14:08:59:17 @ 168.0.1.17 by 정해일 (OUT)</li>
			                <li>2020-03-14:08:59:18 @ 168.0.1.18 by 박해진 (OUT)</li>
			                <li>2020-03-14:18:59:19 @ 168.0.1.19 by 조성우 (IN)</li>
			                <li>2020-03-14:18:59:20 @ 168.0.1.20 by 송종기 (IN)</li>
			                <li>2020-03-14:18:59:21 @ 168.0.1.21 by 선동일 (IN)</li>
			                <li>2020-03-14:18:59:22 @ 168.0.1.22 by 정나라 (IN)</li>
			                <li>2020-03-14:18:59:23 @ 168.0.1.23 by 윤하늘 (IN)</li>
			                <li>2020-03-14:18:59:24 @ 168.0.1.24 by 장동진 (IN)</li>
			                <li>2020-03-14:18:59:25 @ 168.0.1.25 by 박부검 (IN)</li>
			                <li>2020-03-14:18:59:26 @ 168.0.1.26 by 정해일 (IN)</li>
			                <li>2020-03-14:18:59:27 @ 168.0.1.27 by 박해진 (IN)</li>
			                <li>2020-03-14:18:59:28 @ 168.0.1.28 by 조성우 (IN)</li>
			            </ol>
			            <div class="srchBar">
			                <div class="select-box">
			                    <div class="select-box__current" tabindex="1">
			                        <div class="select-box__value">
			                            <input class="select-box__input" type="radio" id="3" value="4" name="Ben"
			                                checked="checked" />
			                            <p class="select-box__input-text">이름</p>
			                        </div><img class="select-box__icon"
			                            src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon"
			                            aria-hidden="true" />
			                    </div>
			                    <ul class="select-box__list">
			                        <li>
			                            <label class="select-box__option" for="3" aria-hidden="aria-hidden">이름</label>
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
</body>
</html>