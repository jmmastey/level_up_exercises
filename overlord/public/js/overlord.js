var timer = undefined;
var state_panel_map = {
  "off": ".configure_bomb",
  "on": ".activate_bomb",
  "activated": ".deactivate_bomb",
  "deactivated": ".bomb_deactivated",
  "destroyed": ".world_ended",
};
function on_load() {
  timer = new CountdownTimer("#timer", "#seconds", "#milliseconds", "#hidden");
  load_timer_info();
  update_bomb_state_class(get_bomb_state());
  show_panel(state_panel_map[get_bomb_state()]);
  enable_enter_key();
  enable_buttons();
  play_video();
}

// AJAX calls for changing panels.
$('form.config').on('submit', function (e) {
  e.preventDefault();
  $.ajax({
    url: '/configure',
    type: 'POST',
    data: {
      'activation_code': $('.config input.activation-code').val(),
      'deactivation_code': $('.config input.deactivation-code').val()},
    dataType: 'text'
  }).success(update_state).fail(error_message);
});

$('form.activate').on('submit', function (e) {
  e.preventDefault();
  $.ajax({
    url: '/activate',
    type: 'POST',
    data: { 'activation_code': $('.activate input.activation-code').val() },
    dataType: 'text'
  }).success(update_state).fail(error_message);
});

$('form.deactivate').on('submit', function (e) {
  e.preventDefault();
  $.ajax({
    url: '/deactivate',
    type: 'POST',
    data: { 'deactivation_code': $('.deactivate input.deactivation-code').val() },
    dataType: 'text'
  }).success(update_state).fail(deactivation_attempt);
});

function load_timer_info() {
  if ($("#hidden").val() != "") {
    timer.set_time(parseInt($("#hidden").val()), 0);
    start_timer();
  }
}

function no_more_time() {
  timer.stop_countdown();
  $.ajax({
    url: '/no_more_time',
    type: 'POST',
  }).success(update_state).fail(update_state);
}

function error_message(data, type) {
  var type = (typeof(type) === undefined) ? "error" : type;
  swal({
    title: type.toUpperCase(),
    text: data.responseText,
    type: type
  });
}

function deactivation_attempt(data) {
  if (data.responseText.indexOf("0 attempts left") != -1) {
    data.responseText = "You dun goofed!";
    error_message(data, "error");
    update_state("Destroyed");
  } else {
    error_message(data, "warning");
  }
}

function update_state(state) {
  var panel_selector = state_panel_map[state.toLowerCase()];
  show_panel(panel_selector);
  update_bomb_state(state);
  update_state_specific(state);
  set_input_focus(panel_selector);
}

function update_bomb_state(state) {
  $('.bomb-state').html(state);
  update_bomb_state_class(state);
}

function update_bomb_state_class(state) {
  state = state.toLowerCase();
  $('.bomb-state').removeClass().addClass('bomb-state ' + state);
}

function update_state_specific(state) {
  if (state === 'Activated') {
    start_timer();
  } else if (state === 'Deactivated') {
    timer.stop_countdown();
    play_video(state);
  } else if (state === 'Destroyed') {
    play_video(state);
  }
}

function start_timer() {
  timer.start_countdown();
  if (timer.get_time() === "00:00") { return no_more_time(); }
  $("#hidden").on('change', function(){
    if (timer.get_time() === "00:00" && !timer.stopped) {
      no_more_time();
    }
  });
}

function get_bomb_state() {
  return $('.bomb-state').html().toLowerCase();
}

function set_input_focus(panel_selector) {
  $('.panel'+panel_selector+' input').focus();
}

function show_panel(panel_selector) {
  $('.panel').removeClass('display');
  $('.panel'+panel_selector).addClass('display');
}

function enable_enter_key() {
  $('form.controls input').keypress(function (e) {
    if (e.which === 13) $(this).parents('form').submit();
  });
}

function enable_buttons() {
  $('.btn').on('click', function (e) {
    $(this).parents('form').submit();
  });
}

function play_video(state) {
  if (state === 'Deactivated') {
    dance();
  } else if (state === 'Destroyed') {
    boom();
  }
}

function dance() {
  $('#dance').html('<iframe allowfullscreen="" frameborder="0" height="360"'+
    'src="https://www.youtube.com/embed/zS1cLOIxsQ8?rel=0&amp;controls=0&amp;'+
    'showinfo=0&amp;autoplay=1&amp;start=28&amp;&cc_load_policy=1" '+
    'width="640"></iframe>');
}

function boom() {
  $("#boom").html('<iframe allowfullscreen="" frameborder="0" height="360" '+
    'src="https://www.youtube.com/embed/3KJnnMBHOVQ?rel=0&amp;controls=0&amp;'+
    'showinfo=0&amp;autoplay=1&amp;start=5&amp;&cc_load_policy=1" '+
    'width="640"></iframe>');
}

on_load();
