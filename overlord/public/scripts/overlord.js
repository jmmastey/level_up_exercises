var deactivated = true;

function submitCode() {
  var code = document.forms[0].elements[0].value;
  var json = {"code":code};
  $.ajax({
    url: "/",
    type: "POST",
    data: json,
    success: function(data) {
      var jsonData = JSON.parse(data);
      analyzeData(jsonData);
      $("#codeForm")[0].reset();
    }
  });
}

function analyzeData(jsonObj) {
  if (jsonObj.status == 200) {
    hideWarning();
    if (jsonObj.state == "Activated") {
      activatedUpdates(jsonObj);
    } else if (jsonObj.state == "Deactivated") {
      deactivatedUpdates();
    } else { // Exploded
      explodedUpdates();
    }
  } else if (jsonObj.status == 401) {
    showInvalid();
    if (jsonObj.state == "Activated") {
      activatedUpdates(jsonObj);
    } else if (jsonObj.state == "Deactivated") {
      deactivatedUpdates();
    } else { // Exploded
      explodedUpdates();
      hideWarning();
    }
  } else { // 400 - not numerical format
    showInputWarning();
  }
}

function activatedUpdates(jsonObj) {
  deactivated = false;
  var bombState = "<span style=\"color:red\">Activated!</span>";
  var deactivateLabel = "To deactivate, enter your deactivation code: ";
  document.getElementById("bombState").innerHTML = bombState;
  document.getElementById("formLabel").innerHTML = deactivateLabel;
  if (jsonObj.attempts_remaining <= 0) {
    explodedUpdates();
  } else if (jsonObj.attempts_remaining < 3) {
    var attemptsRemaining = "(" + jsonObj.attempts_remaining;
    attemptsRemaining = attemptsRemaining + " attempts remaining!)";
    document.getElementById("AttemptsRemaining").innerHTML = attemptsRemaining;
  }
  timer(jsonObj['timer_end']);
}

function deactivatedUpdates() {
  deactivated = true;
  hideTimer();
  var activateLabel = "To activate, enter your activation code: ";
  document.getElementById("bombState").innerHTML = "Deactivated";
  document.getElementById("formLabel").innerHTML = activateLabel;
  document.getElementById("AttemptsRemaining").innerHTML = "";
}

function explodedUpdates() {
  deactivated = true;
  hideTimer();
  var explodedLabelText = "To deactiv ent fjds as;dfasåß∂¬ƒåƒ∆å…ßˆƒ˙Ω©∫˚∫´å: ";
  document.getElementById("bombState").innerHTML = "!@#$%^&*!@#&$!";
  document.getElementById("formLabel").innerHTML = explodedLabelText;
  document.getElementById("AttemptsRemaining").innerHTML = "";
  disableButtons();
}

function updatePage() {
  $.ajax({
    url: "/status",
    type: "GET",
    success: function(data) {
      var jsonData = JSON.parse(data);
      analyzeData(jsonData);
    }
  });
}

function timer(timerEnd) {
  updateTimer(getTimeString(getNumSecondsLeft(timerEnd)));
  showTimer();
  var timerHandler = setInterval(function() {
    var numSecondsLeft = getNumSecondsLeft(timerEnd);
    updateTimer(getTimeString(numSecondsLeft));

    if(deactivated) {
      clearInterval(timerHandler);
      updatePage();
    } else if (!deactivated && numSecondsLeft <= 0) {
      clearInterval(timerHandler);
      $.ajax({
        url: "/explode",
        type: "POST",
        success: function() {
          hideTimer();
          updatePage();
        }
      });
    }
  }, 500);
}

function getNumSecondsLeft(timerEnd) {
  var now = Math.floor(new Date().getTime() / 1000);
  if (timerEnd - now <= 0) {
    return 0;
  } else {
    return (timerEnd - now);
  }
}

function getTimeString(seconds) {
  var mins = Math.floor(seconds / 60);
  var secs = seconds - (mins * 60);
  var timeString = "0" + mins + ":";
  if (secs < 10) {
    timeString = timeString + "0" + secs;
  } else {
    timeString = timeString + secs;
  }
  return timeString;
}

function updateTimer(string) {
  document.getElementById("timer").innerHTML = "" + string;
}

function showTimer() {
  $("#timer").removeClass("hidden");
}

function showInvalid() {
  document.getElementById("Invalid").innerHTML = "Invalid!";
}

function hideWarning() {
  document.getElementById("Invalid").innerHTML = "";
}

function showInputWarning() {
  var text = "Only numeric input is allowed."
  document.getElementById("Invalid").innerHTML = text;
}

function hideTimer() {
  $("#timer").addClass("hidden");
}

function disableButtons() {
  document.getElementById("formButton").disabled = true;
}

window.onload = updatePage();
