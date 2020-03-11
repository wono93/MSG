<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
    <input id="hamburger" class="hamburger" type="checkbox" />
    <label for="hamburger" class="hamburger">
        <i></i>
    <text>
        <close>닫기</close>
        <open>메뉴</open>
        </text>
    </label>


    <nav class="primnav">
        <div class="userinfo">
            <user id="user">
                <img src="https://randomuser.me/api/portraits/women/85.jpg" />
                <idSection>
                    <idSection>
                        <name>누구지</name>
                        <actions><a href="#">사업부</a> | <a href="#">과장</a></actions>
                    </idSection>
                </idSection>
            </user>
        </div>
        <br>
        <ul class="firnav">
            <li>
                <a href="#">
                    <i class="icon far fa-id-card" style="font-size:24px"></i> 인사관리
                </a>
            </li>
            <li>
                <a href="listForm.jsp">
                    <i class="icon far fa-folder" style="font-size:24px"></i> 전자문서
                </a>
            </li>
            <li>
                <a href="#">
                    <i class="icon far fa-comments" style="font-size:24px"></i> 커뮤니케이션
                </a>
            </li>
            <li>
                <a href="#">
                    <i class="icon far fa-calendar-alt" style="font-size:24px"></i> 일정관리
                </a>
            </li>
            <li>
                <a href="#">
                    <i class="icon far fa-check-square" style="font-size:24px"></i> 예약관리
                </a>
            </li>
            <li>
                <a href="#">
                    <i class="icon fas fa-shopping-basket" style="font-size:24px"></i> 오피스디포
                </a>
            </li>
            <br>
            <ul class="secnav">
                <p>Channel</p>
                <li>
                    <a href="#">
                        <i class="fas fa-circle" style="font-size:15px"></i>　경영지원 1팀
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="fas fa-circle" style="font-size:15px"></i>　미식가들
                    </a>
                </li>
            </ul>
            <ul class="secnav">
                <p>Direct Message</p>
                <li>
                    <a href="#">
                        <img src="https://randomuser.me/api/portraits/women/85.jpg">　누구지 부장
                    </a>
                </li>
                <li>
                    <a href="#">
                        <img src="https://randomuser.me/api/portraits/women/85.jpg">　누구지 대리
                    </a>
                </li>
                <li>
                    <a href="#">
                        <img src="https://randomuser.me/api/portraits/women/85.jpg">　누구지 사원
                    </a>
                </li>
            </ul>
        </ul>
    </nav>
