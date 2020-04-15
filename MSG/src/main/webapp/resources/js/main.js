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
	
//	var $informSched = $("#informSched");
//	informSched.findAll("td").addClass('floatLeft');
//	informSched.findAll("tr").children("td:eq(0)").append("<div class='typeCircle'></div>")
	
	//메인 일정부분에 이번주 7일 출력
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
			console.log(data);
			
			for(var i=0; i < data.length; i++){
				start = new Date(data[i].scheStart);
				end = new Date(data[i].scheEnd);
				
//				console.log(i+"번째 start="+start);
//				console.log(i+"번째 end="+end);
//				console.log(i+"번째 차이="+(end-start));
				
				if((end - start) > 1000*60*60*24){ //마감 - 시작 기간이 하루가 넘으면
//					while(start < end){
						//하루하루 끊으면서 '하루종일'은 'Y'처리하며 new Schedule 생성
						//생성된 schedule을 td#day_1~7와 비교해서 일치하면 .next().next()의 text()에 값 넣어주기
						for(var j=1; j<8; j++){
							if($("#day_"+j).html() == start.getDate()){
								//console.log(i+"번째 "+$("#day_"+j).html()+"   "+start.getDate() );
								console.log(data[i].scheName);
								$("#day_"+j).parent("tr").children("td:eq(2)").append("<div title='"+data[i].scheName+"' style='margin-left:10px; width:20px; height:20px; float:left; background:"+data[i].scheColor+"'></div>");
								if(start < end) start.setDate(start.getDate()+1);
							}
							else if($("#day_"+j).html() == end.getDate()){
								$("#day_"+j).parent("tr").children("td:eq(2)").append("<div title='"+data[i].scheName+"' style='margin-left:10px; width:20px; height:20px; float:left; background:"+data[i].scheColor+"'></div>");
								if(start < end) end.setDate(end.getDate()-1);
							}
						}
						
					}
					
//				}
				
				else{ //일정이 하루 미만이라면
//				console.log(start.getDate());
					//td#day_1~7와 비교해서 일치하면 값 넣어주기
					for(var j=1; j<8; j++){
						if($("#day_"+j).html() == start.getDate()){
							console.log(i+"번째 "+$("#day_"+j).html()+"   "+start.getDate() );
							$("#day_"+j).parent("tr").children("td:eq(2)").append("<div style='margin-left:10px; width:20px; height:20px; border-radius:20px; float:left; background:"+data[i].scheColor+"'></div><p style='float:left; margin:0 0 0 10px;'>"+data[i].scheName+"</p>");
						}
					}
				}
			}
			
		},
		error: (x,s,e) =>{
			console.log("에러"+x,s,e);
		}
	});
	$("#informSched").css("visibility","hidden");
	//일정 색깔 안내표
	var $schedCircle = $("#informSched").children("div");
	$schedCircle.addClass("floatLeft");
	$("#informSched").children("p").css("margin","0 10px")
									.addClass("floatLeft");
	

	 $(".hover_").hover(function(){
		 $("#informSched").css("visibility","visible");
		 $(this).css("cursor","pointer");
     }, function(){
    	 $("#informSched").css("visibility","hidden");
     });

	
	
});