var deactivated = true;

function submitCode() {
  var code = $('input').val();
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
  var bombState = '<span style="color:red">Activated!</span>';
  var deactivateLabel = 'To deactivate, enter your deactivation code: ';
  $('#bombState').html(bombState);
  $('#formLabel').text(deactivateLabel);
  if (jsonObj.attempts_remaining <= 0) {
    explodedUpdates();
  } else if (jsonObj.attempts_remaining < 3) {
    var attemptsRemaining = '(' + jsonObj.attempts_remaining;
    attemptsRemaining = attemptsRemaining + ' attempts remaining!)';
    $('#AttemptsRemaining').text(attemptsRemaining);
  }
  timer(jsonObj.timer_end);
}

function deactivatedUpdates() {
  deactivated = true;
  hideTimer();
  var activateLabel = 'To activate, enter your activation code: ';
  $('#bombState').text('Deactivated');
  $('#formLabel').text(activateLabel);
  $('#AttemptsRemaining').text('');
}

function explodedUpdates() {
  deactivated = true;
  hideTimer();
  var explodedLabelText = 'To deactiv ent fjds as;dfasåß∂¬ƒåƒ∆å…ßˆƒ˙Ω©∫˚∫´å: ';
  $('#bombState').text('!@#$%^&*!@#&$!');
  $('#formLabel').text(explodedLabelText);
  $('#AttemptsRemaining').text('');
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
  $('#timer').text(string);
}

function showTimer() {
  $('#timer').removeClass('hidden');
}

function showInvalid() {
  $('#Invalid').text('Invalid!');
}

function hideWarning() {
  $('#Invalid').text('');
}

function showInputWarning() {
  var text = 'Only numeric input is allowed.';
  $('#Invalid').text(text);
}

function hideTimer() {
  $('#timer').addClass('hidden');
}

function disableButtons() {
  $('#formButton').prop('disabled', true);
}

window.onload = updatePage();
