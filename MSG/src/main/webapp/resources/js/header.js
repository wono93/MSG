hdjq(function(){
    hdjq("nav.primnav .userinfo idSection idSection").hide();
})

hdjq(function(){
    hdjq("#hamburger").change(function(){
        if(hdjq("input:checkbox[id='hamburger']").is(":checked")){
            hdjq("input:checkbox[id='hamburger']").attr("disabled", true);
            setTimeout(function(){
                var targetImg = document.querySelector("nav.primnav .userinfo img");
                var playerImg = targetImg.animate([
                    {transform: 'translate(0)'},
                    {transform: 'translate(105px, 30px) scale(2.8)'},
                ], 300);
                playerImg.addEventListener('finish', function(){
                    targetImg.style.transform = 'translate(105px, 30px) scale(2.8)';
                });
                hdjq("nav.primnav .userinfo idSection idSection").fadeIn(300);
                hdjq(".primnav .icon").css("paddingLeft", "50px");
                hdjq("input:checkbox[id='hamburger']").attr("disabled", false);
            }, 500);
        }
        else if(hdjq("input:checkbox[id='hamburger']").is(":checked")==false){
            hdjq("input:checkbox[id='hamburger']").attr("disabled", true);
            setTimeout(function(){
                var targetImg = document.querySelector("nav.primnav .userinfo img");
                var playerImg = targetImg.animate([
                    {transform: 'translate(105px, 30px)'},
                    {transform: 'translate(0px, 0px) scale(1)'},
                ], 100);
                playerImg.addEventListener('finish', function(){
                    targetImg.style.transform = 'translate(0px, 0px) scale(1)';
                });
                hdjq("nav.primnav .userinfo idSection idSection").fadeOut(100);
                hdjq(".primnav .icon").css("paddingLeft", "19px");
                hdjq("input:checkbox[id='hamburger']").attr("disabled", false);
            }, 500);
        }
    });
})

hdjq(function(){
    hdjq(".dmBar").hide();
})
hdjq(function(){
	hdjq("#dmWindow").click(function(){
			hdjq(".dmBar").fadeIn(100);
        })
        hdjq("#dmClose").click(function(){
        	hdjq(".dmBar").fadeOut(100);
        })
})
