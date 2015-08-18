describe("Detonator", function() {
  var detonator;

  beforeEach(function() {
    loadStyleFixtures("detonator.css");
    loadFixtures("detonator.html");
    jasmine.clock().install();
    detonator = new Detonator();
  });

  afterEach(function() {
    jasmine.clock().uninstall();
  });

  it("is not connected by default", function() {
    expect(detonator.isConnected()).toEqual(false);
  });

  it("can connect to the bomb", function() {
    detonator.connectToBomb();
    expect(detonator.isConnected()).toEqual(true);
  });

  it("can disconnect from the bomb", function() {
    detonator.connectToBomb();
    expect(detonator.isConnected()).toEqual(true);

    detonator.disconnectFromBomb();
    expect(detonator.isConnected()).toEqual(false);
  });

  it("ticks when connected", function() {
    spyOn(detonator, "tick");

    detonator.connectToBomb();
    expect(detonator.tick).not.toHaveBeenCalled();

    jasmine.clock().tick(5000);
    expect(detonator.tick).toHaveBeenCalled();
  });

  it("disconnects when the bomb is disarmed", function() {
    detonator.connectToBomb();
    expect(detonator.isConnected()).toEqual(true);

    detonator.tock({ state: "disarmed" });
    expect(detonator.isConnected()).toEqual(false);
  });

  it("disconnects when the bomb has exploded", function() {
    detonator.connectToBomb();
    expect(detonator.isConnected()).toEqual(true);

    detonator.tock({ state: "exploded" });
    expect(detonator.isConnected()).toEqual(false);
  });

  it("updates the clock on each tock", function() {
    detonator.tock({ clock: "1234" });
    expect($('[name=clock]').get(0)).toHaveValue("1234");
  });

  it("sets the mode to disarmed when inactive", function() {
    $('[name=mode][value=armed]').prop("checked", true);
    expect($('[name=mode][value=disarmed]')).not.toBeChecked();

    detonator.tock({ state: "inactive" });
    expect($('[name=mode][value=disarmed]')).toBeChecked();
  });

  it("disables the trigger when inactive", function() {
    $('[name=trigger]').prop("disabled", false);
    expect($('[name=trigger]')).not.toBeDisabled();

    detonator.tock({ state: "inactive" });
    expect($('[name=trigger]')).toBeDisabled();
  });

  it("sets the mode to armed when active", function() {
    $('[name=mode][value=disarmed]').prop("checked", true);
    expect($('[name=mode][value=armed]')).not.toBeChecked();

    detonator.tock({ state: "active" });
    expect($('[name=mode][value=armed]')).toBeChecked();
  });

  it("enables the trigger when active", function() {
    $('[name=trigger]').prop("disabled", true);
    expect($('[name=trigger]')).toBeDisabled();

    detonator.tock({ state: "active" });
    expect($('[name=trigger]')).not.toBeDisabled();
  });

  it("triggers a modal when an error is received", function() {
    spyOnEvent($('#error'), "show.bs.modal");
    detonator.tock({ error: "failure" });
    expect("show.bs.modal").toHaveBeenTriggeredOn($('#error'));
  });

  it("displays an error message when an error is received", function() {
    expect($('#error .message')).not.toContainText("abject failure");

    detonator.tock({ error: "abject failure" });
    expect($('#error .message')).toContainText("abject failure");
  });

  it("submits the code when a mode different is clicked", function() {
    spyOn(detonator, "sendCode");

    $('[name=mode][value=armed]').click();

    expect(detonator.sendCode).toHaveBeenCalled();
  });

  it("disables the interface when it's been disarmed", function() {
    detonator.tock({ state: "disarmed" });

    $(':input').each(function() {
      expect($(this)).toBeDisabled();
    });
  });

  it("disables the interface when it's been exploded", function() {
    detonator.tock({ state: "exploded" });

    $(':input').each(function() {
      expect($(this)).toBeDisabled();
    });
  });

  it("activates the bomb when trigger is active and clicked", function() {
    spyOn(detonator, "activateBomb");

    $('[name=trigger]').prop("disabled", false).click();
    expect(detonator.activateBomb).toHaveBeenCalled();
  });

  it("does not activate the bomb when trigger is inactive and clicked", function() {
    spyOn(detonator, "activateBomb");

    $('[name=trigger]').prop("disabled", true).click();
    expect(detonator.activateBomb).not.toHaveBeenCalled();
  });

  it("ignores duplicate errors", function() {
    detonator.tock({ error: "failure" });
    $('#error').modal('hide');

    spyOnEvent($('#error'), "show.bs.modal");
    detonator.tock({ error: "failure" });
    expect("show.bs.modal").not.toHaveBeenTriggeredOn($('#error'));
  });

  it("exposes the wires when the wires panel is clicked", function() {
    expect($('.wires .exposed').eq(0)).not.toBeVisible();
    $('.wires').click();
    expect($('.wires .exposed').eq(0)).toBeVisible();
  });

  it("hides the wires when the front panel is clicked", function() {
    $('.wires').click();
    expect($('.front-plate').eq(0)).toHaveClass('reveal');
    $('.front-plate').click();
    expect($('.front-plate').eq(0)).not.toHaveClass('reveal');
  });

  it("can be short-circuited", function() {
    spyOn(detonator, "shortCircuit");

    $(document).trigger("short");
    expect(detonator.shortCircuit).toHaveBeenCalled();
  });

  it("cuts a wire when a wire is clicked", function() {
    spyOn(detonator, "cutWire");
    wire = $('.wires .wire').eq(3);
    wire.click();
    expect(detonator.cutWire).toHaveBeenCalledWith($(wire).data('idx'));
  });
});
