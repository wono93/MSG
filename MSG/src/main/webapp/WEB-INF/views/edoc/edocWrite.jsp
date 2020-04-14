<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/edocWrite.css">
<!-- jQuery ui style sheet -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link
	href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700&display=swap"
	rel="stylesheet">
<script
	src="${pageContext.request.contextPath }/resources/dateTimePicker/dist/js/jquery-3.4.1.js"></script>
<script
	src="${pageContext.request.contextPath }/resources/js/edocWrite.js"></script>
<script src="https://kit.fontawesome.com/4c554cd518.js"
	crossorigin="anonymous"></script>
<script
	src="${pageContext.request.contextPath }/resources/dateTimePicker/dist/js/datepicker.min.js"></script>
<script
	src="${pageContext.request.contextPath }/resources/dateTimePicker/dist/js/i18n/datepicker.ko.js"></script>
<link
	href="${pageContext.request.contextPath }/resources/dateTimePicker/dist/css/datepicker.min.css"
	rel="stylesheet" type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/jsTree/dist/themes/default/style.min.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath }/resources/jsTree/dist/jstree.min.js"></script>
<!-- jQuery ui library -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	var jq = jQuery.noConflict();

	// 여기서부터 jstree

	var selectedTree;
	var flowLine = new Array();
	var coopLine = new Array();
	var referLine = new Array();

	jq(
			function() {
				jq.ajax({
					type : "get",
					url : "/msg/edoc/jstree.do",
					dataType : "json",
					success : function(response) {
						jq("#ajax_jstree").on(
								"changed.jstree",
								function(e, data) {
									/* console.log(data); */
									if (data.selected.length) {
										selectedTree = data.instance
												.get_node(data.selected[0]).id;
										/* console.log("선택된 요소입니다"+selectedTree); */
									}
								}).jstree({
							core : {
								data : response
							}

						})
					}
				});
			})
</script>
<title>edocWrite</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>

	<section class="edocJsp">
		<div>
			<article>
				<div class="subNav">
					<h3>전자결재</h3>
					<ul>
						<li
							onclick="location.href='${pageContext.request.contextPath}/edoc/srch.do'">문서검색</li>
						<li
							onclick="location.href='${pageContext.request.contextPath}/edoc/list.do'">내문서함</li>
						<li
							onclick="location.href='${pageContext.request.contextPath}/edoc/write.do'">문서기안</li>
					</ul>
				</div>
				<div class="content">
					<div class="control">
						<input type="text" name="" id="edocTitle" placeholder="제목을 입력하세요">
						<form action="">
							<div id="selectDocu" class="select-box">
								<div id="currentExp" class="select-box__current" tabindex="1">
									<div class="select-box__value">
										<input class="select-box__input" type="radio" id="F0"
											value="F0" name="typeCd" />
										<p class="select-box__input-text">기타양식</p>
									</div>
									<div class="select-box__value">
										<input class="select-box__input" type="radio" id="F5"
											value="F5" name="typeCd" />
										<p class="select-box__input-text">공 문</p>
									</div>
									<div class="select-box__value">
										<input class="select-box__input" type="radio" id="F4"
											value="F4" name="typeCd" />
										<p class="select-box__input-text">비용정산서</p>
									</div>
									<div class="select-box__value">
										<input class="select-box__input" type="radio" id="F3"
											value="F3" name="typeCd" />
										<p class="select-box__input-text">구매요청서</p>
									</div>
									<div class="select-box__value">
										<input class="select-box__input" type="radio" id="F2"
											value="F2" name="typeCd" />
										<p class="select-box__input-text">지출결의서</p>
									</div>
									<div class="select-box__value">
										<input class="select-box__input" type="radio" id="F1"
											value="F1" name="typeCd" checked="checked" />
										<p class="select-box__input-text">휴가신청서</p>
									</div>
									<img id="iconExp" class="select-box__icon"
										src="http://cdn.onlinewebfonts.com/svg/img_295694.svg"
										alt="Arrow Icon" aria-hidden="true" />
								</div>
								<ul id="listExp" class="select-box__list">
									<li><label class="select-box__option" for="F1"
										aria-hidden="aria-hidden">휴가신청서</label></li>
									<li><label class="select-box__option" for="F2"
										aria-hidden="aria-hidden">지출결의서</label></li>
									<li><label class="select-box__option" for="F3"
										aria-hidden="aria-hidden">구매요청서</label></li>
									<li><label class="select-box__option" for="F4"
										aria-hidden="aria-hidden">비용정산서</label></li>
									<li><label class="select-box__option" for="F5"
										aria-hidden="aria-hidden">공 문</label></li>
									<li><label class="select-box__option" for="F0"
										aria-hidden="aria-hidden">기타 양식</label></li>
								</ul>
							</div>
						</form>
						<button type="button" name="" id="flowBtn"
							class="whiteBtn commonBtn" onClick="getJstree();">결재선 지정</button>
					</div>
					<div class="tbRow">
						<table class="docuInfoTb">
							<tr>
								<td>문서번호</td>
								<td></td>
							</tr>
							<tr>
								<td>기안자</td>
								<td><%=oc.getDeptName()%> <%=oc.getJobName()%> <%=oc.getEmpName()%></td>
							</tr>
							<tr>
								<td>기안일자</td>
								<td></td>
							</tr>
							<tr>
								<td>보안등급</td>
								<td>
									<div class="secuBox">
										<form action="">
											<div class="select-box">
												<div class="select-box__current" tabindex="1">
													<div class="select-box__value">
														<input class="select-box__input" type="radio" id="S0"
															value="S0" name="secuCheck" />
														<p class="select-box__input-text">C</p>
													</div>
													<div class="select-box__value">
														<input class="select-box__input" type="radio" id="S1"
															value="S1" name="secuCheck" />
														<p class="select-box__input-text">B</p>
													</div>
													<div class="select-box__value">
														<input class="select-box__input" type="radio" id="S2"
															value="S2" name="secuCheck" />
														<p class="select-box__input-text">A</p>
													</div>
													<div class="select-box__value">
														<input class="select-box__input" type="radio" id="S3"
															value="S3" name="secuCheck" checked="checked" />
														<p class="select-box__input-text">S</p>
													</div>
													<img class="select-box__icon"
														src="http://cdn.onlinewebfonts.com/svg/img_295694.svg"
														alt="Arrow Icon" aria-hidden="true" />
												</div>
												<ul class="select-box__list">
													<li><label class="select-box__option" for="S3"
														aria-hidden="aria-hidden">S</label></li>
													<li><label class="select-box__option" for="S2"
														aria-hidden="aria-hidden">A</label></li>
													<li><label class="select-box__option" for="S1"
														aria-hidden="aria-hidden">B</label></li>
													<li><label class="select-box__option" for="S0"
														aria-hidden="aria-hidden">C</label></li>
												</ul>
											</div>
										</form>
									</div>
								</td>
							</tr>
							<tr>
								<td>보존연한</td>
								<td>
									<div class="periodBox">
										<form action="">
											<div class="select-box">
												<div class="select-box__current" tabindex="1">
													<div class="select-box__value">
														<input class="select-box__input" type="radio" id="P0"
															value="P0" name="periodCheck" />
														<p class="select-box__input-text">1년</p>
													</div>
													<div class="select-box__value">
														<input class="select-box__input" type="radio" id="P1"
															value="P1" name="periodCheck" />
														<p class="select-box__input-text">3년</p>
													</div>
													<div class="select-box__value">
														<input class="select-box__input" type="radio" id="P2"
															value="P2" name="periodCheck" />
														<p class="select-box__input-text">5년</p>
													</div>
													<div class="select-box__value">
														<input class="select-box__input" type="radio" id="P3"
															value="P3" name="periodCheck" />
														<p class="select-box__input-text">10년</p>
													</div>
													<div class="select-box__value">
														<input class="select-box__input" type="radio" id="P4"
															value="P4" name="periodCheck" checked="checked" />
														<p class="select-box__input-text">영구</p>
													</div>
													<img class="select-box__icon"
														src="http://cdn.onlinewebfonts.com/svg/img_295694.svg"
														alt="Arrow Icon" aria-hidden="true" />
												</div>
												<ul class="select-box__list">
													<li><label class="select-box__option" for="P4"
														aria-hidden="aria-hidden">영구</label></li>
													<li><label class="select-box__option" for="P3"
														aria-hidden="aria-hidden">10년</label></li>
													<li><label class="select-box__option" for="P2"
														aria-hidden="aria-hidden">5년</label></li>
													<li><label class="select-box__option" for="P1"
														aria-hidden="aria-hidden">3년</label></li>
													<li><label class="select-box__option" for="P0"
														aria-hidden="aria-hidden">1년</label></li>
												</ul>
											</div>
										</form>
									</div>
								</td>
							</tr>
						</table>
						<table class="docuFlowTb">
							<tr>
								<th rowspan="3" class="NoRBorder">결 재</th>
								<th></th>
								<th></th>
								<th></th>
								<th></th>
								<th class="NoRBorder"></th>
							</tr>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td class="NoRBorder"></td>
							</tr>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td class="NoRBorder"></td>
							</tr>
						</table>
					</div>
					<div class="tbRow">
						<table class="docuRefeTb">
							<tr>
								<td>참 조</td>
								<td></td>
							</tr>
						</table>
						<table class="docuCoopTb">
							<tr>
								<th rowspan="3" class="NoRBorder">협 조</th>
								<th></th>
								<th></th>
								<th class="NoRBorder"></th>
							</tr>
							<tr>
								<td></td>
								<td></td>
								<td class="NoRBorder"></td>
							</tr>
							<tr>
								<td></td>
								<td></td>
								<td class="NoRBorder"></td>
							</tr>
						</table>
					</div>
					<div id="tbRowExp" class="tbRow">
						<table class="docuContentTb">
							<tr>
								<td>일 시</td>
								<td><input type="text" data-range="true"
									data-multiple-dates-separator=" ~ "
									data-date-format="yyyy-mm-dd D" data-language="ko"
									id='timepicker-startend' class="datepicker-here" /> <i
									class='far fa-calendar-alt startendicon'
									style='font-size: 32px'></i></td>
								<td>잔여휴가</td>
								<td></td>
							</tr>
							<tr>
								<td>사용일수</td>
								<td><input type="number" name="" id="leaveAmt" min="0"
									max="180" placeholder="사용할 휴가 일수를 입력하세요" /></td>
								<td>구 분</td>
								<td>
									<form action="">
										<div id="selectVac" class="select-box">
											<div id="currentExp2" class="select-box__current"
												tabindex="1">
												<div class="select-box__value">
													<input class="select-box__input" type="radio" id="V7"
														value="V7" name="leaveCheck" />
													<p class="select-box__input-text">기타</p>
												</div>
												<div class="select-box__value">
													<input class="select-box__input" type="radio" id="V6"
														value="V6" name="leaveCheck" />
													<p class="select-box__input-text">무급</p>
												</div>
												<div class="select-box__value">
													<input class="select-box__input" type="radio" id="V5"
														value="V5" name="leaveCheck" />
													<p class="select-box__input-text">병가</p>
												</div>
												<div class="select-box__value">
													<input class="select-box__input" type="radio" id="V4"
														value="V4" name="leaveCheck" />
													<p class="select-box__input-text">경조사</p>
												</div>
												<div class="select-box__value">
													<input class="select-box__input" type="radio" id="V3"
														value="V3" name="leaveCheck" />
													<p class="select-box__input-text">공가</p>
												</div>
												<div class="select-box__value">
													<input class="select-box__input" type="radio" id="V2"
														value="V2" name="leaveCheck" />
													<p class="select-box__input-text">포상</p>
												</div>
												<div class="select-box__value">
													<input class="select-box__input" type="radio" id="V1"
														value="V1" name="leaveCheck" checked="checked" />
													<p class="select-box__input-text">연가</p>
												</div>
												<img class="select-box__icon"
													src="http://cdn.onlinewebfonts.com/svg/img_295694.svg"
													alt="Arrow Icon" aria-hidden="true" />
											</div>
											<ul id="listExp2" class="select-box__list">
												<li><label class="select-box__option" for="V1"
													aria-hidden="aria-hidden">연가</label></li>
												<li><label class="select-box__option" for="V2"
													aria-hidden="aria-hidden">포상</label></li>
												<li><label class="select-box__option" for="V3"
													aria-hidden="aria-hidden">공가</label></li>
												<li><label class="select-box__option" for="V4"
													aria-hidden="aria-hidden">경조사</label></li>
												<li><label class="select-box__option" for="V5"
													aria-hidden="aria-hidden">병가</label></li>
												<li><label class="select-box__option" for="V6"
													aria-hidden="aria-hidden">무급</label></li>
												<li><label class="select-box__option" for="V7"
													aria-hidden="aria-hidden">기타 휴가</label></li>
											</ul>
										</div>
									</form>
								</td>
							</tr>
							<tr>
								<td>사 유</td>
								<td colspan="3"><textarea name="" id="leavePurpose"
										cols="105" rows="6" placeholder="사유를 입력하세요"
										style="resize: none; border: 0"></textarea></td>
							</tr>
							<tr>
								<td>연락처</td>
								<td><input type="text" name="" id="leaveContact"
									class="textIpt" placeholder="비상 연락처를 입력하세요"></td>
								<td>업무대행자 <br /> 사번
								</td>
								<td><label for="nameSrch"></label> <input id="nameSrch"
									placeholder="이름으로 사번 검색" class="textIpt"> <input
									type="hidden" name="surEmpNo" id="surEmpNo"></td>
							</tr>
						</table>
					</div>
					<div class="tbRow">
						<table class="docuAttachTb">
							<tr>
								<td>첨부파일</td>
								<td>
									<div id="fileList"></div>
								</td>
								<td><input type="file" id="fileupload" name="files"
									class="whiteBtn" multiple></td>
							</tr>
						</table>
					</div>
					<div class="btnGrp">
						<button type="button" id="cancleBtn" class="whiteBtn commonBtn">취소</button>
						<button type="button" id="tmpBtn" class="whiteBtn commonBtn">임시저장</button>
						<button type="button" id="saveBtn" class="yellowBtn commonBtn"
							onclick="edocSubmit();">문서상신</button>
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
				<h1>결재선 지정</h1>
				<button type="button" id="loadBtn" class="whiteBtn commonBtn">불러오기</button>
				<button type="button" id="saveBtn" class="whiteBtn commonBtn">저장하기</button>
			</div>
			<div class="flowTbDiv">
				<table class="flowModalTb">
					<tr>
						<td>조직도</td>
						<td></td>
						<td>결재</td>
					</tr>
					<tr>
						<td rowspan="6">
							<div id="ajax_jstree" class="demo"></div>
						</td>
						<td>
							<div id="flowArrow">
								<i class="fas fa-angle-double-right arrowIcon"
									style="font-size: 48px; color: #333333"></i>
							</div>
						</td>
						<td class="flowBox">
							<table id="flowLineTb" class="flowLineTable">
								<tr id="deadline">
									<th colspan=3>이름</th>
									<th>전결</th>
									<th>삭제</th>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td></td>
						<td>협조</td>
					</tr>
					<tr>
						<td>
							<div id="coopArrow">
								<i class="fas fa-angle-double-right arrowIcon"
									style="font-size: 48px; color: #333333"></i>
							</div>
						</td>
						<td class="coopBox">
							<table id="coopLineTb" class="coopLineTable">
								<tr id="deadlineCoop">
									<th colspan=3>이름</th>
									<th>삭제</th>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td></td>
						<td>참조</td>
					</tr>
					<tr>
						<td><i class="fas fa-angle-double-right arrowIcon"
							style="font-size: 48px; color: #333333"></i></td>
						<td class="refBox"></td>
					</tr>
					<tr>
						<td class="marginTd" colspan="2"></td>
					</tr>
				</table>
				<div class="divBtn">
					<button type="button" id="flowBoxBtn" class="yellowBtn commonBtn">확인</button>
					<button type="button" id="closeBoxBtn" class="close whiteBtn commonBtn">취소</button>
				</div>
			</div>
		</div>
	</div>
	<script>
	$(document).ready(function() { // 결재선 1번에 일단 기안자 넣도록 설정
		var jsTreeEmpNo = <%=oc.getEmpNo()%>;
		$.ajax({
			type : "get",
			url : "/msg/edoc/jstreeMem.do",
			data : {
				id : jsTreeEmpNo
			},
			dataType : "json",
			success : function(response) {
				var tmp = [ response['empNo'],
						response['dept'],
						response['job'],
						response['name'] ];

				flowLine.push(tmp);

				var i = flowLine.length - 1;
				$("#flowLineTb")
						.append(
								"<tr id=flowLine"+i+"><td>"
										+ response['dept']
										+ "</td><td>"
										+ response['job']
										+ "</td><td>"
										+ response['name']
										+ "</td><td><label class='flowLine-container kor float' for='flowLine"+flowLine.length+"'><input type='checkbox' name='flowLineCheck' id='flowLine"
										+ flowLine.length
										+ "' onClick='flowLineCheck(this);'><span class='flowLine-checkmark'</span></label></td><td id='flowBoxX'><img src='${pageContext.request.contextPath}/resources/image/X-icon.png' onClick='removeFlow(this);' class='flowBoxX'/></td></tr>");
				/* console.log(flowLine); */
			}
		});
	    
	});
	
		// 모달 기능(결재선)
		$("#flowArrow")
				.click(
						function() {
							$.ajax({
										type : "get",
										url : "/msg/edoc/jstreeMem.do",
										data : {
											id : selectedTree
										},
										dataType : "json",
										success : function(response) {
											var tmp = [ response['empNo'],
													response['dept'],
													response['job'],
													response['name'] ];
											if (tmp[0] == ('fail')) {
												alert("결재선에 부서를 추가할 수는 없습니다.다시 선택하세요.");
												return;
											}
											for ( var i in flowLine) {
												if (flowLine[i][0] == tmp[0]) {
													alert("결재선이 중복됩니다. 다시 선택하세요.");
													return;
												}
											}
											for ( var i in coopLine) {
												if (coopLine[i][0] == tmp[0]) {
													alert("협조선과 결재선은 중복될 수 없습니다. 다시 선택하세요.");
													return;
												}
											}
											flowLine.push(tmp);
											/* console.log(flowLine.length); */
											if (flowLine.length > 5) { // 결재선 5명 제한
												alert("결재선은 최대 5명까지 지정 가능합니다.");
												flowLine.splice(5, 1);
												return;
											}
											var i = flowLine.length - 1;
											$("#flowLineTb")
													.append(
															"<tr id=flowLine"+i+"><td>"
																	+ response['dept']
																	+ "</td><td>"
																	+ response['job']
																	+ "</td><td>"
																	+ response['name']
																	+ "</td><td><label class='flowLine-container kor float' for='flowLine"+flowLine.length+"'><input type='checkbox' name='flowLineCheck' id='flowLine"
																	+ flowLine.length
																	+ "' onClick='flowLineCheck(this);'><span class='flowLine-checkmark'</span></label></td><td id='flowBoxX'><img src='${pageContext.request.contextPath}/resources/image/X-icon.png' onClick='removeFlow(this);' class='flowBoxX'/></td></tr>");
											/* console.log(flowLine); */
										}
									});
						});
		function removeFlow(obj) {
			jq("#deadline").siblings("tr").remove();
			var indexStr = jq(obj).parent().parent("tr").attr("id");
			/* console.log(indexStr); */
			var indexNo = indexStr.substr(indexStr.length - 1);
			/* console.log(indexNo); */
			flowLine.splice(indexNo, 1);
			/* console.log(flowLine); */

			for ( var i in flowLine) {
				var j = +i + 1;
				$("#flowLineTb")
						.append(
								"<tr id=flowLine"+i+"><td>"
										+ flowLine[i][1]
										+ "</td><td>"
										+ flowLine[i][2]
										+ "</td><td>"
										+ flowLine[i][3]
										+ "</td><td><label class='flowLine-container kor float' for='flowLine"+j+"'><input type='checkbox' name='flowLineCheck' id='flowLine"
										+ j
										+ "' onClick='flowLineCheck(this);'><span class='flowLine-checkmark'</span></label></td><td id='flowBoxX'><img src='${pageContext.request.contextPath}/resources/image/X-icon.png' onClick='removeFlow(this);' class='flowBoxX'/></td></tr>");
			}

		};
		
		//모달 기능(참조)
		$("#coopArrow")
				.click(
						function() {
							$.ajax({
										type : "get",
										url : "/msg/edoc/jstreeMem.do",
										data : {
											id : selectedTree
										},
										dataType : "json",
										success : function(response) {
											var tmp = [ response['empNo'],
													response['dept'],
													response['job'],
													response['name'] ];
											if (tmp[0] == ('fail')) {
												alert("협조에 부서를 추가할 수는 없습니다.다시 선택하세요.");
												return;
											}
											for ( var i in flowLine) {
												if (flowLine[i][0] == tmp[0]) {
													alert("협조선과 결재선은 중복될 수 없습니다. 다시 선택하세요.");
													return;
												}
											}
											for ( var i in coopLine) {
												if (coopLine[i][0] == tmp[0]) {
													alert("협조가 중복됩니다. 다시 선택하세요.");
													return;
												}
											}
											coopLine.push(tmp);
											/* console.log(flowLine.length); */
											if (coopLine.length > 3) { // 참조 3명 제한
												alert("협조는 최대 3명까지 지정 가능합니다.");
												coopLine.splice(3, 1);
												return;
											}
											var i = coopLine.length - 1;
											$("#coopLineTb")
													.append(
															"<tr id=coopLine"+i+"><td>"
																	+ response['dept']
																	+ "</td><td>"
																	+ response['job']
																	+ "</td><td>"
																	+ response['name']
																	+ "</td><td id='coopBoxX'><img src='${pageContext.request.contextPath}/resources/image/X-icon.png' onClick='removeCoop(this);' class='coopBoxX'/></td></tr>");
											/* console.log(coopLine); */
										}
									});
						});
		function removeCoop(obj) {
			jq("#deadlineCoop").siblings("tr").remove();
			var indexStr = jq(obj).parent().parent("tr").attr("id");
			/* console.log(indexStr); */
			var indexNo = indexStr.substr(indexStr.length - 1);
			/* console.log(indexNo); */
			coopLine.splice(indexNo, 1);
			/* console.log(coopLine); */

			for ( var i in coopLine) {
				var j = +i + 1;
				$("#coopLineTb")
						.append(
								"<tr id=coopLine"+i+"><td>"
										+ coopLine[i][1]
										+ "</td><td>"
										+ coopLine[i][2]
										+ "</td><td>"
										+ coopLine[i][3]
										+ "</td><td id='coopBoxX'><img src='${pageContext.request.contextPath}/resources/image/X-icon.png' onClick='removeCoop(this);' class='coopBoxX'/></td></tr>");
			}

		};
		
		
		// 여기서부터 datepicker
		var timePick;
		$('#timepicker-startend').datepicker({
			onSelect : function onSelect(fd) {
				timePick = fd;
			}
		})

		$("#flowBoxBtn").click(function() {
				for (var i = 1; i < 6; i++) { // 결재선 표시 초기화
					var j = i + 1;
					$(".docuFlowTb").find("th:nth-child(" + j + ")").html(
							"");
				}
				for (var i in flowLine) { // 결재선 배열(flowLine)을 읽어 결재선 표시
					var j = 6 - i;
					var k = flowLine.length - i - 1;
					$(".docuFlowTb").find("th:nth-child(" + j + ")").html(
							flowLine[k][3]);
				}
				for (var i = 1; i < 4; i++) { // 결재선 표시 초기화
					var j = i + 1;
					$(".docuCoopTb").find("th:nth-child(" + j + ")").html(
							"");
				}
				for (var i in coopLine) { // 결재선 배열(flowLine)을 읽어 결재선 표시
					var j = 4 - i;
					var k = coopLine.length - i - 1;
					$(".docuCoopTb").find("th:nth-child(" + j + ")").html(
							coopLine[k][3]);
				}

		})

				
		// 파일 첨부 구현용 : 일반 함수
		$(document).ready(function() {
		    $("#fileupload").on("change", addFiles);
		});
		 
		var filesTempArr = [];
		// 파일 첨부 구현용 : 파일 추가
		function addFiles(e) {
		    var files = e.target.files;
		    var filesArr = Array.prototype.slice.call(files);
		    var filesArrLen = filesArr.length;
		    var filesTempArrLen = filesTempArr.length;
		    for( var i=0; i<filesArrLen; i++ ) {
		        filesTempArr.push(filesArr[i]);
		        $("#fileList").append("<div>" + filesArr[i].name + "<input type='button'  value='삭제' class='whiteBtn removeFileupload' onclick=\"deleteFile(event, " + (filesTempArrLen+i)+ ");\"></div>");
		    }
		    $(this).val('');
		}
		// 파일 첨부 구현용 : 파일 삭제
		function deleteFile (eventParam, orderParam) {
		    filesTempArr.splice(orderParam, 1);
		    var innerHtmlTemp = "";
		    var filesTempArrLen = filesTempArr.length;
		    for(var i=0; i<filesTempArrLen; i++) {
		        innerHtmlTemp += "<div>" + filesTempArr[i].name + "<input type='button' value='삭제' onclick=\"deleteFile(event, " + i + ");\"></div>"
		    }
		    $("#fileList").html(innerHtmlTemp);
		}
				
				
		function edocSubmit() {
			console.log("문서 제출 이벤트");
			var empNo = <%=oc.getEmpNo()%>
		;
			var secuCd = $("input[name=secuCheck]:checked").val(); // 보안등급
			var prsvCd = $("input[name=periodCheck]:checked").val(); // 보존연한

			var edocTitle = $("#edocTitle").val(); // 문서제목
			if (edocTitle == "") {
				alert("제목을 입력하세요");
				return;
			}

			//여기서부터 휴가 양식
			var vctnCd = $("input[name=leaveCheck]:checked").val();

			if (timePick == null) {
				alert("휴가 기간을 입력하세요.");
				return;
			}
			splitedTimePick = timePick.split(" ~ ");
			var startDt = splitedTimePick[0].substr(0, 10);
			var endDt;
			//console.log(timePick.length);
			if (timePick.length < 13) {
				endDt = splitedTimePick[0].substr(0, 10);
			} else {
				endDt = splitedTimePick[1].substr(0, 10);
			}
			var leaveAmt = $("#leaveAmt").val();
			if (leaveAmt == null) {
				alert("휴가 사용일 수를 입력하세요.");
				return;
			}

			var leavePurpose = $("#leavePurpose").val();
			var leaveContact = $("#leaveContact").val();
			var typeCd = $("input[name=typeCd]:checked").val();
			var surEmpNo = $("#surEmpNo").val();
			var flowCd = null;
			// 결재선은 이미 flowLine 객체에 들어 있고, 전결만 보내주면 됨.
			if (!$('input[name="flowLineCheck"]:checked').attr("id") == null) {
				flowCd = $('input[name="flowLineCheck"]:checked').attr("id")
						.substr(8); // 해당 번호의 flowLine 배열이 전결이라는 의미. 단, 번호는 1부터 매겼음에 유의.
			}

			//console.log(flowLine);

			// 여기서부터 다시 파일 첨부
			var formData = new FormData();

			// 파일 데이터 : 파일 데이터를 formData에 입력
			for (var i = 0, filesTempArrLen = filesTempArr.length; i < filesTempArrLen; i++) {
				formData.append("files", filesTempArr[i]);
			}

			formData.append("empNo", empNo);
			formData.append("secuCd", secuCd);
			formData.append("prsvCd", prsvCd);
			formData.append("edocTitle", edocTitle);
			formData.append("vctnCd", vctnCd);
			formData.append("startDt", startDt);
			formData.append("endDt", endDt);
			formData.append("leaveAmt", leaveAmt);
			formData.append("leavePurpose", leavePurpose);
			formData.append("leaveContact", leaveContact);
			formData.append("typeCd", typeCd);
			formData.append("flowLine", flowLine);
			formData.append("coopLine", coopLine);
			formData.append("flowCd", flowCd);
			formData.append("surEmpNo", surEmpNo);

			//console.log(formData);
			var edocAttJson;

			$.ajax({
				type : "post",
				url : "/msg/edoc/write.do",
				data : formData,
				enctype : 'multipart/form-data', // ajax로 파일 전송을 하기 위해 필수
				processData : false, // ajax로 파일 전송을 하기 위해 필수
				contentType : false, // ajax로 파일 전송을 하기 위해 필수
				dataType : 'text',
				success : function(response) {
					/* console.log(response); */
					location.href = "${pageContext.request.contextPath}"
							+ response;
				}
			});

		}
		// 체크박스 라디오 버튼처럼 동작시키는 함수
		function flowLineCheck(obj) {
			if (obj.checked) {
				/* console.log($(obj).attr("id")); */
				$('input[name="flowLineCheck"]').prop("checked", false);
				$(obj).prop("checked", true);
			}
		}

		// 이름 검색 기능 (auto complete)
		jq(document).ready(function() {
				jq.ajax({
					url : "/msg/edoc/nameSrch.do",
					type : "GET",
					success : function(data) {
						var str = [];
						jq.each(data, function(i, item) {
							str[i] = {
								label : item.deptName + " " + item.jobName
										+ " " + item.empName,
								value : item.empNo
							}
						});

						jq("#nameSrch").autocomplete({
							source : str,
							select : function(event, ui) {
								console.log(ui.item.value);
								jq("#surEmpNo").val(ui.item.value);
							},
							focus : function(event, ui) {
								return false;
							}
						});
						console.log("STR =", str);

					}

				});
			})
	</script>
</body>
</html>