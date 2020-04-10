hdjq(document).ready(function(){
    // Get the modal
    var channelModifyModal = document.getElementById("channelModifyModal");

    // Get the button that opens the modal
    var channelModifyBtn = document.getElementById("addmember");
    
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
    function presentMember(){
    	hdjq.ajax({
    		type:"GET",
    		url:"/msg/chat/modifyChannel.do",
    		data:{
    			chNo: chNo
    		},
    		dataType: "json",
    		success : function(data) {
//    			console.log(chSearchType+", "+chModifyKeyword);
    			for (var i = 0; i < data.length; i++) {
    				addChMember(data[i]['empImage'], data[i]['empName'], data[i]['deptName'], data[i]['jobName'], data[i]['empNo']);
    			}
    		}
    	});
    }
});

function searchMemberCh(){
	var chModifyKeyword = hdjq("input[name=chModifyKeyword").val();
	
	var chModifySearchType = hdjq("input[name=chModifySearchType]:checked").val();
	hdjq.ajax({
		type:"GET",
		url:"/msg/chat/searchListCh.do",
		data:{
			keyword: chModifyKeyword,
			searchType: chModifySearchType
		},
		dataType: "json",
		success : function(data) {
//			console.log(chSearchType+", "+chModifyKeyword);
			for (var i = 0; i < data.length; i++) {
				addChMember(data[i]['empImage'], data[i]['empName'], data[i]['deptName'], data[i]['jobName'], data[i]['empNo']);
			}
		}
	});
}


var arr = new Array(); 

function addChMember(empImage, empName, deptName, jobName, empNo){
	
	for(var i=0; i<arr.length; i++){
		if(empNo == arr[i])
			return false;
	}
		
	hdjq("#ch-member-table").append('<tr>'	
            +'<td><img src="/msg/resources/image/'+empImage+'" id="ch-member-list-img" class="ch-member-img"></td>'
            +'<td>'+empName+'</td>'
            +'<td>'+deptName+'</td>'
            +'<td>'+jobName+'</td>'
            +'<td class="delNo">'+empNo+'</td>'
            +'<input type="hidden" name="empNo" value="'+empNo+'">'
            +'<td><img src="/msg/resources/image/X-icon.png" alt="" class="x-icon" id="" onclick="deleteMember(this)"></td>'
            +'</tr>');
	
	arr.push(empNo);
	
	console.log(arr);
}
function deleteMember(obj){
	var delTr = hdjq(obj).parents("tr");
	hdjq(delTr).remove();
	var delNo = hdjq(obj).parents("tr").find(".delNo").html();
	arr.splice(arr.indexOf(delNo),1);
}




















