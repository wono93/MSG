var chjq = jQuery.noConflict();
var arrModify = new Array();
chjq(document).ready(function(){
	arrModify.push(empNo);
    // Get the modal
    var channelModifyModal = document.getElementById("channelModifyModal");

    // Get the button that opens the modal
    var channelModifyBtn = document.getElementById("addMemberModify");
    
    // Get the <span> element that closes the modal
    var channelModifySpan = document.getElementsByClassName("closeModify")[0];

    // When the user clicks on the button, open the modal
    channelModifyBtn.onclick = function () {
    	channelModifyModal.style.display = "block";
    }

    // When the user clicks on <span> (x), close the modal
    channelModifySpan.onclick = function () {
    	channelModifyModal.style.display = "none";
    }

    // When the user clicks anywhere outside of the modal, close it
//    window.onclick = function (event) {
//        if (event.target == channelModifyModal) {
//        	channelModifyModal.style.display = "none";
//        }
//    }
    
    var chNo = chjq("#inputChNo").val();
//    console.log("chNo="+chNo);
    
    chjq("#addMemberModify").click(function(){	
    	presentList();
    });
});
function presentList(){
	chjq.ajax({
		type:"GET",
		url:"/msg/chat/modifyChannel.do",
		data:{
			chNo: chNo
		},
		dataType: "json",
		success : function(data) {
			for (var i = 0; i < data.length; i++) {
				addModifyMember(data[i]['empImage'], data[i]['empName'], data[i]['deptName'], data[i]['jobName'], data[i]['empNo']);
			}
		}
	});
}
function deleteChannel(){
	chjq.ajax({
		type:"Post",
		url:"/msg/chat/deleteChannel.do",
		data:{
			chNo: chNo
		},
		success : function(data) {
			alert("채널이 삭제되었습니다.");
			location.href="/msg/chat/main.do";
		}
	});
}

function searchMemberModify(){
	var chModifyKeyword = chjq("input[name=chModifyKeyword").val();
	
	var chModifySearchType = chjq("input[name=chModifySearchType]:checked").val();
	chjq.ajax({
		type:"GET",
		url:"/msg/chat/searchListCh.do",
		data:{
			keyword: chModifyKeyword,
			searchType: chModifySearchType
		},
		dataType: "json",
		success : function(data) {
			for (var i = 0; i < data.length; i++) {
				addModifyMember(data[i]['empImage'], data[i]['empName'], data[i]['deptName'], data[i]['jobName'], data[i]['empNo']);
			}
		}
	});
}



function addModifyMember(empImage, empName, deptName, jobName, empNo){
	
	for(var i=0; i<arrModify.length; i++){
		if(empNo == arrModify[i])
			return false;
	}
	var regEmpNo = chjq("input[name=regEmpNo]").val();
//	console.log(regEmpNo);
	if(regEmpNo == empNo){
		chjq("#ch-modify-member-table").append('<tr>'	
	            +'<td><img src="/msg/resources/upload/empImg/'+empImage+'" id="ch-member-list-img" class="ch-member-img"></td>'
	            +'<td>'+empName+'</td>'
	            +'<td>'+deptName+'</td>'
	            +'<td>'+jobName+'</td>'
	            +'<input type="hidden" name="empNo" value="'+empNo+'">'
	            +'<td class="delNo">'+empNo+'</td>'
	            +'</tr>');
	}else{
		
		chjq("#ch-modify-member-table").append('<tr>'	
		        +'<td><img src="/msg/resources/upload/empImg/'+empImage+'" id="ch-member-list-img" class="ch-member-img"></td>'
		        +'<td>'+empName+'</td>'
		        +'<td>'+deptName+'</td>'
		        +'<td>'+jobName+'</td>'
		        +'<td class="delNo">'+empNo+'</td>'
		        +'<input type="hidden" name="empNo" value="'+empNo+'">'
		        +'<td><img src="/msg/resources/image/X-icon.png" alt="" class="x-icon" id="" onclick="deleteModifyMember(this)"></td>'
		        +'</tr>');
	}
	arrModify.push(empNo);
	
//	console.log(arrModify);
}
function deleteModifyMember(obj){
	var delTr = chjq(obj).parents("tr");
	chjq(delTr).remove();
	var delNo = chjq(obj).parents("tr").find(".delNo").html();
	arrModify.splice(arrModify.indexOf(delNo),1);
	

//	console.log(arrModify);
}




















