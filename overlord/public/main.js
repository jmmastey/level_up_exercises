
var timer = document.getElementById("timer");
console.log(timer);

var submit = document.getElementById("deactivate");
submit.addEventListener('click', submitHandler);

timer.innerHTML = "30 seconds";
countdown();

function validCode(input_code) {
	console.log(input_code);
	var deactivation_code = localStorage.getItem("deactivation_code") 
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
	console.log(input);
	if (validCode(input)) {
		console.log("validCode")}
	
}


function countdown() {
	var remaining = 30;
	var countdown_timer = setInterval(function(){
		var str = --remaining + " seconds";
		timer.innerHTML = str;
		// session[]
		if (remaining < 0) {
			clearInterval(countdown_timer);
		}
	}, 1000);
}