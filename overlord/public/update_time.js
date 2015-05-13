var status_checker;

function updateTime() {
  var xmlhttp = new XMLHttpRequest();
  var txtFile = new XMLHttpRequest();

  xmlhttp.onreadystatechange=function() {
    if( xmlhttp.readyState == 4 ) { 
      if( xmlhttp.responseText > 0) {
        console.log(xmlhttp.responseText);
        document.getElementById("time_remaining").innerHTML = xmlhttp.responseText; }
      else {
        clearInterval(status_checker);   
        window.location.replace('/bombexploded'); }
      } 
    }
    xmlhttp.open("GET","/getremainingtime",true);
    xmlhttp.send();
}

function callUpdateTime() {
  status_checker = setInterval(updateTime,500);
}

callUpdateTime()
