var Bomb = Bomb || {};

Bomb.init = function() {
  Bomb.init_code_display();
  Bomb.init_keypad();
  Bomb.init_wires();
};

Bomb.init_code_display = function() {
  $('input#code').change(function() {
    $('.code-display').html($('input#code').val());
  });
};

Bomb.init_keypad = function() {
  Bomb.init_keypad_backspace();
  Bomb.init_keypad_enter();
  $('.keypad button[data-value]').click(function() {
    number_pressed = $(this).data('value');
    Bomb.update_code_field(Bomb.get_code_field() + "" + number_pressed);
  });
};

Bomb.init_keypad_backspace = function() {
  $('#btn-backspace').click(function() {
    value = Bomb.get_code_field();
    if (value.length > 0) {
      Bomb.update_code_field(value.substr(0, value.length - 1));
    }
  });
};

Bomb.init_keypad_enter = function() {
  $('#btn-enter').click(Bomb.submit_code);
};

Bomb.init_wires = function() {
  $('.wire').click(function() { Bomb.snip_wire(this); });
};

Bomb.clear_code_field = function() {
  Bomb.update_code_field("");
};

Bomb.get_code_field = function() {
  return $('input#code').val() || "";
};

Bomb.get_state_from_server = function() {
  $.ajax({
    type: "GET",
    url: "/get_state",
    dataType: "json",
    error: Bomb.on_server_error,
    success: Bomb.handle_server_response
  });
};

Bomb.handle_server_response = function(result) {
  Bomb.update_message(result.message);
  Bomb.update_state(result.state);
};

Bomb.on_server_error = function(request, status_message, error) {
  alert('Error connecting to server: ' + error);
};

Bomb.snip_wire = function(wire) {
  if ($(wire).hasClass("cut")) return;

  color = $(wire).attr('data-color');
  $(wire).addClass("cut");
  $.ajax({
    type: "POST",
    url: "/snip_wire",
    data: { wire_color: color },
    dataType: "json",
    error: Bomb.on_server_error,
    success: Bomb.handle_server_response
  });
};

Bomb.submit_code = function() {
  code = Bomb.get_code_field();
  Bomb.clear_code_field();
  $.ajax({
    type: "POST",
    url: "/code_entry",
    data: { code: code },
    dataType: "json",
    error: Bomb.on_server_error,
    success: Bomb.handle_server_response
  });
};

Bomb.update_code_field = function(new_value) {
  if (new_value.length < 4) {
    $('input#code').val(new_value);
  } else {
    $('input#code').val(new_value.substr(0, 4));
  }
  $('input#code').change();
};

Bomb.update_message = function(message) {
  $('.message').text(message);
};

Bomb.update_state = function(state) {
  $('.activation_status').text(state.toUpperCase());
  if (state == "exploded") {
    window.location.assign('/explosion');
  }
};

$(function() {
  Bomb.init();
});
