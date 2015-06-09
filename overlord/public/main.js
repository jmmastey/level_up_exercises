
var timer = document.getElementById("timer");
console.log(timer);

timer.innerHTML = "30 seconds";
countdown();

function countdown() {
	var remaining = 30;
	var countdown_timer = setInterval(function(){
		var str = --remaining + " seconds";
		timer.innerHTML = str;
		if (remaining < 0) {
			clearInterval(countdown_timer);
		}
	}, 1000);
}