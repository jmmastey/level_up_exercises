
var timer = document.getElementById("timer");
var submit = document.getElementById("deactivate");

submit.addEventListener('click', submitHandler);

time_remaining = localStorage.getItem("remaining");

if (time_remaining <= 30 && time_remaining > 0){ 
	timer.innerHTML = time_remaining + " seconds";}
else {
	timer.innerHTML = "30 seconds";
	localStorage.setItem("remaining", 30);
	}

countdown(time_remaining);

function validCode(input_code) {
	if (input_code === deactivation_code) {
		return true;
	} else {
		return false;
	}
}

function submitHandler(e) {
	e.preventDefault();
	var input = document.getElementById('code').value;
		$.post( "/state", {'input': input}, function( data ) {
			if (data["valid"]) {
  			window.location.href = "/activate"; }
		});
	//}
}

function countdown(remaining) {
	var countdown_timer = setInterval(function(){
		var str = --remaining + " seconds";
		timer.innerHTML = str;
		
		if (remaining < 0) {
			clearInterval(countdown_timer);
			window.location.href = "/detonate";
		} else {
			localStorage.setItem("remaining", remaining);
		}
	}, 1000);
}