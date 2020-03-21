<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/edocConfirm.css">
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/4c554cd518.js" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/edocConfirm.js"></script>
    <title>edocConfirm</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <section>
        <div>
            <article>
                <div class="subNav">
                    <h3>전자결재</h3>
                    <ul>
                        <li onclick="location.href='${pageContext.request.contextPath}/edoc/srch.do'">문서검색</li>
                        <li onclick="location.href='${pageContext.request.contextPath}/edoc/list.do'">내문서함</li>
                        <li onclick="location.href='${pageContext.request.contextPath}/edoc/write.do'">문서기안</li>
                     </ul>
                </div>
                <div class="content">
                    <div class="control">
                        <div class="leftGrp">
                            <h1>재직증명서 발급 요청</h1>
                        </div>
                        <div class="rightGrp">
                            <button type="button" id="reformBtn" class="whiteBtn commonBtn">재기안</button>
                            <button type="button" id="modeBtn" class="whiteBtn commonBtn">수정</button>
                            <button type="button" id="flowBtn" class="whiteBtn commonBtn">결재</button>
                            <button type="button" id="listBtn" class="whiteBtn commonBtn" onclick="location.href='${pageContext.request.contextPath}/edoc/list.do'">목록</button>
                        </div>
                        <div class="versionDocu">
                            <div class="select-box">
                                <div class="select-box__current" tabindex="1">
                                    <div class="select-box__value">
                                    <input class="select-box__input" type="radio" id="0" value="1" name="Ben"/>
                                    <p class="select-box__input-text">문서버전: 1안(과장 장그래)</p>
                                    </div>
                                    <div class="select-box__value">
                                    <input class="select-box__input" type="radio" id="1" value="2" name="Ben"/>
                                    <p class="select-box__input-text">문서버전: 2안(부장 장백기)</p>
                                    </div>
                                    <div class="select-box__value">
                                    <input class="select-box__input" type="radio" id="2" value="3" name="Ben" checked="checked"/>
                                    <p class="select-box__input-text">문서버전: 3안(부장 안영이)</p>
                                    </div><img class="select-box__icon" src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon" aria-hidden="true"/>
                                </div>
                                <ul class="select-box__list">
                                    <li>
                                    <label class="select-box__option" for="2" aria-hidden="aria-hidden">문서버전: 3안(부장 안영이) </label>
                                    </li>
                                    <li>
                                    <label class="select-box__option" for="1" aria-hidden="aria-hidden">문서버전: 2안(부장 장백기)</label>
                                    </li>
                                    <li>
                                    <label class="select-box__option" for="0" aria-hidden="aria-hidden">문서버전: 1안(과장 장그래)</label>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="tbRow">
                        <table class="docuInfoTb">
                            <tr>
                                <td>문서번호</td>
                                <td>2020-G0001-001</td>
                            </tr>
                            <tr>
                                <td>기안자</td>
                                <td>경영지원부 과장 장그래</td>
                            </tr>
                            <tr>
                                <td>기안일자</td>
                                <td>2020/02/28</td>
                            </tr>
                            <tr>
                                <td>보안등급</td>
                                <td>S</td>
                            </tr>
                            <tr>
                                <td>보존연한</td>
                                <td>영구</td>
                            </tr>
                        </table>
                        <table class="docuFlowTb">
                            <tr>
                                <th rowspan="3" class="NoRBorder">결 재</th>
                                <th></th>
                                <th></th>
                                <th>장그래</th>
                                <th>안영이</th>
                                <th class="NoRBorder">천관웅</th>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td>장그래<br>직인</td>
                                <td>전 결</td>
                                <td class="NoRBorder">안영이<br>직인</td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td>2020/02/28</td>
                                <td></td>
                                <td class="NoRBorder">2020/03/03</td>
                            </tr>
                        </table>
                    </div>
                    <div class="tbRow">
                        <table class="docuRefeTb">
                            <tr>
                                <td>참 조</td>
                                <td>경영지원부</td>
                            </tr>
                        </table>
                        <table class="docuCoopTb">
                            <tr>
                                <th rowspan="3" class="NoRBorder">협 조</th>
                                <th></th>
                                <th></th>
                                <th class="NoRBorder">장백기</th>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td class="NoRBorder">장백기<br>직인</td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td class="NoRBorder">2020/03/02</td>
                            </tr>
                        </table>
                    </div>
                    <div class="tbRow">
                        <table class="docuCommTb">
                            <tr>
                                <th>유형</th>
                                <th>성명</th>
                                <th>결재의견</th>
                            </tr>
                            <tr>
                                <td>기안자</td>
                                <td>경영지원부
                                    <br>
                                    과장 장그래</td>
                                <td>결재 부탁드립니다.</td>
                            </tr>
                            <tr>
                                <td>결재자</td>
                                <td>경영지원부
                                    <br>
                                    부장 안영이</td>
                                <td>전결처리합니다.</td>
                            </tr>
                            <tr>
                                <td>결재자</td>
                                <td>대표이사
                                    <br>
                                    천관웅</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>협조자</td>
                                <td>재무부
                                    <br>
                                    부장 장백기</td>
                                <td>해당 건 재무부에서 확인결과 진행 가능합니다.</td>
                            </tr>
                        </table>
                    </div>
                    <div class="tbRow">
                        <table class="docuAttachTb">
                            <tr>
                                <td>첨부파일</td>
                                <td>20200314_장그래_병원진단서.pdf</td>
                            </tr>
                        </table>
                    </div>
                    <div class="docuSpc">
                        <div class="document">
                            
                        </div>
                    </div>
                </div>
            </article>
        </div>
    </section>
    <!-- The Modal -->
    <div id="flowModal" class="modal">
        <!-- Modal content -->
        <div class="modal-content">
            <div class="flowTitle">
                <h1>결재하기</h1>
                <h4>경영지원부 부장 안영이</h4>
            </div>                                                         
            <form action="">
                <div  class="checkbox_wrap">
                    <h4>결재내용</h4>
                    <label class="flowAllow-container kor float" for="flowAllow">기안 승인
                        <input type="radio" name="flowType" id="flowAllow">
                        <span class="flowAllow-checkmark"></span>
                    </label>
                    <label class="flowDeny-container kor float" for="flowDeny">기안 반려
                        <input type="radio" name="flowType" id="flowDeny">
                        <span class="flowDeny-checkmark"></span>
                    </label>
                </div>
                <div class="flowComment">
                    <h4>결재의견</h4>
                    <textarea name="" id="" cols="65" rows="8" style="resize: none;"></textarea>
                </div>
                <div class="divBtn">
                    <button type="button" id="flowBtn" class="whiteBtn commonBtn">확인</button>
                    <button type="button" id="closeBtn" class="close whiteBtn commonBtn">취소</button>
                </div>
            </form>
        </div>
    </div>
      
</body>
</html>