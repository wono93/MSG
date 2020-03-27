
$(document).ready(function(){
    // Get the modal
    var flowModal = document.getElementById("flowModal");
    
    // Get the button that opens the modal
    var flowBtn = document.getElementById("flowBtn");
    
    // Get the <span> element that closes the modal
    var flowSpan = document.getElementById("closeBoxBtn");
    
    // When the user clicks on the button, open the modal
    flowBtn.onclick = function() {
      flowModal.style.display = "block";
    }
    
    // When the user clicks on <span> (x), close the modal
    flowSpan.onclick = function() {
      flowModal.style.display = "none";
    }
    
});
