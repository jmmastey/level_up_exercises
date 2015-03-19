$(function(){
  $('.bomb-initialization-button').click(function(){
    var bomb_codes = {
      "activation_code": $('.bomb-activation-input').val(),
      "deactivation_code": $('.bomb-deactivation-input').val()
    };

    $.post('/initialize', bomb_codes, function(){
      location.reload()
    });
  });

  $('.bomb-activation-button').click(function(){
    var activation_code = {
      "activation_code": $('.bomb-code-input').val()
    };

    $.post('/activate', activation_code, function(){
      location.reload()
    });
  });

  $('.bomb-deactivation-button').click(function(){
    var deactivation_code = {
      "deactivation_code": $('.bomb-code-input').val()
    };

    $.post('/deactivate', deactivation_code, function(){
      location.reload()
    });
  });

  $('.bomb-button').click(function(){
    var current_input = $('.bomb-code-input').val()
    var current_value = $(this).html()
    $('.bomb-code-input').val(current_input+current_value)
  });
});
