$(function(){
  $('.bomb-initialization-button').click(function(){
    var bombCodes = {
      "activation_code": $('.bomb-activation-input').val(),
      "deactivation_code": $('.bomb-deactivation-input').val()
    };

    $.post('/initialize', bombCodes, function(){
      location.reload()
    });
  });

  $('.bomb-activation-button').click(function(){
    var activationCode = {
      "activation_code": $('.bomb-code-input').val()
    };

    $.post('/activate', activationCode, function(){
      location.reload()
    });
  });

  $('.bomb-deactivation-button').click(function(){
    var deactivationCode = {
      "deactivation_code": $('.bomb-code-input').val()
    };

    $.post('/deactivate', deactivationCode, function(){
      location.reload()
    });
  });

  $('.bomb-button').click(function(){
    var currentInput = $('.bomb-code-input').val()
    var currentValue = $(this).html()
    $('.bomb-code-input').val(currentInput + currentValue)
  });
});
