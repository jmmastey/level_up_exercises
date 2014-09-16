/**
 * bomb.js
 * @author Dan Kotowski
 */

var Bomb = Bomb || {};

Bomb.init = function() {
  Bomb.init_code_display();
  Bomb.init_keypad();
};

Bomb.init_code_display = function() {
  $('input#code').change(function() {
    $('.code-display').html($('input#code').val());
  });
};

Bomb.init_keypad = function() {
  Bomb.init_keypad_backspace();
  $('.keypad button[data-value]').click(function() {
    number_pressed = $(this).data('value');
    Bomb.update_code_field(Bomb.get_code_field() + number_pressed);
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

Bomb.clear_code_field = function() {
  Bomb.update_code_field("");
}

Bomb.get_code_field = function() {
  return $('input#code').val();
}

Bomb.update_code_field = function(new_value) {
  if (new_value.length < 4) {
    $('input#code').val(new_value);
  } else {
    $('input#code').val(new_value.substr(0, 4));
  }
  $('input#code').change();
}

$(function() {
  Bomb.init();
});
