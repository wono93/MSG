$(document).ready(function(){
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