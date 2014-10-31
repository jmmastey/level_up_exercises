function initializeInterface()
{
  if (CONTROLPANEL.state == 'armed')
  {
    lightControlButton(armingButton());
    flashControlButton(disarmingButton(), 1000, 50);
    startCountdown();
  }
  else if (CONTROLPANEL.state == "locked")
  {
    lightControlButton(disarmingButton());
    lightActionButton(timerEntryUp());
    lightActionButton(timerEntryDown());
    flashControlButton(armingButton(), 1000, 50);
  }

  window.setInterval(function() { scrollMessage(); }, 100);
};

function armingButton() { return document.getElementById("armingButton"); }
function disarmingButton() { return document.getElementById("disarmingButton"); }
function commitButton() { return document.getElementById("buttonCommit"); }
function cancelButton() { return document.getElementById("buttonCancel"); }
function timerEntry() { return document.getElementById('timerEntry'); }
function timerValueField() { return document.getElementById('timerValue'); }
function timerEntryUp () { return document.getElementById('timerEntryUp'); }
function timerEntryDown() { return document.getElementById('timerEntryDown'); }
function messageDisplay() { return document.getElementById('messageDisplay'); }
function bombCommandField() { return document.getElementById('bombCommand'); }
function controlPanelForm() { return document.getElementById('controlPanelForm'); }
function classWhenLit(control) { return control.getAttribute('CLASSWHENLIT'); }

function controlIsDisabled(control_element)
{
  return control_element.getAttribute('DISABLED') == 1;
}

function lightControlButton(button)
{
  button.classList.add(classWhenLit(button));
}

function dimControlButton(button)
{
  button.classList.remove(classWhenLit(button));
}

function buttonIsLit(button)
{
  return button.classList.contains(classWhenLit(button));
}

function controlButtonDown(button)
{
  if (controlIsDisabled(button)) return;
  lightControlButton(button);
}

function controlButtonUp(button)
{
  if (controlIsDisabled(button)) return;
  dimControlButton(button);
}

function toggleControlLight(button)
{
  if (buttonIsLit(button))
    dimControlButton(button);
  else
    lightControlButton(button);
}

function stopFlashingControlButton(button)
{
  if (!button.flash_timer) return;
  
  window.clearTimeout(button.flash_timer);
  delete button.flash_timer; 
  dimControlButton(button);
}

function flashControlButton(button, offtime, ontime)
{
  offtime = offtime || 150
  ontime = ontime || offtime
  stopFlashingControlButton(button);

  var flashIt = function() 
  {
    if (!button.flash_timer) return;
    toggleControlLight(button); 
    flash_time = buttonIsLit(button) ? ontime : offtime;
    button.flash_timer = window.setTimeout(flashIt, flash_time);
  };

  button.flash_timer = window.setTimeout(flashIt, ontime);
}

function armingButtonPushed(arming_button)
{
  if (controlIsDisabled(arming_button)) return;
  controlPanelForm().action = "/arm"
  flashControlButton(arming_button, 100);
  flashActionButtonLights();
}

function disarmingButtonPushed(disarming_button)
{
  if (controlIsDisabled(disarming_button)) return;
  controlPanelForm().action = "/disarm"
  flashControlButton(disarming_button, 100);
  flashActionButtonLights();
}

function actionButtonLitImage(button) { return button.getAttribute('IMAGEWHENLIT'); }
function actionButtonDarkImage(button) { return button.getAttribute('IMAGEWHENDARK'); }

function lightActionButton(button)
{
  button.src = actionButtonLitImage(button);
}

function dimActionButton(button)
{
  button.src = actionButtonDarkImage(button);
}

function toggleActionButtonLight(button)
{
  lit_image_src = actionButtonLitImage(button);

  if (button.src.split('/').pop() == lit_image_src)
    dimActionButton(button);
  else
    lightActionButton(button);
}

function flashActionButtonLights()
{
  var commitBtn = commitButton();
  var cancelBtn = cancelButton();

  lightActionButton(commitBtn);
  lightActionButton(cancelBtn);

  var flashEm = function() {
    toggleActionButtonLight(commitBtn);
    toggleActionButtonLight(cancelBtn);
  };

  cancelBtn.flash_timer = window.setInterval(flashEm, 500);
}

function stopFlashingActionButtons()
{
  var cancelBtn = cancelButton();

  if (!cancelBtn.flash_timer) return;

  window.cancelInterval(cancelBtn.flash_timer);
  delete cancelBtn.flash_timer;
  dimActionButton(cancelBtn);
  dimActionButton(commitButton());
}

function codeEntryFocused(textbox)
{
  if (textbox.already_cleared) return;

  textbox.value = '';
  textbox.already_cleared = true;
}

function timerValue() { return parseInt(timerEntry().value) || 0 }

function adjustDelayTime(incr)
{
  if (CONTROLPANEL.state != 'locked') return;

  var newValue = (timerValue() || 10) + incr;
  if (newValue < 0) newValue = 0;
  timerEntry().value = newValue;
}

function scrollMessage()
{
  var displayElement = messageDisplay();
  var newMessage = displayElement.innerHTML || ''
  newMessage = newMessage.substr(1) + newMessage.substr(0, 1);
  displayElement.innerHTML = newMessage;
}

function startCountdown()
{
  timerEntry().disabled = true;

  var countdown = function() 
  {
    var newValue = timerValue();

    if (newValue <= 0)
    {
      location.reload(true);
      return;
    }

    if (newValue > 0) newValue--;
    timerEntry().value = newValue;
    window.setTimeout(countdown, 1000);
  }

  window.setTimeout(countdown, 1000);
}
