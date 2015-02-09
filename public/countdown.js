countdown = function(seconds_left){
  var countdown = document.getElementById('countdown');

  var interval = setInterval(function (){
    if (seconds_left > 0) {
      seconds_left--;
      countdown.innerHTML = seconds_left.toHHMMSS()
    } else {
      countdown.innerHTML = 'Bomb has exploded!';
      clearInterval(interval);
      location.reload();
    }
  }, 1000);
};

Number.prototype.toHHMMSS = function(){
  var hours = Math.floor(this / 3600);
  var minutes = Math.floor((this - (hours * 3600)) / 60);
  var seconds = this - (hours * 3600) - (minutes *60);

  if (hours   < 10) { hours   = "0"+hours; }
  if (minutes < 10) { minutes = "0"+minutes; }
  if (seconds < 10) { seconds = "0"+seconds; }

  return hours+':'+minutes+':'+seconds;
};