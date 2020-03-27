<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/select_box.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/paging.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/hrBoard.css" type="text/css">
    <script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/listForm.js"></script>
    <title>인사 조직도</title>
</head>
<title>조직도</title>
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
			        <table class="board">
			            <tr>
			                <th></th>
			                <th>부서</th>
			                <th>사번</th>
			                <th>이름</th>
			                <th>아이디</th>
			                <th>직위</th>
			            </tr>
			            <tr>
			                <td>1</td>
			                <td><a href="#">기획부</a></td>
			                <td><a href="emp_info.html">101</a></td>
			                <td><a href="emp_info.html">선동일</a></td>
			                <td><a href="emp_info.html">sundong</a></td>
			                <td>대표</td>
			            </tr>
			            <tr>
			                <td>2</td>
			                <td><a href="#">기획부</a></td>
			                <td><a href="emp_info.html">102</a></td>
			                <td><a href="emp_info(hr).html">송종일</a></td>
			                <td><a href="emp_info.html">songji</a></td>
			                <td>과장</td>
			            </tr>
			            <tr>
			                <td>3</td>
			                <td><a href="#">영업부</a></td>
			                <td><a href="emp_info.html">103</a></td>
			                <td><a href="emp_info.html">정나라</a></td>
			                <td><a href="emp_info.html">jeongna</a></td>
			                <td>부장</td>
			            </tr>
			            <tr>
			                <td>4</td>
			                <td><a href="#">영업부</a></td>
			                <td><a href="emp_info.html">104</a></td>
			                <td><a href="emp_info.html">윤하늘</a></td>
			                <td><a href="emp_info.html">yungha</a></td>
			                <td>대리</td>
			            </tr>
			            <tr>
			                <td>5</td>
			                <td><a href="#">영업부</a></td>
			                <td><a href="emp_info.html">105</a></td>
			                <td><a href="emp_info.html">공휴진</a></td>
			                <td><a href="emp_info.html">gonghue</a></td>
			                <td>대리</td>
			            </tr>
			            <tr>
			                <td>6</td>
			                <td><a href="#">IT지원팀</a></td>
			                <td><a href="emp_info.html">106</a></td>
			                <td><a href="emp_info.html">장동진</a></td>
			                <td><a href="emp_info.html">jangdong</a></td>
			                <td>부장</td>
			            </tr>
			            <tr>
			                <td>7</td>
			                <td><a href="#">IT지원팀</a></td>
			                <td><a href="emp_info.html">107</a></td>
			                <td><a href="emp_info.html">박부검</a></td>
			                <td><a href="emp_info.html">parkbu</a></td>
			                <td>대리</td>
			            </tr>
			            <tr>
			                <td>8</td>
			                <td><a href="#">인사관리부</a></td>
			                <td><a href="emp_info.html">108</a></td>
			                <td><a href="emp_info.html">정해일</a></td>
			                <td><a href="emp_info.html">sundong</a></td>
			                <td>부장</td>
			            </tr>
			            <tr>
			                <td>9</td>
			                <td><a href="#">인사관리부</a></td>
			                <td><a href="emp_info.html">109</a></td>
			                <td><a href="emp_info.html">박해진</a></td>
			                <td><a href="emp_info.html">parkhae</a></td>
			                <td>대리</td>
			            </tr>
			            <tr>
			                <td>10</td>
			                <td><a href="#">인사관리부</a></td>
			                <td><a href="emp_info.html">110</a></td>
			                <td><a href="emp_info.html">조성우</a></td>
			                <td><a href="emp_info.html">choseong</a></td>
			                <td>대리</td>
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
			            <button class="yellowBtn" onclick="location.href='${pageContext.request.contextPath}/member/insert.do'">사원추가</button>
			        </div>
			    </div>
   			</article>
		</div>
	</section>
</body>

</html>