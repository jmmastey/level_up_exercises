function getRandomIntInclusive(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

// Timer variables
var timer_id = "#timer";
var seconds_id = "#seconds";
var milliseconds_id = "#milliseconds";
var hidden_id = "#hidden";

function createTimer() {
  return new CountdownTimer(timer_id, seconds_id, milliseconds_id, hidden_id);
}

function createDummyContainer(dummy_id) {
  var dummy = document.createElement("DIV");
  dummy.id = dummy_id;
  document.body.appendChild(dummy);
}

QUnit.module("CountdownTimer");

QUnit.test("maybe_prepend_zero should prepend zero to numbers less than 0", function (assert) {
  var timer = createTimer();
  var value = getRandomIntInclusive(0, 9);

  assert.equal(timer.maybe_prepend_zero(value), value, "Successfully prepended zero.");
});

QUnit.test("maybe_prepend_zero should not prepend zero to numbers greater than 10", function (assert) {
  var timer = createTimer();
  var value = getRandomIntInclusive(10, 99);

  assert.equal(timer.maybe_prepend_zero(value), value, "Successfully avoided prepending zero.");
});

QUnit.test("set_time should update the given html elements", function (assert) {
  var timer = createTimer();
  var seconds = 30;
  var milliseconds = 0;
  timer.set_time(seconds, milliseconds);

  assert.equal($(seconds_id).html(), timer.maybe_prepend_zero(seconds), "Successfully set seconds in DOM.");
  assert.equal($(milliseconds_id).html(), timer.maybe_prepend_zero(milliseconds), "Successfully set milliseconds in DOM.");
});

QUnit.test("get_time should correctly get time from the DOM.", function (assert) {
  var timer = createTimer();
  var seconds = 30;
  var milliseconds = 0;
  var expected_value = "30:00";
  timer.set_time(seconds, milliseconds);

  assert.equal(timer.get_time(), expected_value, "Successfully got timer values from the DOM.")
});

QUnit.test("get_seconds should correctly get seconds from the DOM.", function (assert) {
  var timer = createTimer();
  var seconds = 30;
  var milliseconds = 0;
  timer.set_time(seconds, milliseconds);

  assert.equal(timer.get_seconds(), seconds, "Successfully got seconds from the DOM.")
});

QUnit.test("get_milliseconds should correctly get milliseconds from the DOM.", function (assert) {
  var timer = createTimer();
  var seconds = 30;
  var milliseconds = 0;
  timer.set_time(seconds, milliseconds);

  assert.equal(timer.get_milliseconds(), milliseconds, "Successfully got milliseconds from the DOM.")
});

QUnit.test("start_countdown should update the timer state, and start the countdown and blink timers", function (assert) {
  var timer = createTimer();
  var seconds = 5;
  var milliseconds = 0;
  timer.set_time(seconds, milliseconds);
  timer.start_countdown();

  assert.equal(timer.started, true, "Successfully changed timer started state to true");
  assert.equal(timer.stopped, false, "Successfully changed timer stopped state to false");
  assert.equal(timer.timer_intervals.length, 2, "Successfully started update timer, and blink timer.");

  timer.stop_countdown();
});

QUnit.test("start_countdown should start another interval if it has already been started", function (assert) {
  var timer = createTimer();
  var seconds = 5;
  var milliseconds = 0;
  timer.set_time(seconds, milliseconds);

  timer.start_countdown();
  var n_intervals = timer.timer_intervals.length;

  timer.start_countdown();
  assert.equal(timer.timer_intervals.length, n_intervals, "Successfully prevented more intervals from being started.");

  timer.stop_countdown();
});

QUnit.test("update_timer should accurately update the timer based on DOM values", function (assert) {
  var timer = createTimer();
  timer.set_time(5, 0);
  // Set these manually so we can call update_timer without dealing with setInterval.
  timer.started = true;
  timer.stopped = false;

  var expected_seconds = 4;
  var expected_milliseconds = 99;
  timer.update_timer();

  assert.equal(timer.get_seconds(), expected_seconds, "Successfully decremented seconds.");
  assert.equal(timer.get_milliseconds(), expected_milliseconds, "Successfully decremented milliseconds.");
});

QUnit.test("update_timer should call stop_countdown when the seconds and milliseconds reach 0", function (assert) {
  var timer = createTimer();
  timer.set_time(0, 1);
  // Set these manually so we can call update_timer without dealing with setInterval.
  timer.started = true;
  timer.stopped = false;
  timer.update_timer();

  assert.equal(timer.stopped, true, "Successfully stopped timer upon reaching 0s, 0ms");
});

QUnit.test("blink should toggle class 'blink' on timer", function (assert) {
  var timer = createTimer();
  timer.set_time(30, 0);

  var blink_class = "blink";
  timer.blink();
  assert.equal(timer.t.hasClass(blink_class), true, "Successfully toggled on 'blink' class");
  timer.blink();
  assert.equal(timer.t.hasClass(blink_class), false, "Successfully toggled off 'blink' class");
});

QUnit.test("blink should toggle class 'blink-red' on timer, if timer seconds are below 10", function (assert) {
  var timer = createTimer();
  timer.set_time(9, 0);

  var blink_class = "blink-red";
  timer.blink();
  assert.equal(timer.t.hasClass(blink_class), true, "Successfully toggled on 'blink-red' class");
  timer.blink();
  assert.equal(timer.t.hasClass(blink_class), false, "Successfully toggled off 'blink-red' class");
})

QUnit.module("YouTube Videos");
QUnit.test("dance should place an iframe for the appropriate YouTube video", function (assert) {
  createDummyContainer("dance");
  var video_url = 'zS1cLOIxsQ8';

  dance();
  assert.notEqual($("#dance").html().indexOf(video_url), -1, "Successfully loaded appropriate youtube video.");

  $("#dance").remove();
});

QUnit.test("boom should place an iframe for the appropriate YouTube video", function (assert) {
  createDummyContainer("boom");
  var video_url = '3KJnnMBHOVQ';

  boom();
  assert.notEqual($("#boom").html().indexOf(video_url), -1, "Successfully loaded appropriate youtube video.");

  $("#boom").remove();
});
