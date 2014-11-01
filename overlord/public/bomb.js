function ControlObject(elementID)
{
  var self = this;  // Reference myself wherever JS sets "this" weird
  var element = document.getElementById(elementID);
  this.element = function() { return element };
  
  this.value = function() { return element.value };
  this.setValue = function(newValue) { element.value = newValue };
  this.text = function() { return element.innerHTML };
  this.setText = function(newText) { element.innerHTML = newText };

  // FLASHING: Subclasses define: isLitUp(), dim(), lightUp()

  function toggleLight()
    { self.isLitUp() ? self.dim() : self.lightUp() }

  var flash_timer = null;
  
  this.stopFlashing = function()
  {
    if (!flash_timer) return;
  
    window.clearTimeout(flash_timer);
    flash_timer = null;
    self.dim();
  }

  this.flash = function(offtime, ontime)
  {
    offtime = offtime || 150
    ontime = ontime || offtime
    self.stopFlashing();

    var flashMyself = function() 
    {
      if (!flash_timer) return;
      toggleLight();
      flash_time = self.isLitUp() ? ontime : offtime;
      flash_timer = window.setTimeout(flashMyself, flash_time);
    };

    flash_timer = window.setTimeout(flashMyself, ontime);
  }

  this.isDisabled = function() 
    { return element.getAttribute('DISABLED') == 1 || element.disabled }

  this.disabled = function(true_or_false)
    { element.setAttribute('DISABLED', (element.disabled = true_or_false) ? 1 : 0) }
 
  // For buttons only.
  this.buttonDown = function() { self.isDisabled() || self.lightUp() };
  this.buttonUp = function() { self.isDisabled() || self.dim() };
}

function ControlButton(elementID)
{
  var self = this;
  ControlObject.call(this, elementID);

  var element = this.element();
  var imageWhenDark = element.getAttribute('IMAGEWHENDARK');
  var imageWhenLit = element.getAttribute('IMAGEWHENLIT');

  function resourceBasename(resource) { return resource.split('/').pop() }

  this.lightUp = function() { element.src = imageWhenLit };
  this.dim = function() { element.src = imageWhenDark };
  this.isLitUp = function() 
    { return resourceBasename(element.src) == imageWhenLit };
}

ControlButton.prototype = new ControlObject();

function ActionButton(elementID)
{
  ControlObject.call(this, elementID);

  var element = this.element();
  var classList = element.classList;
  var classWhenLit = element.getAttribute('CLASSWHENLIT');

  this.isLitUp = function() { return classList.contains(classWhenLit) };
  this.lightUp = function() { classList.add(classWhenLit) };
  this.dim = function() { classList.remove(classWhenLit) };
}

ActionButton.prototype = new ControlObject();

function TimerEntry(elementID, resetToValue)
{
  var self = this;
  ControlObject.call(this, elementID);

  var element = this.element();
  this.value = function() { return parseInt(element.value) || 0 };
  this.setValue = function(newValue)
  {
    var value = parseInt(newValue);
    element.value = (isNaN(value) ? resetToValue : value);
  }

  this.countDown = function(whatToDoAtTheEnd)
  {
    self.disabled(true);

    var countdown = function() 
    {
      if (self.value() <= 0)
        return whatToDoAtTheEnd();

      self.setValue(self.value() - 1);
      window.setTimeout(countdown, 1000);
    }

    window.setTimeout(countdown, 1000);
  };
}

initializations =
{
  'armed': function()
  {
    armingButton().lightUp();
    startCountdown();
  },
  'locked': function()
  {
    disarmingButton().lightUp();
    timerEntryUp().lightUp();
    timerEntryDown().lightUp();
  },
  'initial': function() { flashActionButtons() }
}

function initializeInterface()
{
  var handler = initializations[CONTROLPANEL.state];
  if (handler) handler();
};

(function()
{
  var ctrls = {}; // Keep private

  getElement = function (elementID, typeConstructor)   // But define externally
    { return ctrls[elementID] || (ctrls[elementID] = new typeConstructor(elementID)); }
})()

function armingButton() { return getElement("armingButton", ActionButton) };
function disarmingButton() { return getElement("disarmingButton", ActionButton) };
function commitButton() { return getElement("commitButton", ControlButton) };
function cancelButton() { return getElement("cancelButton", ControlButton) };
function timerEntry() { return getElement("timerEntry", TimerEntry) };
function timerEntryUp() { return getElement("timerEntryUp", ControlButton) };
function timerEntryDown() { return getElement("timerEntryDown", ControlButton) };
function messageDisplay() { return getElement("messageDisplay", ControlObject) };
function controlPanelForm() { return getElement("controlPanelForm", ControlObject) };

function armingButtonPushed()
{
  if (armingButton().isDisabled()) return;
  controlPanelForm().element().action = "/arm"
  armingButton().flash(100);
  flashActionButtons();
}

function disarmingButtonPushed()
{
  if (disarmingButton().isDisabled()) return;
  controlPanelForm().element().action = "/disarm"
  disarmingButton().flash(100);
  flashActionButtons();
}
function flashActionButtons()
{
  commitButton().flash(500);
  cancelButton().flash(500);
}

function stopFlashingActionButtons()
{
  commitButton.stopFlashing();
  cancelButton.stopFlashing();
}

function codeEntryFocused(textbox)
{
  if (textbox.already_cleared) return;

  textbox.value = '';
  textbox.already_cleared = true;
}

function adjustDelayTime(incr)
{
  if (CONTROLPANEL.state != 'locked') return;

  var newValue = timerEntry().value() + incr;
  if (newValue < 0) newValue = 0;
  timerEntry().setValue(newValue);
}

function startCountdown()
{
  var refreshAfterBombExplodes = function() 
  {
    messageDisplay().element().stop;
    messageDisplay().element().innerHTML =
      "This bomb will now self-destruct. Have a nice day! :-)";
    window.setTimeout(function() { location.reload(true); }, 2000);
  };

  timerEntry().countDown(refreshAfterBombExplodes);
}
