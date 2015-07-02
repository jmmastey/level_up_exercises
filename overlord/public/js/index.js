var ticker;

$(function() {
  $('.connector').click(depress_button);
  $('input[type="submit"]').click(submit_hack);

  $('input[type="password"]').keyup(function(e){
      if(e.keyCode == 13)
      {
          $(this).trigger("enterKey");
      }
  });

  $('input[type="password"]').bind('enterKey', enter_code);
  $('input[type="button"]').click(enter_code);
});

function depress_button(event) {
  var $el = $(event.currentTarget);
  if($el.parent().hasClass('hacked'))
    return;

  $el.toggleClass('depressed');
  $el.html(1 - parseInt($el.html()));
}

function tick() {
  var s = $('.seconds').html();
  var si = parseInt(s) - 1;

  if(si == -1) {
    var m = $('.minutes').html();
    var mi = parseInt(m) - 1;
    if(mi == -1) {
      clearInterval(ticker);
      $('.bomb').addClass('detonated');
      $('.explosion-overlay').fadeIn(10);
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
        clearInterval(ticker);
        $('.bomb').addClass('hacked');
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

  var code = $('input[type="password"]').val();
  $.get('/code', {'code' : code }, function(data) {
    if(data['armed']) {
      $('.bomb').removeClass('disarmed')
      ticker = setInterval(tick, 1000);
    }
    else {
      $('.bomb').addClass('disarmed');
      clearInterval(ticker);
    }
  });
}
