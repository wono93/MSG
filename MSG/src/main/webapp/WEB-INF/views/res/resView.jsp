<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
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
                $('.startendicon').click(function(){
                    /* $(this).siblings("input").focus(); */
                    $("#timepicker-startend").focus();
                });
               
            });


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
			                <li onclick="location.href='${pageContext.request.contextPath}/res/view.do'">예약확인</li>
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
			                        <input class="select-box__input" type="radio" id="0" value="1" name="Ben" checked="checked"/>
			                        <p class="select-box__input-text">회의실</p>
			                        </div>
			                        <div class="select-box__value">
			                        <input class="select-box__input" type="radio" id="1" value="2" name="Ben" checked="checked"/>
			                        <p class="select-box__input-text">법인차량</p>
			                        </div>
			                        <div class="select-box__value">
			                        <input class="select-box__input" type="radio" id="2" value="4" name="Ben" checked="checked"/>
			                        <p class="select-box__input-text">전체</p>
			                        </div><img class="select-box__icon" src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon" aria-hidden="true"/>
			                    </div>
			                    <ul class="select-box__list">
			                        <li>
			                        <label class="select-box__option" for="2" aria-hidden="aria-hidden">전체</label>
			                        </li>
			                        <li>
			                        <label class="select-box__option" for="0" aria-hidden="aria-hidden">회의실</label>
			                        </li>
			                        <li>
			                        <label class="select-box__option" for="1" aria-hidden="aria-hidden">법인차량</label>
			                        </li>
			                    </ul>
			                </div>
			            <table id="res-table">
			                    <tr>
			                        <th></th>
			                        <th>구분</th>
			                        <th>대여명</th>
			                        <th>수용인원</th>
			                        <th>대여날짜</th>
			                        <th>대여시간</th>
			                    </tr>
			                    <tr>
			                        <td>1</td>
			                        <td>회의실</td>
			                        <td>A1</td>
			                        <td>6</td>
			                        <td>2020-3-10</td>
			                        <td>15:30 ~ 16:30</td>
			                    </tr>
			                    <tr>
			                        <td>2</td>
			                        <td>회의실</td>
			                        <td>A2</td>
			                        <td>10</td>
			                        <td>2020-3-11</td>
			                        <td>10:00 ~ 10:30</td>
			                    </tr>
			                    <tr>
			                        <td>3</td>
			                        <td>법인차량</td>
			                        <td>아반떼</td>
			                        <td>4</td>
			                        <td>2020-3-11</td>
			                        <td>16:00 ~ 17:30</td>
			                    </tr>
			                    <tr>
			                        <td>4</td>
			                        <td>법인차량</td>
			                        <td>소나타</td>
			                        <td>4</td>
			                        <td>2020-3-11</td>
			                        <td>16:00 ~ 17:30</td>
			                    </tr>
			                    <tr>
			                        <td>5</td>
			                        <td>법인차량</td>
			                        <td>모닝</td>
			                        <td>4</td>
			                        <td>2020-3-11</td>
			                        <td>16:00 ~ 17:30</td>
			                    </tr>
			                    <tr>
			                        <td>6</td>
			                        <td>회의실</td>
			                        <td>C1</td>
			                        <td>4</td>
			                        <td>2020-3-11</td>
			                        <td>16:00 ~ 17:30</td>
			                    </tr>
			                    <tr>
			                        <td>7</td>
			                        <td>회의실</td>
			                        <td>C1</td>
			                        <td>4</td>
			                        <td>2020-3-11</td>
			                        <td>16:00 ~ 17:30</td>
			                    </tr>
			                    <tr>
			                        <td>8</td>
			                        <td>회의실</td>
			                        <td>C1</td>
			                        <td>4</td>
			                        <td>2020-3-11</td>
			                        <td>16:00 ~ 17:30</td>
			                    </tr>
			                    <tr>
			                        <td>9</td>
			                        <td>회의실</td>
			                        <td>C1</td>
			                        <td>4</td>
			                        <td>2020-3-11</td>
			                        <td>16:00 ~ 17:30</td>
			                    </tr>
			                    <tr>
			                        <td>10</td>
			                        <td>회의실</td>
			                        <td>C1</td>
			                        <td>4</td>
			                        <td>2020-3-11</td>
			                        <td>16:00 ~ 17:30</td>
			                    </tr>
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
            </article>
        </div>
    </section>
</body>
</html>