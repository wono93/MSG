//contextPath 구하기
function getContextPath() { 
	return window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
}

function test(){
		$(".ajaxHide-tr").css("cursor","pointer");
	
		 $('.res-table').contextMenu({
		        selector: '.ajaxHide-tr',
		        trigger: 'left',
		        callback: function(key, options){
		        			//contextMenu에서 '예약내역수정'을 클릭한 경우
				        	if(key == 'edit'){
				        		$("#updateResModal").css("display", "block");
				        	}
				        	
				        		
//				            //contextMenu에서 '예약내역삭제'를 클릭한 경우
				        	if(key == 'delete'){
				              	let result = confirm('정말 이 예약내역을 삭제하시겠습니까?');
				              	if(result == true){
				              		var delConfirm = prompt('정말 삭제하시려면 "삭제"라고 타이핑해주세요.', '');
				              		if(delConfirm != null){
				              			if(delConfirm == "삭제"){
				              				
				              				console.log("삭제 직전");
				              				$.ajax({
				              					type:"delete",
				              					url:getContextPath()+"/res/delRes/"+$(this).children("td:eq(1)").text()+"/"+$(this).children(".displayNone").text(),
//				              					data : {resCode : $(this).children("td:eq(1)").text(),
//				              						    resCate : $(this).children(".displayNone").text()},
				              					dataType:"json",
				              					success: data =>{},
				              					error: (x,s,e) => {
				              						console.log(x,s,e);
				              					},
				              					complete:()=>{
				              						//리로드해서 삭제된 화면 반영하기
				              						location.reload();
				              					}
				              				});
				              				
				              			}
				              			else{
				              				alert('입력이 틀렸습니다. \n삭제하시려면 다시 맞게 입력해주세요.');
				              			}
				              		}
				              	}
				        		
				             }
				            
				    console.log($(this).children("td:eq(1)").text());
		        	console.log($(this).children(".displayNone").text());
		        },
		        items: {
		        	"edit": { name: "예약내역 수정", icon : "edit" },
//				                "items": {} //contextMenu를 이중으로 해서 바로 input:radio/text로 수정하고 싶었으나, 새로 값을 입력해서 보내는 건 가능하나 이미 보이는 value를 불러올 순 없었다 (undefined) 그냥 모달로 수정하기 해야지,,
				   "delete": {name: "예약내역 삭제", icon: "delete"},
		            "sep1": "---------",
		            "quit": {name: "취소", icon: function($element, key, item){ return 'context-menu-icon context-menu-icon-quit'; }}
		        }
		    });
}


/**
* conf & car
 */
 $(document).ready(function(){
	 
	
    //아이콘 클릭 시 dateTimePicker focus
    	$('.starticon').click(function(){
            $('#timepicker-start').focus();
        });
        $('.endicon').click(function(){
            $('#timepicker-end').focus();
        });
        
        //로그인된 멤버가 일반사원이라면, 테이블의 margin-bottom 50px
        if(true){
        	$(".res-table tr:last-child").css("margin-bottom","50px");
        }
        
        
        /****************** 회의실/법인차량 추가 Modal*******************/
        $("#add-conf").click(()=>{
        	$("#addConfModal").css("display","block");
        });
        
        $("#add-car").click(()=>{
        	$("#addCarModal").css("display", "block");
        });
        
        $(".close").click(()=>{
        	$("#addConfModal").css("display", "none");
        	$("#addCarModal").css("display", "none");
        	$("#updateConfModal").css("display", "none");
        	$("#updateCarModal").css("display", "none");
        	$("#updateResModal").css("display", "none");
        });
        
        //차량 추가 시 체크된 차량카테고리와 해당 sequence를 input:hidden에 담아두기
        $('input[name="car-cate_"]').click(()=>{
        	var carCate = $('input[name="car-cate_"]:checked').val();
        	$("#addCar-cate").val(carCate);
        });
        
        
        /********************* 회의실/법인차량 수정 Modal***************/
        
        $("#update-conf").click(()=>{
        	
        	var $selectedConf = $('[name="conf"]:checked');
        	
        	if($selectedConf.val() == undefined){
        		alert('수정할 회의실을 먼저 선택해주셔야 합니다.');
        		return false;
        	}
        	
        	$("#updateConfModal").css("display","block");
        	var $sConfParent = $selectedConf.parent().parent().parent();
        	
        	$("#updateConf-title").val($sConfParent.children("td:eq(1)").text());
        	$("#person").val($sConfParent.children("td:eq(2)").text());
        });
        //선택한 라디오의 값을 Modal에 불러오기
        $("#update-car").click(()=>{
        	
        	//차량 중 선택된 라디오. 수정 및 삭제에서 모두 쓰임
        	var $selectedCar = $('input[name="car"]:checked');  
        	

        	//라디오버튼으로 수정할 차량이 선택되지 않을 경우
        	if($selectedCar.val() == undefined){
        	  alert("수정할 차량을 먼저 선택해주셔야 합니다.");
        	  return false;
        	}
        	
        	$("#updateCarModal").css("display", "block");
        	var $sCarParent = $selectedCar.parent().parent().parent();
        	var carComType = $sCarParent.children("td:eq(2)").text();
        	
            var split = carComType.split( " / " ); // " / " 기준으로 한 td 안의 "제조사 / 차종" 떼어내기
            let update_company = split[0];	//제조사
            let update_type = split[1];		//차종
            let update_cate = $sCarParent.children("td:eq(1)").text();
        
            //체크한 해당 차량의 정보 수정모달에 담기
        	//$("#updateCar-code").val($selectedCar.val());
            //해당 value의 radio를 선택하기
            $('input:radio[name="car-cate_"][value='+update_cate+']').prop('checked', true);
            
            
        	$("#updateCar-cate").val(update_cate);
        	$("#updateCar-company").val(update_company);
        	$("#updateCar-type").val(update_type);
        	$("#updateCar-no").val($sCarParent.children("td:eq(3)").text());
        	$("#person_").val($sCarParent.children("td:eq(4)").text());
        });
        
        /********************* 회의실/법인차량 삭제***************/
        $("#del-car").click(()=>{
        	//선택된 라디오 차량번호 
            var carCode = $('input[name="car"]:checked').val();
        	//라디오버튼으로 수정할 차량이 선택되지 않을 경우
        	if(carCode == undefined){
        	  alert("삭제할 차량을 먼저 선택해주셔야 합니다.");
        	  return false;
        	}
        	
        	let result = confirm('정말 이 차량을 삭제하시겠습니까?');
        	if(result == true){
        		var delConfirm = prompt('정말 삭제하시려면 "삭제"라고 타이핑해주세요.', '');
        		if(delConfirm != null){
        			if(delConfirm == "삭제"){
        				
        				$.ajax({
        					url:getContextPath()+"/res/delCar/"+carCode,
        					dataType:"json",
        					type:"delete",
        					success: data =>{
        						alert(data.msg);
        					},
        					error: (x,s,e) => {
        						console.log(x,s,e);
        					},
        					complete:()=>{
        						//리로드해서 삭제된 화면 반영하기
        						location.reload();
        					}
        				});
        			}
        			else{
        				alert('입력이 틀렸습니다. \n삭제하시려면 다시 맞게 입력해주세요.');
        			}
        		}
        	}
        });
/*************************** 예약 확인 페이지 ****************************/      
/** res **/
$('.startendicon').click(function(){
    $("#timepicker-startend").focus();
});        
	//기본상태 : 회의실예약내역 + 차량예약내역
	$("#confList-div").hide();
	$("#carList-div").hide();
	
	//예약 내역이 없을경우
	if($(".ajaxHide-tr").length == 0){
	youHaveNoRes();
	}
 
	//전체 / 회의실 / 차량 카테고리 선택값이 바뀔 때마다
	$("[name=cate]").change(()=>{
		
		//$(".ajaxHide-tr").trigger("contextMenu"); 
	 	
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
	 	//예약 내역이 없을 경우
	 	if($(".ajaxHide-tr").length == 0){
	 		youHaveNoRes();
	 	}
	 	//
	 	//$(".ajaxHide-tr").trigger("contextMenu");
	 	test();
	 	
	 });  
	
	test();
	
	
});//온레디 함수 끝
            
            


// Initialization
$('#my-element').datepicker(minutesStep)
// Access instance of plugin
$('#my-element').data('datepicker')

// Create start date
var start = new Date(),
    prevDay,
    startHours = 9;

// 09:00 AM
start.setHours(9);
start.setMinutes(0);

// If today is Saturday or Sunday set 10:00 AM
if ([6, 0].indexOf(start.getDay()) != -1) {
    start.setHours(10);
    startHours = 10
}

$('#timepicker-start').datepicker({
    timepicker: true,
    language: 'ko',
    startDate: start,
    minHours: startHours,
    maxHours: 18,
    minutesStep: 30,
    onSelect: function (fd, d, picker) {
    	$(picker.el).trigger('change');
    	
        // Do nothing if selection was cleared
        if (!d) return;
        
        console.log(fd);
        console.log(d);
        console.log(picker);
        

        var day = d.getDay();

        // Trigger only if date is changed
        if (prevDay != undefined && prevDay == day) return;
        prevDay = day;

        // If chosen day is Saturday or Sunday when set
        // hour value for weekends, else restore defaults
        if (day == 6 || day == 0) {
            picker.update({
                minHours: 10,
                maxHours: 16
            })
        } else {
            picker.update({
                minHours: 9,
                maxHours: 18
            })
        }
    }

});

//수용인원 input 가져오기
function getPersonValue() {
	var person = document.getElementById('person');
	var psValueStr = person.value;
	console.log(psValueStr);
	return Number(psValueStr);
}
//수용인원++
function plus() {
	var person = document.getElementById('person');
	var psValue = getPersonValue();
	psValue = psValue + 1;
	person.value = psValue;
}
//수용인원--
function minus() {
	var person = document.getElementById('person');
	var psValue = getPersonValue();
	psValue = psValue - 1;
	person.value = psValue;
}

//회의실 추가나 수정 버튼 클릭 시 수행되는 회의실 유효성검사
function confValidate(){
	if($("#addConf-title").val() == ""){
		alert("회의실 이름을 입력해주세요.");
		return false;
	}
	
	var whichFrmId = $checkedParent.parent("form").attr('id');
	
	if(whichFrmId.contains('add')){
		document.getElementById('addCarFrm').submit();
	}
	else if(whichFrmId.contains('update')){
		document.getElementById('updateCarFrm').submit();
	}
}

//차량 추가나 수정 버튼 클릭시 수행되는 차량 유효성검사
function carValidate(){
	var $checked = $("[name=car-cate_]:checked");
	//차량카테고리  null시
	if($checked.val() == ""){
		alert("차량타입을 선택해주세요.");
		return false;
	}
	
	var $checkedParent = $checked.parentsUntil("form");
	//제조사 null시
	var carCompValid = $checkedParent.siblings("input[name='carCompany']");
	if(carCompValid ==""){
		alert("차량의 제조사를 꼭 입력해주세요.");
		return false;
	}
	//차종 null시
	var carTypeValid = $checkedParent.siblings("input[name='carType']");
	if(carTypeValid == ""){
		alert("차종을 꼭 입력해주세요.");
		return false;
	}
	//차량번호 null시
	var carNoValid = $checkedParent.siblings("input[name='carNo']");
	if(carNoValid == ""){
		alert("차량번호를 꼭 입력해주세요.");
		return false;
	}
	
	//차량번호 유효성검사 
//	var re = /^[0-9]{2}[\s]*[가~힣]{1}[\s]*[0-9]{4}/gi;
//	if(!re.test(carNoValid.val())){
//		alert("차량번호는 숫자 2자리 + 한글 1자리 + 숫자 4자리입니다. \n확인 후 다시 입력해주세요.");
//		return false;
//	}
	var whichFrmId = $checkedParent.parent("form").attr('id');
	
	console.log(whichFrmId);
	if(whichFrmId=='addCarFrm'){
		document.getElementById('addCarFrm').submit();
	}
	else if(whichFrmId=='updateCarFrm'){
		document.getElementById('updateCarFrm').submit();
	}
	//이미 등록된 차량과 동일한 경우
	
}


