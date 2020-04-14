//contextPath 구하기 S
function getContextPath() { 
	return window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
}
function formatDate(date) {
       return date.getDate();
}

function printWeek() {
       var now = new Date();
       var nowDayOfWeek = now.getDay();
       var nowDay = now.getDate()+1;
       var nowMonth = now.getMonth();
       var nowYear = now.getYear();
       nowYear += (nowYear < 2000) ? 1900 : 0;
       var weekStartDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek);
       var weekEndDate = new Date(nowYear, nowMonth, nowDay + ( 7 - nowDayOfWeek));
       return weekStartDate.getDate();
}

var thisWeekMon = printWeek();

$(document).ready(function(){
	
	console.log(thisWeekMon);
	for(var i=1; i<8; i++){
		$("#day_"+i).html(thisWeekMon);
		thisWeekMon++;
	}
	
	$.ajax({
		url : getContextPath()+"/sched/mainSchedList",
		data : {empNo : empNo,
				deptName : empDept},
		type : "get",
		dataType : "json",
		success : data =>{
//			// 현재출력값 지우고
//			$("tr.ajaxHide-tr").remove();
//			//기본상태 : 회의실예약내역 + 차량예약내역
//			
//			// 예약이 없는 차량은 다시 출력
//			//console.log(data.borrowable);
//			 (data.borrowable);
//			
//			// 받아온 이미 예약된 차량은 라디오 비활성화 후 출력
//			//console.log(data.unborrowable);
//			createTr_unborrowableCar(data.unborrowable);
			
		},
		error: (x,s,e) =>{
			console.log("에러"+x,s,e);
		}
	});

	
	
});