// Can't unit test a standard closure
var $ = jQuery;

function Detonator() {
  if(this instanceof Detonator){
    this.connection = undefined;

    var detonator = this;

    $(document).on('change', '[name=mode]', function() {
      var code = $('[name=code]').val();
      detonator.sendCode(code);
    });

    $(document).on('click', '[name=trigger]', function(e) {
      e.preventDefault();
      detonator.activateBomb();
    });

    $(document).on('click', '.wires', function(e) {
      detonator.exposeWires();
    });

    $(document).on('click', '.wire', function() {
      detonator.cutWire($(this).data('idx'));
    });

    $(document).on('click', '.front-plate.reveal', function() {
      detonator.hideWires();
    });

    $(document).on('short', function() {
      detonator.shortCircuit();
    });
  } else {
    return new Detonator();
  }
};

Detonator.prototype.tick = function() {
  var detonator = this;
  $.ajax({
    url: '/BOMB/v1/',
    success: function(data) { detonator.tock(data) },
    error: function(a,b,c) { console.log("Error", a, b, c); },
    dataType: 'json'
  });
};

Detonator.prototype.tock = function(data) {
  $('body').addClass(data.state);
  switch(data.state) {
    case "inactive":
      $('.mode.active').removeClass("active");
      $('.mode.disarmed').addClass("active");
      $('[name=mode][value=disarmed]').prop("checked", true);
      $('[name=trigger]').prop("disabled", true);
      this.disconnectFromBomb();
      break;
    case "active":
      $('.mode.active').removeClass("active");
      $('.mode.armed').addClass("active");
      $('[name=mode][value=armed]').prop("checked", true);
      $('[name=trigger]').prop("disabled", false);
      break;
    case "disarmed":
    case "exploded":
      $(':input').attr("disabled", true);
      $('button').attr("disabled", true);
      this.disconnectFromBomb();
      break;
    default: break;
  }

  if(data.clock < 0) {
    data.clock = 0;
  }
  $('[name=clock]').val(data.clock);

  if(data.clock == "" || data.clock == 0) {
    this.disconnectFromBomb();
  }

  if(data.error && data.error != $('#error').data('last-error')) {
    var message = data.error;

    if(message == "bad_code") {
      message = "An invalid code was provided... you will never defeat me!";
    }
    $('#error .message').text(message)
    $('#error').modal("show");
    $('#error').data('last-error', data.error);
  }
};

Detonator.prototype.connectToBomb = function() {
  if(!this.isConnected()) {
    var detonator = this;
    this.connection = setInterval(function(){ detonator.tick(); }, 100);
  }
};

Detonator.prototype.disconnectFromBomb = function() {
  if(this.isConnected()) {
    clearInterval(this.connection);
    this.connection = undefined;
  }
};

Detonator.prototype.isConnected = function() {
  return (this.connection != undefined);
};

Detonator.prototype.post = function(action, callback, data, connect) {
  var detonator = this;
  if(typeof(callback)==='undefined') callback = detonator.tock;
  if(typeof(connect)==='undefined') connect = true;
  if(typeof(data)==='undefined') data = {};

  $('#error').data('last-error', "");
  $.post('/BOMB/v1/' + action, data, function(data) { callback.call(detonator, data) }, 'json');
  if(connect) {
    detonator.connectToBomb();
  }
};

Detonator.prototype.sendCode = function(code) {
  this.post('', this.tock, { code: code }, false);
};

Detonator.prototype.activateBomb = function() {
  this.post('trigger')
}

Detonator.prototype.shortCircuit = function() {
  this.post('short')
}

Detonator.prototype.fetchWires = function() {
  $('.wires .exposed').html('');
  $.get('/BOMB/v1/wires', { }, function(wires) {
    $.each(wires, function(i, wire) {
      var color = wire.type == "disarm" ? " blue" : " green";
      var state = wire.intact ? " intact" : " cut";
      $('.wires .exposed').append('<p class="wire'+color+state+'" data-idx="'+wire.index+'">Wire</p>');
    });
  });
}

Detonator.prototype.exposeWires = function() {
  if($('.wires .exposed').hasClass('hidden')) {
    this.fetchWires();
    $('.wires .exposed.hidden').removeClass('hidden');
    $('.front-plate').addClass('reveal');
  }
}

Detonator.prototype.hideWires = function() {
  if(!$('.wires .exposed').hasClass('hidden')) {
    $('.front-plate').removeClass('reveal');
    setTimeout(function(){ $('.wires .exposed').addClass('hidden'); }, 1000);
  }
}

Detonator.prototype.cutWire = function(idx) {
  this.post('wire/cut', function(data) {
    this.tock(data);
    this.fetchWires();
  }, { index: idx });
}
