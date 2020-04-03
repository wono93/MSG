//contextPath 구하기
function getContextPath() { 
	return window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
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
        
        //체크된 회의실코드 input:hidden에 담아주기
//        $('input[name="conf"]').click(function () {
//            let radioVal = $('input[name="conf"]:checked').val();
//        	$('#croomCode').val(radioVal);
//        	console.log($('#croomCode').val());
//        });
        
        //체크된 차량코드 input:hidden에 담아주기
//        $('input[name="car"]').click(function () {
//            let radioVal = $('input[name="car"]:checked').val();
//            let radioVal = $(this).val();
//        	$('#carCode').val(radioVal);
//        	console.log($('#carCode').val());
//        });
        
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
        });
        
        //차량 추가 시 체크된 차량카테고리와 해당 sequence를 input:hidden에 담아두기
        $('input[name="car-cate_"]').click(()=>{
        	var carCate = $('input[name="car-cate_"]:checked').val();
        	$("#addCar-cate").val(carCate);
        });
        
        
        /********************* 회의실/법인차량 수정 Modal***************/
        
        $("#update-conf").click(()=>{
        	$("#updateConfModal").css("display","block");
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
       
        
        
});
            
            


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
	var psValueStr = person.value();
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
	var re = /^[0-9]{2}[\s]*[가~힣]{1}[\s]*[0-9]{4}/gi;
	if(!re.test(carNoValid.val())){
		alert("차량번호는 숫자 2자리 + 한글 1자리 + 숫자 4자리입니다. \n확인 후 다시 입력해주세요.");
		return false;
	}
	
	var whichFrmId = $checkedParent.parent("form").attr('id');
	
	if(whichFrmId.contains('add')){
		document.getElementById('addCarFrm').submit();
	}
	else if(whichFrmId.contains('update')){
		document.getElementById('updateCarFrm').submit();
	}
	//이미 등록된 차량과 동일한 경우
	
}
