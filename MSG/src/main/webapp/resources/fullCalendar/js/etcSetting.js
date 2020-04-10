//달력 위쪽에 어떤 부서인지 표시하기
function markDept(){
	$(".fc-left").prepend("<div id='calDept'></div>");
	$("#calDept").append("<p id='calDeptP'></p>")
	.children().text($("#userDeptName").val()+" 일정");
	
	$("#calDeptP").css({"font-size":"20px", "font-weight":"600", "margin":"0 20px 0 30px"});
	
	$(".fc-listWeek-button").attr('id','listWeekBtn');
}

//SELECT 색 변경
$('#edit-color').change(function () {
    $(this).css('color', $(this).val());
});


//일정별 필터
$("#type_filter").select2({
    placeholder: "일정 규모 선택",
    allowClear: true
});

//datetimepicker
$("#edit-start, #edit-end").datetimepicker({
    format: 'YYYY-MM-DD HH:mm'
});

//$(document).ready(function(){
//	$('.filter').change(()=>{
//		 $('#calendar').fullCalendar('rerenderEvents');
//	});
//});



