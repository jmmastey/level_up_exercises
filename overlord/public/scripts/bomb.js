var Bomb = Bomb || {};

Bomb.init = function() {
  Bomb.init_code_display();
  Bomb.init_keyboard_input();
  Bomb.init_keypad();
  Bomb.init_timer();
  Bomb.init_wires();

  Bomb.get_state_from_server();
};

Bomb.init_code_display = function() {
  $('input#code').change(function() {
    $('.code-display').html($('input#code').val());
  });
};

Bomb.init_keyboard_input = function() {
  $(window).keydown(function(e) {
    if (e.which == Key.enter) {
      $('#btn-enter').click();
      e.preventDefault();
    } else if (e.which == Key.backspace) {
      $('#btn-backspace').click();
      e.preventDefault();
    } else if (e.which >= Key.number_0 && e.which <= Key.number_9) {
      number = e.which - Key.number_0;
      $('.keypad button[data-value=' + number + ']').click();
      e.preventDefault();
    } else if (e.which >= Key.numpad_0 && e.which <= Key.numpad_9) {
      number = e.which - Key.numpad_0;
      $('.keypad button[data-value=' + number + ']').click();
      e.preventDefault();
    }
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

Bomb.init_timer = function() {
  Bomb.configure_timer(null);
}

Bomb.init_wires = function() {
  $('.wire').click(function() { Bomb.snip_wire(this); });
};

Bomb.clear_code_field = function() {
  Bomb.update_code_field("");
};

Bomb.configure_timer = function(time) {
  if (Bomb.timer != null) {
    clearInterval(Bomb.timer);
  }

  Bomb.detonation_time = null;
  Bomb.timer = null;

  if (time != null && time != "") {
    time = new Date(time);
    Bomb.detonation_time = time;
    Bomb.timer = setInterval(Bomb.on_timer_tick, 1000);
  }
  Bomb.update_timer_display();
}

Bomb.format_message = function(message) {
  var groups = [];
  var lines = message.split(/\n/);
  var temp = $('<div />');
  for (var i = 0; i < lines.length; i++) {
    groups.push(temp.text(lines[i]).html());
  }
  return groups.join("<br />");
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
  Bomb.configure_timer(result.detonation_time);
};

Bomb.on_timer_tick = function() {
  Bomb.update_timer_display();
  if (Bomb.detonation_time >= Date.now()) {
    Bomb.configure_timer(null);
    Bomb.update_timer_display();
    Bomb.get_state_from_server();
  }
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
  $('.message').html(Bomb.format_message(message));
};

Bomb.update_state = function(state) {
  $('.activation_status').text(state.toUpperCase());
  $('.activation_status').attr('data-state', state);
  if (state == "exploded") {
    window.location.assign('/explosion');
  }
};

Bomb.update_timer_display = function() {
  var time = "";
  if (Bomb.detonation_time != null) {
    delay = Bomb.detonation_time - Date.now();
    total_seconds = Math.floor(delay / 1000);
    hours = Math.floor(total_seconds / 3600);
    minutes = Math.floor(total_seconds / 60) % 60;
    seconds = total_seconds % 60;
    time = leading_zeros(hours, 2) + ":" 
         + leading_zeros(minutes, 2) + ":" 
         + leading_zeros(seconds, 2);
  }
  $('.timer').text(time);
};

$(function() {
  Bomb.init();
});
