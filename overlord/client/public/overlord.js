$(function() {
  bind_button = function(btn, path, request, error) {
    $(btn).click(function() {
      $.ajax({
        url: 'http://localhost:4567' + path,
        type: request,
        crossDomain: true,
        success: function(data) {
          message = data['message'];
          $("ul#error_list").prepend('<li class="status">' + message + '</li>');
        },
        error: function(data) {
          alert(error);
        }
      });
    });
  }

  bind_button('#bomb_boot_btn', '/boot', 'POST', 'Error Booting Bomb');
  bind_button('#bomb_reset_btn', '/bomb', 'PUT', 'Error Resetting Bomb');

  bind_text_field = function(id, path, request, error) {
    $(id).find('.btn').click(function() {
      $.ajax({
        url: 'http://localhost:4567' + path,
        type: request,
        crossDomain: true,
        data: { 'key' : $(id).find('.textbox')[0].value,
                'code' : $(id).find('.textbox')[0].value },
        success: function(data) {
          message = data['message'];
          $("ul#error_list").prepend('<li class="status">' + message + '</li>');
        },
        error: function(data) {
          alert(error);
        }
      });
    });
  }

  bind_text_field('#deactivation_key', '/set_deactivation_key', 'POST', 'Oops');
  bind_text_field('#activation_key', '/set_activation_key', 'POST', 'Oops');
  bind_text_field('#submit_code', '/submit_code', 'POST', 'Oops');

  status_timer = setInterval(function() {
    $.ajax({
      url: 'http://localhost:4567/',
      type: 'GET',
      crossDomain: true,
      success: function(data) {
        message = data['message'];
        $('#bomb_state').text(message)
      },
      error: function(data) {
        alert('Error Resetting Bomb');
      }
    });
  }, 500);

  bomb_timer = setInterval(function() {
    $.ajax({
      url: 'http://localhost:4567/timer',
      type: 'GET',
      crossDomain: true,
      success: function(data) {
        message = data['message'];
        $('#timer').text(message)
      },
      error: function(data) {
        alert('Error Getting Time');
      }
    });
  }, 500);
});
