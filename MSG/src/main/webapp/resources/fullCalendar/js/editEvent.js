/* ****************
 *  일정 편집
 * ************** */
var editEvent = function (event, element, view) {
	
	

    $('.popover.fade.top').remove();
    $(element).popover("hide");

    if (event.allDay === true) {
        editAllDay.prop('checked', true);
    } else {
        editAllDay.prop('checked', false);
    }

    if (event.end === null) {
        event.end = event.start;
    }

    if (event.allDay === true && event.end !== event.start) {
        editEnd.val(moment(event.end).subtract(1, 'days').format('YYYY-MM-DD HH:mm'))
    } else {
        editEnd.val(event.end.format('YYYY-MM-DD HH:mm'));
    }

    //jsp에 값 담아주기
    editId.val(event._id); //임의 선언 (DB에서 정해줬던 값)
    modalTitle.html('일정 수정');
    editTitle.val(event.title);
    editStart.val(event.start.format('YYYY-MM-DD HH:mm'));
    editType.val(event.type);
    editDesc.val(event.description);
    	console.log(event.description);
    editColor.val(event.backgroundColor).css('color', event.backgroundColor);
    //추가사항
//    empNo.val(event.empNo);
//    	console.log(event.empNo);
//    empName.val(event.empName);
//    	console.log(event.username);
//    deptName.val(event.deptName);
//    jobName.val(event.jobName);

    addBtnContainer.hide();
    modifyBtnContainer.show();
    eventModal.modal('show');
    $("#text").remove();

    //업데이트 버튼 클릭시
    $('#updateEvent').unbind();
    $('#updateEvent').on('click', function () {

        if (editStart.val() > editEnd.val()) {
            alert('끝나는 날짜가 앞설 수 없습니다.');
            return false;
        }

        if (editTitle.val() === '') {
            alert('일정명은 필수입니다.')
            return false;
        }

        var statusAllDay;
        var startDate;
        var endDate;
        var displayDate;

        if (editAllDay.is(':checked')) {
            statusAllDay = true;
            startDate = moment(editStart.val()).format('YYYY-MM-DD');
            endDate = moment(editEnd.val()).format('YYYY-MM-DD');
            displayDate = moment(editEnd.val()).add(1, 'days').format('YYYY-MM-DD');
        } else {
            statusAllDay = false;
            startDate = editStart.val();
            endDate = editEnd.val();
            displayDate = endDate;
        }

        eventModal.modal('hide');

       
        event.allDay = statusAllDay;
        event.title = editTitle.val();
        event.start = startDate;
        event.end = displayDate;
        event.type = editType.val();
        event.backgroundColor = editColor.val();
        event.description = editDesc.val();
        //추가사항
        event._id = editId.val();
//        event.empNo = empNo.val();
//        console.log(event.empNo);
//        event.empName = empName.val();
//        event.deptName = deptName.val();
//        event.jobName = jobName.val();
        
//        var schedule ={
//        		
//        		
//        }
        

        $("#calendar").fullCalendar('updateEvent', event);
        	
        
        //일정 업데이트
        $.ajax({
            type: "post",
            url: getContextPath()+"/sched/updateSched",
            data: {
            	scheCode : event._id,
        		scheCate : event.type,
        		empNo : 123,
//        		empName : event.username,
//        		deptName : event.deptName,
//        		jobName : event.jobName,
        		scheName : event.title ,
        		scheStart : event.start,
        		scheEnd : event.end,
        		scheColor : event.backgroundColor,
        		scheEx : event.description,
        		alldayYn : event.allDay	
            },
            dataType: "json",
            success: function (response) {
            	console.log(response);
                alert('수정되었습니다.');
            },
            error:(x,s,e)=>{
            	alert("empNo"+ data.empNo );
            	console.log(x,s,e);
            }
        });

    });

    // 삭제버튼
    $('#deleteEvent').on('click', function () {
        $('#deleteEvent').unbind();
        $("#calendar").fullCalendar('removeEvents', [event._id]);
        eventModal.modal('hide');

        //삭제시
        $.ajax({
            type: "delete",
            url: getContextPath()+"/sched/deleteSched/"+event._id,
            data: {
                
            },
            success: function (response) {
            	console.log(response);
                alert('삭제되었습니다.');
            }
        });
    });
};