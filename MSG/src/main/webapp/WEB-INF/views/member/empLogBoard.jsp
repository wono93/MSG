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
    <script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
    <script src='https://kit.fontawesome.com/a076d05399.js'></script>
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
			            <input type='text' id='timepicker-start' class='datepicker-here' data-language='ko' 
			                    data-date-format="yyyy-m-d" autocomplete="off" minutesStep="10"/>
			                    <i class='far fa-calendar-alt starticon' style='font-size:32px'></i>
			            <span>~</span>
			            <input type='text' id='timepicker-end' class='datepicker-here' data-language='ko' 
			                    data-date-format="yyyy-m-d" autocomplete="off" minutesStep="10"/>
			            <i class='far fa-calendar-alt endicon' style='font-size:32px'></i>
			            <h1>총 영업일 20 일</h1>
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
			            <tr onclick="location.href='${pageContext.request.contextPath}/member/select.do'">
			                <td>1</td>
			                <td>기획부</td>
			                <td>선동일</td>
			                <td>15일</td>
			                <td>5일</td>
			                <td>0일</td>
			                <td>0일</td>
			                <td>0일</td>
			            </tr>
			            <tr>
			                <td>2</td>
			                <td>기획부</td>
			                <td><a href="empLog.html">송종기</a></td>
			                <td>20일</td>
			                <td>0일</td>
			                <td><span style="background-color: #f4ca25;border-radius: 50%;padding: 8px 8px;">1일</span></td>
			                <td>0일</td>
			                <td>0일</td>
			            </tr>
			            <tr>
			                <td>3</td>
			                <td>영업부</td>
			                <td>정나라</td>
			                <td>15일</td>
			                <td><span style="background-color: #f4ca25;border-radius: 50%;padding: 8px 8px;">5일</span></td>
			                <td>0일</td>
			                <td>0일</td>
			                <td>0일</td>
			            </tr>
			            <tr>
			                <td>4</td>
			                <td>영업부</td>
			                <td>윤하늘</td>
			                <td>20일</td>
			                <td>0일</td>
			                <td>0일</td>
			                <td>0일</td>
			                <td>0일</td>
			            </tr>
			            <tr>
			                <td>5</td>
			                <td>영업부</td>
			                <td>공무</td>
			                <td>20일</td>
			                <td>0일</td>
			                <td>0일</td>
			                <td>0일</td>
			                <td>0일</td>
			            </tr>
			            </tr>
			            <tr>
			                <td>6</td>
			                <td>IT지원부</td>
			                <td>정공인</td>
			                <td>20일</td>
			                <td>0일</td>
			                <td>0일</td>
			                <td>0일</td>
			                <td>0일</td>
			            </tr>
			            </tr>
			            <tr>
			                <td>7</td>
			                <td>IT지원팀</td>
			                <td>박재성</td>
			                <td>20일</td>
			                <td>0일</td>
			                <td>0일</td>
			                <td>0일</td>
			                <td>0일</td>
			            </tr>
			            </tr>
			            <tr>
			                <td>8</td>
			                <td>인사관리부</td>
			                <td>안고은</td>
			                <td>20일</td>
			                <td>0일</td>
			                <td>0일</td>
			                <td>0일</td>
			                <td>0일</td>
			            </tr>
			            </tr>
			            <tr>
			                <td>9</td>
			                <td>인사관리부</td>
			                <td>이서욱</td>
			                <td>20일</td>
			                <td>0일</td>
			                <td>0일</td>
			                <td>0일</td>
			                <td>0일</td>
			            </tr>
			            </tr>
			            <tr>
			                <td>10</td>
			                <td>인사관리부</td>
			                <td>베성재</td>
			                <td>20일</td>
			                <td>0일</td>
			                <td>0일</td>
			                <td>0일</td>
			                <td>0일</td>
			            </tr>
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
</body>
</html>