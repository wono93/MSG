function transform(time){
		var valuee = time.getFullYear().toString()+"-"+((time.getMonth()+1).toString().length==2?(time.getMonth()+1).toString():"0"+(time.getMonth()+1).toString())+"-"+(time.getDate().toString().length==2?time.getDate().toString():"0"+time.getDate().toString())+"T"+(time.getHours().toString().length==2?time.getHours().toString():"0"+time.getHours().toString())+":"+((parseInt(time.getMinutes()/5)*5).toString().length==2?(parseInt(time.getMinutes()/5)*5).toString():"0"+(parseInt(time.getMinutes()/5)*5).toString())+":00";
		return valuee;
		
	}

function transformForDB(time){
	var valuee = time.getFullYear().toString()+"-"+((time.getMonth()+1).toString().length==2?(time.getMonth()+1).toString():"0"+(time.getMonth()+1).toString())+"-"+(time.getDate().toString().length==2?time.getDate().toString():"0"+time.getDate().toString())+" "+(time.getHours().toString().length==2?time.getHours().toString():"0"+time.getHours().toString())+":"+((parseInt(time.getMinutes()/5)*5).toString().length==2?(parseInt(time.getMinutes()/5)*5).toString():"0"+(parseInt(time.getMinutes()/5)*5).toString());
	return valuee;
}

/********************************* 회의실 / 법인차량 예약 ******************************/


let use="";  //대여시작시간
let retrn = "";  //대여반납시간
let howLong;  //총 대여시간
let valSuccessed = false;

//회의실/차량 - 대여시작시간 선택 시
$('input[id^="timepicker-start-"]').datepicker({
	minDate: new Date(),
	onSelect: function onSelect (start) {
		
		to_db_start(start);
		
    }
});

//회의실 - 대여반납시간 선택 시
$('#timepicker-end-conf').datepicker({
	minDate: new Date(),
	onSelect: function onSelect (end){
		
		to_db_end(end);
		upToThirtyMin();
		confMaxIsFourHours();
		
	}
});

//차량 - 대여반납시간 선택 시
$('#timepicker-end-car').datepicker({
	minDate: new Date(),
	onSelect: function onSelect (end){
		
		to_db_end(end);
		upToThirtyMin();
		carMaxIsTwoWeeks();
		
		var resUseDate = transformForDB(use);
		var resReturnDate = transformForDB(retrn);
		
//		console.log("시작"+resUseDate);
//		console.log("반납"+resReturnDate);
		
		//ajax로 예약시간 도중 해당 값을 가지고 있는 차량 객체만 출력 라디오 선택 가능하게 바꾸기
		$.ajax({
			url : getContextPath()+"/res/carListEnd",
			data : {resUseDate : resUseDate,
					resReturnDate : resReturnDate},
			type : "get",
			dataType : "json",
			success : data =>{
				//현재출력값 지우고
				$("tr.ajaxHide").css('display','none');
				//받아온 이미 예약된 차량은 라디오 비활성화 후 출력
				console.log(data.unborrowable);
				//예약이 없는 차량은  다시 출력
				console.log(data.borrowable);
			},
			error: (x,s,e) =>{
				console.log("에러"+x,s,e);
			}
		});
	}
});

$(document).ready(function(){
	
	//회의실 - 예약하기 버튼을 눌렀을 떄
	$("#getConfReserv").click(function(){
		
		//1, 2-1
		resValidate();
		if(valSuccessed == true){
			
			//3. 빌릴 객체 라디오 미선택시
			if(!$("input[name='conf']").is(":checked")){
				alert("빌릴 회의실을 체크해주세요.");
				return false;		
			}
				
			$("#confResFrm").submit();
		}
	});
	
	//차량 - 예약하기 버튼을 눌렀을 떄
	$("#getCarReserv").click(function(){
		
		resValidate();
		if(valSuccessed == true){
		
			//3. 빌릴 객체 라디오 미선택시
			if(!$("input[name='car']").is(':checked')){
				alert("빌릴 차량을 체크해주세요.");
				return false;
			}
			
			$('#carResFrm').submit();
		}
	});
	
});
function to_db_start(start){
	use = new Date(start.substr(0,11)+start.substr(13)); 
	//console.log("use="+use);
	
	use_ = transform(use);
	$("[name=resUseDate]").val(use_);
	//console.log($("[name=resUseDate]").val());
}

function to_db_end(end){
	retrn = new Date(end.substr(0,11)+end.substr(13));
	//console.log(retrn);
	
	//대여반납시간이 대여시작시간보다 이른 경우
	if(use > retrn){
		alert("대여반납시간은 대여시작시간보다 앞선 시각일 수 없습니다.");
		$('input[id^=timepicker-end').val('');
		return false;
	}
	
	retrn_ = transform(retrn);
	$("[name=resReturnDate]").val(retrn_);
	//console.log($("[name=resReturnDate]").val());
	
	howLong = retrn - use; //대여시간
	//console.log(howLong);
	
}
function resValidate(){
	valSuccessed=true;
	
	//1. 대여시작시간, 반납시간 null시
		//대여시작시간 null시
		if(use == ""){
			alert("대여 시작시간을 선택해주세요.");
			valSuccessed = false;
			return false;
		}
		
		//반납시간 null시
		if(retrn == ""){
			alert("반납할 시간을 선택해주세요.");
			valSuccessed = false;
			return false;
		}
		
	//대여신청한 시간 정해주고 DB보내기
		let now = new Date();
		now = transform(now);
		$("[name=resEnrolldate]").val(now);
}

//최소예약가능시간 미만 시
function upToThirtyMin(){
	
	if(howLong < 1800000){ //30분
		$("input[id^='timepicker-end']").val('');
		alert("최소 30분 이상 대여하셔야 합니다. \n30분 이상 선택해주세요.");
		//valSuccessed = false;
		return false;
	}
}

function confMaxIsFourHours(){
	if(howLong > 14400000){ //4시간
		$('#timepicker-end-conf').val('');
		alert("회의실은 4시간 이상 예약할 수 없습니다. \n4시간 이내의 시간을 선택해주세요.");
		return false;
	}
}

function carMaxIsTwoWeeks(){
	if(howLong > 1209600000){ //2주
		$('#timepicker-end-car').val('');
		alert("차량은 한번에 2주일 이상 예약할 수 없습니다. \n2주 이내의 시간을 선택해주세요.");
		return false;
	}
}

