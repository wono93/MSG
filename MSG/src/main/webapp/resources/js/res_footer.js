var week = ['일', '월', '화', '수', '목', '금', '토'];

function transform(time){
		var valuee = time.getFullYear().toString()+"-"+((time.getMonth()+1).toString().length==2?(time.getMonth()+1).toString():"0"+(time.getMonth()+1).toString())+"-"+(time.getDate().toString().length==2?time.getDate().toString():"0"+time.getDate().toString())+"T"+(time.getHours().toString().length==2?time.getHours().toString():"0"+time.getHours().toString())+":"+((parseInt(time.getMinutes()/5)*5).toString().length==2?(parseInt(time.getMinutes()/5)*5).toString():"0"+(parseInt(time.getMinutes()/5)*5).toString())+":00";
		return valuee;
		
	}

function transformForDB(time){
	var valuee = time.getFullYear().toString()+"-"+((time.getMonth()+1).toString().length==2?(time.getMonth()+1).toString():"0"+(time.getMonth()+1).toString())+"-"+(time.getDate().toString().length==2?time.getDate().toString():"0"+time.getDate().toString())+" "+(time.getHours().toString().length==2?time.getHours().toString():"0"+time.getHours().toString())+":"+((parseInt(time.getMinutes()/5)*5).toString().length==2?(parseInt(time.getMinutes()/5)*5).toString():"0"+(parseInt(time.getMinutes()/5)*5).toString())+":00";
	return valuee;
}

function transformForView(time){
	var valuee = time.getFullYear().toString()+"-"+((time.getMonth()+1).toString().length==2?(time.getMonth()+1).toString():"0"+(time.getMonth()+1).toString())+"-"+(time.getDate().toString().length==2?time.getDate().toString():"0"+time.getDate().toString())+" ("+ week[time.getDay()] +") "+(time.getHours().toString().length==2?time.getHours().toString():"0"+time.getHours().toString())+":"+((parseInt(time.getMinutes()/5)*5).toString().length==2?(parseInt(time.getMinutes()/5)*5).toString():"0"+(parseInt(time.getMinutes()/5)*5).toString());
	return valuee;
}

/** ******************************* 회의실 / 법인차량 예약시 페이지 ***************************** */

let use = "";  // 대여시작시간
let retrn = "";  // 대여반납시간
let howLong;  // 총 대여시간
let valSuccessed = false;
let i = 1; // 비품예약 시 ajax시에 사용하는 각 td의 count값


// 회의실/차량 - 대여시작시간 선택 시
$('input[id^="timepicker-start-"]').datepicker({
	minDate: new Date(),
	onSelect: function onSelect (start) {
		
		to_db_start(start);
		
    }
});

// 회의실 - 대여반납시간 선택 시
$('#timepicker-end-conf').datepicker({
	minDate: new Date(),
	onSelect: function onSelect (end){
		
		to_db_end(end);
		upToThirtyMin();
		confMaxIsFourHours();
		
	}
});

// 차량 - 대여반납시간 선택 시
$('#timepicker-end-car').datepicker({
	minDate: new Date(),
	onSelect: function onSelect (end){
		
		i = 1;
		
		to_db_end(end);
		upToThirtyMin();
		carMaxIsTwoWeeks();
		
		if(use != ""){
			var resUseDate = transformForDB(use);
			var resReturnDate = transformForDB(retrn);
			
	// console.log("시작"+resUseDate);
	// console.log("반납"+resReturnDate);
			
			// ajax로 예약시간 도중 해당 값을 가지고 있는 차량 객체만 출력 라디오 선택 가능하게 바꾸기
			$.ajax({
				url : getContextPath()+"/res/carListEnd",
				data : {resUseDate : transformForDB(use),
						resReturnDate : transformForDB(retrn)},
				type : "get",
				dataType : "json",
				success : data =>{
					// 현재출력값 지우고
					$("tr.ajaxHide-tr").remove();
					//기본상태 : 회의실예약내역 + 차량예약내역
					
					// 예약이 없는 차량은 다시 출력
					//console.log(data.borrowable);
					createTr_borrowableCar(data.borrowable);
					
					// 받아온 이미 예약된 차량은 라디오 비활성화 후 출력
					//console.log(data.unborrowable);
					createTr_unborrowableCar(data.unborrowable);
					
				},
				error: (x,s,e) =>{
					console.log("에러"+x,s,e);
				}
			});
		
		}
	}
});




$(document).ready(function(){
	
	setTimeout(()=>{
		$('[id^="timepicker-start"]').focus();
	}, 3000);
	
	// 회의실 - 예약하기 버튼을 눌렀을 떄
	$("#getConfReserv").click(function(){
		
		// 1, 2-1
		resValidate();
		if(valSuccessed == true){
			
			// 3. 빌릴 객체 라디오 미선택시
			if(!$("input[name='conf']").is(":checked")){
				alert("빌릴 회의실을 체크해주세요.");
				return false;		
			}
				
			$("#confResFrm").submit();
		}
	});
	
	// 차량 - 예약하기 버튼을 눌렀을 떄
	$("#getCarReserv").click(function(){
		
		resValidate();
		if(valSuccessed == true){
		
			// 3. 빌릴 객체 라디오 미선택시
			if(!$("input[name='car']").is(':checked')){
				alert("빌릴 차량을 체크해주세요.");
				return false;
			}
			
			$('#carResFrm').submit();
		}
	});
	
	//예약내역 확인페이지에서 각 예약내역 클릭시 수정/삭제 팝업메뉴 나타남 (contextMenu OpenSource 이용)
	 $('.res-table').contextMenu({
	        selector: '.ajaxHide-tr',
	        trigger: 'left',
	        callback: (key, options) => {
//	        	switch(key){
//	        	case :
//	        		;
//	        		break;
//	        	case 'delete': 
//	        		delRes($(this).val()); //이 선택값의 코드를 가져가서 그 값 DB삭제
//	        		break;
//	        	}
	        	console.log($(this).children(".displayNone"));
	            var m = "clicked: " + key;
	            window.console && console.log(m) || alert(m);
	        },
	        items: {
	            "edit": 
			            {
			                "name": "예약내역 수정", "icon" : "edit",
			                "items": {
			                	 // <input type="text">
			                    name: {
			                        name: "Text", 
			                        type: 'text', 
			                        value: "Hello World", 
			                        events: {
			                            keyup: function(e) {
			                                // add some fancy key handling here?
			                                window.console && console.log('key: '+ e.keyCode); 
			                            }
			                        }
			                    },
			                    sep1: "---------",
			                    // <input type="checkbox">
			                    yesno: {
			                        name: "Boolean", 
			                        type: 'checkbox', 
			                        selected: true
			                    },
			                    sep2: "---------",
			                    // <input type="radio">
			                    radio1: {
			                        name: "Radio1", 
			                        type: 'radio', 
			                        radio: 'radio', 
			                        value: '1'
			                    },
			                    radio2: {
			                        name: "Radio2", 
			                        type: 'radio', 
			                        radio: 'radio', 
			                        value: '2', 
			                        selected: true
			                    },
			                    radio3: {
			                        name: "Radio3", 
			                        type: 'radio', 
			                        radio: 'radio', 
			                        value: '3'
			                    },
			                    radio4: {
			                        name: "Radio3", 
			                        type: 'radio', 
			                        radio: 'radio', 
			                        value: '4', 
			                        disabled: true
			                    },
			                    sep3: "---------",
			                    // <select>
			                    select: {
			                        name: "Select", 
			                        type: 'select', 
			                        options: {1: 'one', 2: 'two', 3: 'three'}, 
			                        selected: 2
			                    },
			                    // <textarea>
			                    area1: {
			                        name: "Textarea with height", 
			                        type: 'textarea', 
			                        value: "Hello World", 
			                        height: 40
			                    },
			                    area2: {
			                        name: "Textarea", 
			                        type: 'textarea', 
			                        value: "Hello World"
			                    },
			                    sep4: "---------",
			                    key: {
			                        name: "Something Clickable", 
			                        callback: $.noop
			                    }
			                }, 
			                events: {
			                    show: function(opt) {
			                        // this is the trigger element
			                        var $this = this;
			                        // import states from data store 
			                        $.contextMenu.setInputValues(opt, $this.data());
			                        // this basically fills the input commands from an object
			                        // like {name: "foo", yesno: true, radio: "3", &hellip;}
			                    }, 
			                    hide: function(opt) {
			                        // this is the trigger element
			                        var $this = this;
			                        // export states to data store
			                        $.contextMenu.getInputValues(opt, $this.data());
			                        // this basically dumps the input commands' values to an object
			                        // like {name: "foo", yesno: true, radio: "3", &hellip;}
			                    }
			                }
			            },
	            "delete": {name: "예약내역 삭제", icon: "delete"},
	            "sep1": "---------",
	            "quit": {name: "취소", icon: function($element, key, item){ return 'context-menu-icon context-menu-icon-quit'; }}
	        }
	    });


});
function to_db_start(start){
	use = new Date(start.substr(0,11)+start.substr(13)); 
	// console.log("use="+use);
	
	use_ = transform(use);
	$("[name=resUseDate]").val(use_);
	// console.log($("[name=resUseDate]").val());
}


function to_db_end(end){
	retrn = new Date(end.substr(0,11)+end.substr(13));
	// console.log(retrn);
	
	var $start = $("input[id^=timepicker-start]");
	var $end = $("input[id^=timepicker-end]");
	
	if( $start.val() == "" ){
		alert("대여시작시간을 먼저 선택해주세요.");
		$start.focus();
		$end.val('');
		return false;
	}
	
	// 대여반납시간이 대여시작시간보다 이른 경우
	if(use > retrn){
		alert("대여반납시간은 대여시작시간보다 앞선 시각일 수 없습니다.");
		$end.val('');
		return false;
	}
	
	retrn_ = transform(retrn);
	$("[name=resReturnDate]").val(retrn_);
	// console.log($("[name=resReturnDate]").val());
	
	howLong = retrn - use; // 대여시간
	// console.log(howLong);
	
}
function resValidate(){
	valSuccessed=true;
	
	// 1. 대여시작시간, 반납시간 null시
		// 대여시작시간 null시
		if(use == ""){
			alert("대여 시작시간을 선택해주세요.");
			valSuccessed = false;
			return false;
		}
		
		// 반납시간 null시
		if(retrn == ""){
			alert("반납할 시간을 선택해주세요.");
			valSuccessed = false;
			return false;
		}
		
	// 대여신청한 시간 정해주고 DB보내기
		let now = new Date();
		now = transform(now);
		$("[name=resEnrolldate]").val(now);
}

// 최소예약가능시간 미만 시
function upToThirtyMin(){
	
	if(howLong < 1800000){ // 30분
		$("input[id^='timepicker-end']").val('');
		alert("최소 30분 이상 대여하셔야 합니다. \n30분 이상 선택해주세요.");
		// valSuccessed = false;
		return false;
	}
}

function confMaxIsFourHours(){
	if(howLong > 14400000){ // 4시간
		$('#timepicker-end-conf').val('');
		alert("회의실은 4시간 이상 예약할 수 없습니다. \n4시간 이내의 시간을 선택해주세요.");
		return false;
	}
}

function carMaxIsTwoWeeks(){
	if(howLong > 1209600000){ // 2주
		$('#timepicker-end-car').val('');
		alert("차량은 한번에 2주일 이상 예약할 수 없습니다. \n2주 이내의 시간을 선택해주세요.");
		return false;
	}
}

//대여시간 포맷팅 함수(1441분 -> 1일 1분 )
function transHowLong(time){
//	let t = time;
	let t = parseInt(time);
	console.log(t);
	let min = parseInt(t % 60)+"분";
	let hour = parseInt(t / 60 % 24)+"시간 ";
	let day = parseInt(t / 60 / 24)+"일 ";
	
	
//	if(t > 60){
//		min=="0분" ? value = hour : value = hour+min;
//	}
//	
//	else if(t > 1440) {
//		//hour로 분기
//		(hour=="0시간 " ? (min=="0분"? value = day : value = day+min) : (min=="0분" ? value = day+hour : value = day+hour+min));
//		
//	}
	if(day == "0일 ") day = "";
	if(hour == "0시간 ") hour ="";
	if(min == "0분") min="";
	
	var value = day + hour + min;
	
	return value;
	
}

function createTr_borrowableCar(carList){

	  for(let car of carList){
	    let $borrowableCars = $("<tr class='ajaxHide-tr'>" +
	    	"<td>" + i + "</td>" +
	        "<td>" + car.carCate + "</td>" +
	        "<td>" + car.carCompany + " / " + car.carType + "</td>" +
	        "<td>" + car.carNo + "</td>" +
	        "<td>" + car.carSize + "</td>" +
	        "<td>" +
	        "<label class='saveId-container float' for='"+car.carCode+"'>" +
	        "<input type='radio' name='car' onclick='intoCarCode();' id='"+car.carCode+"' value='"+car.carCode+"'/>" +
	        "<span class='saveId-checkmark'></span></label>" +
	        "</td>" +
	        "</tr>");
	    $(".res-table").append($borrowableCars);
	    i++;
	  }
	}

function createTr_unborrowableCar(carList){
	  
	  for(let car of carList){
	    let $unborrowableCars = $("<tr class='ajaxHide-tr'>" +
	    	"<td>" + i + "</td>" +
	        "<td>" + car.carCate + "</td>" +
	        "<td>" + car.carCompany + " / " + car.carType + "</td>" +
	        "<td>" + car.carNo + "</td>" +
	        "<td>" + car.carSize + "</td>" +
	        "<td>" +
	        "<label class='saveId-container float' for='"+car.carCode+"'>" +
	        "<input type='radio' name='car' id='"+car.carCode+"' value='"+car.carCode+"' disabled/>" +
	        "<span class='saveId-checkmark'></span></label>" +
	        "</td>" +
	        "</tr>");
	    $unborrowableCars.css("background-color","#ebebeb")
	    				 .children().css("color","#999");
	    $(".res-table").append($unborrowableCars);
	    i++;
	  }
	}




//체크된 회의실코드 input:hidden에 담아주기
function intoConfCode(){
	let radioVal = $('input[name="conf"]:checked').val();
	$('#croomCode').val(radioVal);
	console.log($('#croomCode').val());
}

//체크된 차량코드 input:hidden에 담아주기
function intoCarCode(){
	let radioVal =  $('input[name="car"]:checked').val();
	$('#carCode').val(radioVal);
	console.log($('#carCode').val());
}



/** ******************************* 예약확인 페이지 ***************************** */
$('#timepicker-startend').datepicker({
	onSelect: function onSelect (date) {
		
		//검색받은 대여시작시간, 종료시간
	    var startDate = transformForDB(new Date(date.substr(0,10)));
		var endDate = null;
		if(date.length == 27){
	    	endDate = transformForDB(new Date(date.substr(15,10)));
		}
	    console.log(startDate);
	    console.log(endDate); 
	    
	    //ajax로 입력시간값에 해당하는 예약내역 출력하기
		$.ajax({
			url : getContextPath()+"/res/resListByDate",
			data : {srchFrom : startDate,
					srchTo : endDate},
			type : "get",
			dataType : "json",
			success : resViewList =>{
				
				// 현재출력값 지우고
//				$("tr.ajaxHide-tr").remove();
				$(".haveNoRes").find("table").remove();
//				console.log($(".haveNoRes").find("table")); //res-table 세개


					createTr_properDateConfResView(resViewList.confList);
					createTr_properDateCarResView(resViewList.carList);
					createTr_properDateAllResView(resViewList.rList);
					
					if($("#cconf").is(":checked")){
				     	//드롭다운에서 회의실 선택시 회의실예약내역 출력
				     	$("#confList-div").show()
				     					  .children("table").addClass('res-table');
							$("#rList-div").hide()
										   .children("table").removeClass('res-table');
							$("#carList-div").hide()
											 .children("table").removeClass('res-table');
				 	}
				 	else if($("#ccar").is(":checked")){
				 		
				 		$("#confList-div").hide()
				 						  .children("table").removeClass('res-table');
							$("#rList-div").hide()
							               .children("table").removeClass('res-table');
							$("#carList-div").show()
											 .children("table").addClass('res-table');
				        		
				 	}
						else{
				 		$("#rList-div").show()
				 					   .children("table").addClass('res-table');
				    		$("#confList-div").hide()
				    						  .children("table").removeClass('res-table');
				    		$("#carList-div").hide()
				    						 .children("table").removeClass('res-table');
				         	
				 	}
				
				
			},
			error: (x,s,e) =>{
				console.log("에러"+x,s,e);
			}
		});
	    
    }
});

//자신의 예약내역이 없으면 '아직 예약한 내역이 없습니다" 문구 출력
function youHaveNoRes(){
	
	   let $table = $(".res-table"); 				 
	   $table.children().remove();
	    				 
	   let $youHaveNoRes = $(
			   "<p class='havNoRes'>아직 예약한 내역이 없습니다.</h1>"
			   );
	   
	   $table.append($youHaveNoRes);
	   $table.children("p.havNoRes").css({"margin":"0 0 50px 0","font-size":"20px","font-weight":"500"});
	    
	    $(".pagingg").remove();
}

///////////////////////Date인풋값 해당 예약내역을 각 카테고리 div에 넣어주기//////////////////////
let $newTb = $("<table class='res-table'></table>");
let $newTh = $(" <tr>"+
				"<th class='narrow-td'></th>"+
				"<th>구분</th>"+
				"<th>대여명</th>"+
				"<th class='narrow-td'>수용</th>"+
				"<th>대여시간</th>"+
				"<th class='wide-td'>대여시작</th>"+
				"<th class='wide-td'>대여종료</th>"+
				"</tr>");
function createTr_properDateConfResView(resViewList){
	let j = 1;
	$("#confList-div").append($newTb);
	$('.res-table').addClass("conf-res");
	$newTb.append($newTh);
	
	for(let res of resViewList){
	    let $resView = $(
	    		"<tr class='ajaxHide-tr'>" +
	        	"<td class='narrow-td'>" + j + "</td>" +
	            "<td>" + res.thingCate + "</td>" +
	            "<td>" + res.thingName + "</td>" +
	            "<td class='narrow-td'>" + res.thingSize + "</td>" +
	            "<td>" + transHowLong(res.howLong) + "</td>" +
	            "<td class='wide-td'>" + transformForView(new Date(res.resUseDate)) + "</td>" +
	            "<td class='wide-td'>" + transformForView(new Date(res.resReturnDate)) + "</td>" +
	            "</tr>" );
	    $newTh.after($resView);
	    j++;
	  }
}
function createTr_properDateCarResView(resViewList){
	let j = 1;
	$("#carList-div").append($newTb);
	$('.res-table').addClass("car-res");
	$newTb.append($newTh);
	
	for(let res of resViewList){
	    let $resView = $(
	    		"<tr class='ajaxHide-tr>" +
	        	"<td class='narrow-td'>" + j + "</td>" +
	            "<td>" + res.thingCate + "</td>" +
	            "<td>" + res.thingName + "</td>" +
	            "<td class='narrow-td'>" + res.thingSize + "</td>" +
	            "<td>" + transHowLong(res.howLong) + "</td>" +
	            "<td class='wide-td'>" + transformForView(new Date(res.resUseDate)) + "</td>" +
	            "<td class='wide-td'>" + transformForView(new Date(res.resReturnDate)) + "</td>" +
	            "</tr>");
	    $newTh.after($resView);
		j++;
	  }
}
function createTr_properDateAllResView(resViewList){
	  let j = 1; // 예약확인 시 Date 검색 ajax 시에 사용하는 각 td의 count값
	  $("#rList-div").append($newTb);
	  $('.res-table').addClass("all-res");
	  $newTb.append($newTh);
	  
	  for(let res of resViewList){
	    let $resView = $(
	    		"<tr class='ajaxHide-tr'>" +
	        	"<td class='narrow-td'>" + j + "</td>" +
	            "<td>" + res.thingCate + "</td>" +
	            "<td>" + res.thingName + "</td>" +
	            "<td class='narrow-td'>" + res.thingSize + "</td>" +
	            "<td>" + transHowLong(res.howLong) + "</td>" +
	            "<td class='wide-td'>" + transformForView(new Date(res.resUseDate)) + "</td>" +
	            "<td class='wide-td'>" + transformForView(new Date(res.resReturnDate)) + "</td>" +
	            "</tr>");
	    $newTb.after($resView);
		j++;
	  }
	}



