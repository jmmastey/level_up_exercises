
var seconds;
var temp;

function countdown() {

    seconds = document.getElementById('time').innerHTML;
    seconds = parseInt(seconds, 10);

    if (seconds == 1) {
        document.getElementById("countdown").value = "over"
        document.getElementById("deactivation").submit();
    }

    seconds--;
    temp = document.getElementById('time');

    temp.innerHTML = seconds;
    timeoutMyOswego = setTimeout(countdown, 1000);
}


