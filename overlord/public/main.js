
var timer = document.getElementById("timer");
console.log(timer);

var submit = document.getElementById("deactivate");
submit.addEventListener('click', submitHandler);

time_remaining = localStorage.getItem("remaining");

if (time_remaining <= 30 && time_remaining > 0){ 
	timer.innerHTML = time_remaining;}
else {
	timer.innerHTML = 30;
	localStorage.setItem("remaining",30);
	}
console.log(time_remaining)

countdown(time_remaining);

function validCode(input_code) {
	console.log(input_code); 
	if (input_code === deactivation_code) {
 		console.log("correct deactivation code");
		return true;
	} else {
		console.log("incorrect deactivation code");
		return false;
	}
}
function submitHandler(e) {
	e.preventDefault();
	var input = document.getElementById('code').value;
	console.log("input", input);
	if (validCode(input)) {
		console.log("valid code entered")
		// change bomb state on server

		$.post( "/state", {'input': input}, function( data ) {
			console.log(data);
  			console.log("successful response from server");
  			window.location.href = "/activate";
		});
	}
}


function countdown(remaining) {
	//var remaining = 30;
	var countdown_timer = setInterval(function(){
		var str = --remaining + " seconds";
		timer.innerHTML = str;
		// session[]
		
		if (remaining < 0) {
			clearInterval(countdown_timer);
			//change bomb state to detonated on server
			window.location.href = "/detonate";
		} else {
			localStorage.setItem("remaining", remaining);
		}

	}, 1000);
}