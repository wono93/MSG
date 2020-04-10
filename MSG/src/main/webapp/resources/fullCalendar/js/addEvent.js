var eventModal = $('#eventModal');

var modalTitle = $('.modal-title');
var editAllDay = $('#edit-allDay');
var editTitle = $('#edit-title');
var editStart = $('#edit-start');
var editEnd = $('#edit-end');
var editType = $('#edit-type');
var editColor = $('#edit-color');
var editDesc = $('#edit-desc');

var editId = $('#edit-id');

//추가사항

//var empNo = $('.emp-no');
//var empName = $('.emp-name');
//var deptName = $('.dept-name');
//var jobName = $('.job-name');

var addBtnContainer = $('.modalBtnContainer-addEvent');
var modifyBtnContainer = $('.modalBtnContainer-modifyEvent');



/* ****************
 *  새로운 일정 생성
 * ************** */
var newEvent = function (start, end, eventType) {

    $("#contextMenu").hide(); //메뉴 숨김

    modalTitle.html('새로운 일정');
    editStart.val(start);
    editEnd.val(end);
    editType.val(eventType).prop("selected", true);
    
    editAllDay.val('');
    editTitle.val('');
    editColor.val('');
    editDesc.val('');

    addBtnContainer.show();
    modifyBtnContainer.hide();
    eventModal.modal('show');

    /******** 임시 RAMDON ID - 실제 DB 연동시 삭제 **********/
    var eventId = 1 + Math.floor(Math.random() * 1000);
    /******** 임시 RAMDON ID - 실제 DB 연동시 삭제 **********/

    //새로운 일정 저장버튼 클릭
    $('#save-event').unbind();
    $('#save-event').on('click', function () {

        var eventData = {
        		//event 구성내용을 만드는 부분인가봐
        	allDay: false, 		     //하루종일
            _id: eventId,			 //스케줄 고유ID
            title: editTitle.val(), //일정명
            start: editStart.val(), //시작
            end: editEnd.val(), 	//끝
            type: editType.val(),	//구분
            username: '',			//등록자 이름
            backgroundColor: editColor.val(),
            textColor: '#ffffff',
            description: editDesc.val(),	//설명
            
//            empNo : $("#userEmpNo").val(),
////          empName : $('#userEmpName').val(),
//            deptName: $('#userDeptName').val(),
//            jobName: $('#userJobName').val()
        };

        if (eventData.start > eventData.end) {
            alert('끝나는 날짜가 앞설 수 없습니다.');
            return false;
        }

        if (eventData.title === '') {
            alert('일정명은 필수입니다.');
            return false;
        }

        var realEndDay;

        if (editAllDay.is(':checked')) {
            eventData.start = moment(eventData.start).format('YYYY-MM-DD');
            //render시 날짜표기수정
            eventData.end = moment(eventData.end).add(1, 'days').format('YYYY-MM-DD');
            //DB에 넣을때(선택)
            realEndDay = moment(eventData.end).format('YYYY-MM-DD');

            eventData.allDay = true;
        }
         

        $("#calendar").fullCalendar('renderEvent', eventData, true);
        eventModal.find('input, textarea').val('');
        editAllDay.prop('checked', false);
        eventModal.modal('hide');
        
//        console.log(eventData.empNo);
//        console.log(eventData.username);
//        console.log(eventData.deptName);
//        console.log(eventData.jobName);
//        var schedule = {};
//        schedule.scheCode ='';
//        schedule.scheCate = eventData.type;
//    	schedule.empNo = eventData.empNo;
//    	schedule.empName = eventData.username;
//    	schedule.deptName = eventData.deptName;
//    	schedule.jobName = eventData.jobName;
//        schedule.scheName = eventData.title;
//        schedule.scheStart = eventData.start;
//        schedule.scheEnd = eventData.end;
//        schedule.scheColor = eventData.backgroundColor;
//        schedule.scheEx = eventData.description;
//        schedule.alldayYn = eventData.allDay;	
        		

        //새로운 일정 저장
        $.ajax({
            type: "post",
            url: getContextPath()+"/sched/insertSched",
            data: {
//            	scheCode : '',
            	scheCate : eventData.type,
//            	empNo : eventData.empNo,
//            	empName : eventData.username,
//            	deptName : eventData.deptName,
//            	jobName : eventData.jobName,
                scheName: eventData.title,
                scheStart : eventData.start,
                scheEnd : eventData.end,
                scheColor : eventData.backgroundColor,
                scheEx : eventData.description,
                alldayYn : eventData.allDay	
            },
//            data : schedule,
            dataType : "json",
            success: function (response) {
                //DB연동시 중복이벤트 방지를 위한
                $('#calendar').fullCalendar('removeEvents');
                $('#calendar').fullCalendar('refetchEvents');
            	//location.reload();
            },
            error:(x,s,e)=>{
            	console.log(x,s,e);
            }
        });
    });
};