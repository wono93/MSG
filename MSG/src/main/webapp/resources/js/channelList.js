hdjq(document).ready(function(){
	var repeatChList = "";
	hdjq("#hamburger").change(function(){
        if(hdjq("input:checkbox[id='hamburger']").is(":checked")==true){
        	channelListFunction();
        	repeatChList = setInterval(function() {
        		console.log("header Channel List Reload!");
        		channelListFunction();
        	}, 3000);
        }
        else if(hdjq("input:checkbox[id='hamburger']").is(":checked")==false){
        	clearInterval(repeatChList);
        }
	});
});
function channelListFunction() {
	hdjq.ajax({
		type : "GET",
		url : "/msg/chat/headerChList.do",
		dataType: "json",
		success : function(data) {
			hdjq("#channelList").html('');
			for (var i = 0; i < data.length; i++) {
				addChList(data[i]['userId'], data[i]['chNo'], data[i]['chName']);
			}
		}
	});
}
function addChList(userId, chNo, chName) {
	hdjq("#channelList").append(
						 '<li>'+
			             '<a href="#" onclick="goChannel(this);">'+
			             '<i class="fas fa-circle" style="font-size:15px"></i>'+
			             '<span class="headerlistname">'+
			             '<input type="hidden" name="userId" value="'+userId+'">'+
			             '<input type="hidden" name="chNo" value="'+chNo+'">'+
			             '<input type="hidden" name="chName" value="'+chName+'">'+
			             chName+
			             '</span>'+
						 '</a>'+
						 '</li>');
}
function goChannel(obj){
	var inputUserId = hdjq(obj).find("input[name=userId]").val();
	var inputChNo = hdjq(obj).find("input[name=chNo]").val();
	var inputChName = hdjq(obj).find("input[name=chName]").val();
	//폼 태그 생성
	var form = document.createElement('form');
	//폼 속성 set attribute
	form.name = 'newForm';
	form.method = 'POST';
	form.action = '/msg/chat/channel.do';
	form.target = '_self';
	//input 태그 생성
	var input1 = document.createElement('input');
	var input2 = document.createElement('input');
	var input3 = document.createElement('input');
	//input태그에 set attribute
	input1.setAttribute("type", "hidden");
	input1.setAttribute("name", "userId");
	input1.setAttribute("value", inputUserId);
	input2.setAttribute("type", "hidden");
	input2.setAttribute("name", "chNo");
	input2.setAttribute("value", inputChNo);
	input3.setAttribute("type", "hidden");
	input3.setAttribute("name", "chName");
	input3.setAttribute("value", inputChName);
	//완성된 input 태그를 form에 append
	form.appendChild(input1);
	form.appendChild(input2);
	form.appendChild(input3);
	//form 태그
	document.body.appendChild(form);
	// form 제출
	form.submit();
}