$(function() {

  // jQuery DOM elements

  var security_form = $('form[name="security"]'),
    bomb_errors = $('.bomb-errors'),
    bomb_status = $('.bomb-status'),
    create_bomb = $('.create-bomb'),
    create_instructions = $('.create-instructions');

  // POST request

  var send_post = function(url, data, action) {
    $.post(url, data, function(response) {
      process_response(response, action);
    }).fail(function(jqxhr, text_status, error_thrown) {
      display_errors(text_status);
    });
  };

  // Digest JSON responses, display errors

  var process_response = function(response, block) {
    response = typeof response !== 'undefined' ? $.parseJSON(response) : {};
    block = typeof response !== 'undefined' ? block : function() {};

    if (response.hasOwnProperty('status') && response.status == 'ok') {
      block(response);
    }
    display_errors(response);
  };

  // Display errors as alert

  var display_errors = function(response) {
    errors = response.hasOwnProperty('errors') ? response.errors : [];
    if (errors instanceof Array) {
      errors = errors.join('\n');
    }
    if (errors.length > 0) {
      alert('Error: ' + errors);
    }
  };

  // Activate/Deactivate Result

  var security_result = function(response) {
    security_form[0].reset();
    bomb = response.data.bomb;
    bomb_status.html(bomb.status);

    if (bomb.error_count > 0) {
      bomb_errors.html('Failed attempts: ' + bomb.error_count);
    } else {
      bomb_errors.html('');
    }

    if (bomb.status == 'exploded') {
      security_form.remove();
      bomb_errors.remove();
      create_instructions.show();
    }
  };

  // Security form

  security_form.on('submit', function(e) {
    e.preventDefault();
    var url = bomb_status.html() == 'inactive' ? '/activate' : '/deactivate';
    send_post(url, $(this).serialize(), security_result);
  });

  // Create bomb

  create_bomb.on('click', function(e) {
    e.preventDefault();
    send_post('/create', null, function() {
      window.location.reload();
    });
  });
});