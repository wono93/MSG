<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/4c554cd518.js" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
    <title>DocuForm</title>
    <script>
        window.onload = function () {
            // Get the modal
            var modal = document.getElementById("channelGenModal");

            // Get the button that opens the modal
            var btn = document.getElementById("plus-icon");

            // Get the <span> element that closes the modal
            var span = document.getElementsByClassName("close")[0];

            // When the user clicks on the button, open the modal
            btn.onclick = function () {
                modal.style.display = "block";
            }

            // When the user clicks on <span> (x), close the modal
            span.onclick = function () {
                modal.style.display = "none";
            }

            // When the user clicks anywhere outside of the modal, close it
            window.onclick = function (event) {
                if (event.target == modal) {
                    modal.style.display = "none";
                }
            }
        }
    </script>
    <style>
        body {
            background-color: #ebebeb;
        }

        body * {
            font-family: "Noto Sans KR";
            outline: none;
        }
        /* 여기서부터 select-box */
        .select-box{position:relative;display:inline-block;width:100%;font-family:"Noto Sans KR";font-size:14px;font-weight:800;color:#333}@media (min-width:110px){.select-box{width:110px}}.select-box__current{position:relative;border:2px solid #999;border-radius:5%;cursor:pointer;outline:0}.select-box__current:focus+.select-box__list{opacity:1;-webkit-animation-name:none;animation-name:none}.select-box__current:focus+.select-box__list .select-box__option{cursor:pointer}.select-box__current:focus .select-box__icon{-webkit-transform:translateY(-50%) rotate(180deg);transform:translateY(-50%) rotate(180deg)}.select-box__icon{position:absolute;top:50%;right:7px;-webkit-transform:translateY(-50%);transform:translateY(-50%);width:13px;opacity:.3;-webkit-transition:.2s ease;transition:.2s ease}.select-box__value{display:-webkit-box;display:flex}.select-box__input{display:none}.select-box__input:checked+.select-box__input-text{display:block}.select-box__input-text{display:none;width:100%;margin:0;padding:8px;padding-right:20px;background-color:#fefefe}.select-box__list{position:absolute;width:100%;padding:0;list-style:none;opacity:0;-webkit-animation-name:HideList;animation-name:HideList;-webkit-animation-duration:.5s;animation-duration:.5s;-webkit-animation-delay:.5s;animation-delay:.5s;-webkit-animation-fill-mode:forwards;animation-fill-mode:forwards;-webkit-animation-timing-function:step-start;animation-timing-function:step-start}.select-box__option{display:block;padding:5px;background-color:#fefefe}.select-box__option:focus,.select-box__option:hover{color:#333;background-color:#ebebeb}@-webkit-keyframes HideList{from{-webkit-transform:scaleY(1);transform:scaleY(1)}to{-webkit-transform:scaleY(0);transform:scaleY(0)}}@keyframes HideList{from{-webkit-transform:scaleY(1);transform:scaleY(1)}to{-webkit-transform:scaleY(0);transform:scaleY(0)}}#plus-icon{width:100px}
        
        /* 모달 */
        /* The Modal (background) */
        .ch-modal {
            display: none;
            /* Hidden by default */
            position: fixed;
            /* Stay in place */
            z-index: 1;
            /* Sit on top */
            left: 0;
            top: 0;
            width: 100%;
            /* Full width */
            height: 100%;
            /* Full height */
            overflow: auto;
            /* Enable scroll if needed */
            background-color: rgb(0, 0, 0);
            /* Fallback color */
            background-color: rgba(0, 0, 0, 0.4);
            /* Black w/ opacity */
        }

        /* Modal Content/Box */
        .ch-modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            /* 15% from the top and centered */
            padding: 25px 25px 45px 45px;
            border: 1px solid #888;
            width: 650px;
            /* Could be more or less, depending on screen size */
        }

        .channelGenTitle {
            position: relative;
            height: 70px;
        }

        .channelGenTitle h3 {
            float: left;
            margin: 0;
            font-weight: 500;
        }

        .channelGenTitle h4 {
            float: right;
        }
        .chDivBtn {
            text-align: center;
            float: right;
        }

        .chDivBtn button {
            margin: 0 0 0 5px;
        }
        .ch-button{
            background-color: #fefefe;
            border: 1px solid #999999;
            color: #999999;
            font-size: 14px;
            font-weight: 400;
            width: 65px;
            height: 40px;   
        }
        .ch-button:hover{
            background: #F4CA25;
        }
        .ch-modal-content textarea {
            background-color: #ebebeb;
            border: 0px;
        }

        /* 여기서부터 검색창 */
        .srchChBar {
            padding: 50px 0 20px 0;
            /* text-align: right; */
        }

        #srchChWord {
            background-color: #ebebeb;
            color: #333333;
            border: 0;
            height: 38px;
            width: 170px;
            font-family: "Noto Sans KR";
            font-size: 14px;
            margin: 0 0 0 10px;
        }
        #ch-search-icon{
            width: 27px;
            vertical-align: bottom;
            margin: 0 0 6px 6px;
        }
        /* ch-member img */
        .ch-member-img{
            width: 50px; 
            height: 50px;
            object-position: top;
            object-fit: cover;
            border-radius: 50%;
            float: right;
            border: 1px solid #999999;
        }
        #ch-member-list-img{
            width: 34px;
            height: 34px;
            margin: 2px 0;
            border: none;
        }

        #ch-input-title{
            background-color: #ebebeb;
            color: #333333;
            height: 30px;
            width: 590px;
            border: none;
            border-bottom: 3px solid #999999;
            padding: 12px 19px;
            margin-bottom: 15px;
            font-size: 15px;
        }
        .x-icon{
            width: 20px;
        }
        #close-btn{
            float: right;
        }
        #king{
            width: 24px;
            float: right;
            margin: 0 8px 0 0;
        }
        #ch-content{
            padding: 20px 20px 0 0;
        }
        #ch-member-list{
            border-top: 3px solid #999999;
            border-bottom: 3px solid #999999;
            padding: 10px 0;
            height: 140px;
            overflow: scroll;
            text-align: center;
        }
        #ch-member-table td:first-child{
            width:45px;
        }
        #ch-member-table td:nth-child(2){
            font-weight: 500;
            width:100px;
        }
        #ch-member-table td:nth-child(3){
            width:150px;
        }
        #ch-member-table td:nth-child(4){
            width:100px;
        }
        #ch-member-table td:nth-child(5){
            width:170px;
        }
    </style>
</head>

<body>
    <img src="${pageContext.request.contextPath}/resources/image/plus.png" id="plus-icon" alt="">
        <!-- The Modal -->
        <div id="channelGenModal" class="ch-modal">
            <!-- Modal content -->
            <div class="ch-modal-content">
                
                <img src="X-icon.png" alt="" class="x-icon close" id="close-btn">
                <div id="ch-content">
                    <form action="">

                        <div class="channelGenTitle">
                            <h3>채널만들기</h3>
                            <img src="img.jpg" id="" class="ch-member-img">
                            <img src="king.svg" id="king" class="">
                        </div>

                        <input type="text" name="" id="ch-input-title" placeholder="채널명을 입력해주세요.">

                        <div id="ch-member-list">
                            <table id="ch-member-table">
                                <tr>
                                    <td><img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="ch-member-list-img" class="ch-member-img"></td>
                                    <td>가디01</td>
                                    <td>해외영업부</td>
                                    <td>과장</td>
                                    <td>20122222</td>
                                    <td><img src="X-icon.png" alt="" class="x-icon" id=""></td>
                                </tr>
                                <tr>
                                    <td><img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="ch-member-list-img" class="ch-member-img"></td>
                                    <td>가디01</td>
                                    <td>해외영업부</td>
                                    <td>과장</td>
                                    <td>20122222</td>
                                    <td><img src="X-icon.png" alt="" class="x-icon" id=""></td>
                                </tr>
                                <tr>
                                    <td><img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="ch-member-list-img" class="ch-member-img"></td>
                                    <td>가디01</td>
                                    <td>해외영업부</td>
                                    <td>과장</td>
                                    <td>20122222</td>
                                    <td><img src="X-icon.png" alt="" class="x-icon" id=""></td>
                                </tr>
                                <tr>
                                    <td><img src="${pageContext.request.contextPath}/resources/image/img.jpg" id="ch-member-list-img" class="ch-member-img"></td>
                                    <td>가디01</td>
                                    <td>해외영업부</td>
                                    <td>과장</td>
                                    <td>20122222</td>
                                    <td><img src="X-icon.png" alt="" class="x-icon" id=""></td>
                                </tr>
                            </table>
                        </div>


                        <div class="srchChBar">
                            <div class="select-box">
                                <div class="select-box__current" tabindex="1">
                                    <div class="select-box__value">
                                        <input class="select-box__input" type="radio" id="0" value="1" name="Ben" />
                                        <p class="select-box__input-text">부서</p>
                                    </div>
                                    <div class="select-box__value">
                                        <input class="select-box__input" type="radio" id="1" value="2" name="Ben" />
                                        <p class="select-box__input-text">사번</p>
                                    </div>
                                    <div class="select-box__value">
                                        <input class="select-box__input" type="radio" id="2" value="3" name="Ben" />
                                        <p class="select-box__input-text">이름</p>
                                    </div>
                                    <div class="select-box__value">
                                        <input class="select-box__input" type="radio" id="3" value="4" name="Ben"
                                            checked="checked" />
                                        <p class="select-box__input-text">전체</p>
                                    </div><img class="select-box__icon"
                                        src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon"
                                        aria-hidden="true" />
                                </div>
                                <ul class="select-box__list">
                                    <li>
                                        <label class="select-box__option" for="3" aria-hidden="aria-hidden">전체</label>
                                    </li>
                                    <li>
                                        <label class="select-box__option" for="0" aria-hidden="aria-hidden">부서</label>
                                    </li>
                                    <li>
                                        <label class="select-box__option" for="1" aria-hidden="aria-hidden">사번</label>
                                    </li>
                                    <li>
                                        <label class="select-box__option" for="2" aria-hidden="aria-hidden">이름</label>
                                    </li>
                                </ul>
                            </div>
                            
                            <input type="text" name="" id="srchChWord">

                            <img src="${pageContext.request.contextPath}/resources/image/search-icon.png" alt="" id="ch-search-icon">

                            <div class="chDivBtn">
                                <button type="button" class="ch-button">확인</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
</body>
</html>