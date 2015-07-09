var ticker = false;

$(function() {
  $('.connector').click(depress_button);
  $('input[type="submit"]:not(#submit-codes)').click(submit_hack);

  $('.enterable').keyup(function(e){
      if(e.keyCode == 13)
      {
          $(this).trigger("enterKey");
      }
  });

  $('#password').bind('enterKey', enter_code);
  $('#arm-code-input').bind('enterKey', initial_code_submit).focus();
  $('#disarm-code-input').bind('enterKey', initial_code_submit);
  $('#submit-codes').bind('enterKey', initial_code_submit);

  $('#confirm').click(enter_code);
  $('#submit-codes').click(initial_code_submit)
  $('.code-input').fadeIn(400);
});

function initial_code_submit(event) {
  var arm_code = $('#arm-code-input').val();
  var disarm_code = $('#disarm-code-input').val();

  var msg = 'One or more codes is invalid. Codes must be 4 digits.';
  if(!(arm_code.length == 4 || arm_code.length == 0)
    && !(disarm_code.length == 4 || disarm_code.length == 0))
  {
    $('#dialog-flash').html(msg);
    return;
  }
  else {
    for(var k=0; k<arm_code.length; k++) {
      var ach = arm_code.charAt(k);
      if(isNaN(parseInt(ach))) {
        $('.flash').html(msg);
        return;
      }
    }
    for(var k=0; k<disarm_code.length; k++) {
      var dch = disarm_code.charAt(k);
      if(isNaN(parseInt(dch))) {
        $('.flash').html(msg);
        return;
      }
    }
    if(arm_code.length == 0)
      arm_code = '1234';
    if(disarm_code.length == 0)
      disarm_code = '0000';
  }
  $('.code-input').fadeOut(400);
  
  var params = {'arm' : arm_code, 'disarm' : disarm_code};
  $.post('/setcodes', params);
}

function depress_button(event) {
  var $el = $(event.currentTarget);
  if($el.parent().hasClass('hacked'))
    return;

  $el.toggleClass('depressed');
  $el.html(1 - parseInt($el.html()));
}

function detonate() {
  clearInterval(ticker);
  ticker = false;
  $('.bomb').addClass('detonated');
  $('#password, #confirm').attr('disabled', 'true');

  var url = "https://www.youtube.com/embed/qDMUekfOR-E";
  var params = "?start=5&autoplay=1&controls=0&loop=1&rel=0";
  var iframe = $('<iframe>')
    .attr('src', url + params)
    .attr('height', '390')
    .attr('width', '640')
    .addClass('explosion-overlay');

  $('.bomb').append(iframe);
  iframe.fadeIn(10);
}

function hack_success() {
  clearInterval(ticker);
  ticker = false;
  $('.bomb').addClass('hacked');
  $('#password, #confirm').attr('disabled', 'true');
}

function tick() {
  var s = $('.seconds').html();
  var si = parseInt(s) - 1;

  if(si == -1) {
    var m = $('.minutes').html();
    var mi = parseInt(m) - 1;
    if(mi == -1) {
      detonate();
    }
    else {
      $('.seconds').html('59');
      $('.minutes').html('0'+mi);
    }
  }
  else {
    $('.seconds').html((si < 10 ? '0' : '')+si);
  }
}

function submit_hack(event) {
  var $col = $(event.currentTarget).parent();
  var id = $col.attr('id');
  var panel = id.charAt(id.length - 1);

  var $seq = $col.find('.connector');
  var binary = "";
  for(var idx = 0; idx < $seq.length; idx++) {
    var dp = $seq.eq(idx).hasClass('depressed');
    binary += dp ? 1 : 0;
  }

  attempt_hack($col, $seq, binary, panel);
}

function attempt_hack(col, seq, binary, panel) {
  $.get('/hack', {'binary': binary, 'panel': panel}, function(data) {
    if(data['success']){
      col.addClass('hacked');
      if(data['done']) {
        hack_success();
      }
    }
    else {
      seq.removeClass('depressed').html('0');
      for(var k=0; k<10; k++) {
        tick();
      }
      col.addClass('shake')
      setTimeout(function() {
        col.removeClass('shake');
      }, 1000);
    }
  });
}

function enter_code(event) {
  if($('.bomb').hasClass('hacked')) return;
  if($('.bomb').hasClass('detonated')) return;

  var code = $('#password').val();
  $.get('/code', {'code' : code }, function(data) {
    if(!data['success']) {
      $('#code-flash').html(data['attempts_remain'] + " attempts remain.");
    }

    if(data['state'] == 'armed') {
      $('.bomb').removeClass('disarmed')
      $('input[type="button"]').val('Disarm');
      if(!ticker)
        ticker = setInterval(tick, 1000);
    }
    else if(data['state'] == 'disarmed'){
      $('.bomb').addClass('disarmed');
      $('input[type="button"]').val('Arm');
      clearInterval(ticker);
      ticker = false;
    }
    else if(data['state'] == 'detonated') {
      detonate();
    }
    $('#password').val('');
  });
}
