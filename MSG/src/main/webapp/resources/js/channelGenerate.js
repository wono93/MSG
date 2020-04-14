var arr = new Array(); 
hdjq(document).ready(function(){
	arr.push(empNo);
//	console.log(arr);
	
    // Get the modal
    var channelModal = document.getElementById("channelGenModal");

    // Get the button that opens the modal
    var channelBtn = document.getElementById("plus-icon");

    // Get the <span> element that closes the modal
    var channelSpan = document.getElementsByClassName("close")[0];

    // When the user clicks on the button, open the modal
    channelBtn.onclick = function () {
    	channelModal.style.display = "block";
    }

    // When the user clicks on <span> (x), close the modal
    channelSpan.onclick = function () {
    	channelModal.style.display = "none";
    }

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function (event) {
        if (event.target == channelModal) {
        	channelModal.style.display = "none";
        }
    }
});

function searchMemberCh(){
	var chKeyword = hdjq("input[name=chKeyword").val();
	
	var chSearchType = hdjq("input[name=chSearchType]:checked").val();
	hdjq.ajax({
		type:"GET",
		url:"/msg/chat/searchListCh.do",
		data:{
			keyword: chKeyword,
			searchType: chSearchType
		},
		dataType: "json",
		success : function(data) {
			
//			console.log(chSearchType+", "+chKeyword);
			
			for (var i = 0; i < data.length; i++) {
				addChMember(data[i]['empImage'], data[i]['empName'], data[i]['deptName'], data[i]['jobName'], data[i]['empNo']);
			}
		}
	});
}


function addChMember(empImage, empName, deptName, jobName, empNo){
	
	for(var i=0; i<arr.length; i++){
		if(empNo == arr[i])
			return false;
	}
	
	hdjq("#ch-member-table").append('<tr>'	
            +'<td><img src="/msg/resources/upload/empImg/'+empImage+'" id="ch-member-list-img" class="ch-member-img"></td>'
            +'<td>'+empName+'</td>'
            +'<td>'+deptName+'</td>'
            +'<td>'+jobName+'</td>'
            +'<td class="delNo">'+empNo+'</td>'
            +'<input type="hidden" name="empNo" value="'+empNo+'">'
            +'<td><a href="#">img src="/msg/resources/image/X-icon.png" class="x-icon" onclick="deleteMember(this)"></td></a>'
            +'</tr>');
	
	arr.push(empNo);
	
//	console.log(arr);
}
function deleteMember(obj){
	var delTr = hdjq(obj).parents("tr");
	hdjq(delTr).remove();
	var delNo = hdjq(obj).parents("tr").find(".delNo").html();
	arr.splice(arr.indexOf(delNo),1);
}




















