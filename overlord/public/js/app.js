/*
 * author: Dr. Nefarious
 */


codebox = {
  "stack" : [],
  "formatted_code": function() {
    return this.stack.join('');
  },
  "update_dom" : function() {
    $('#codebox-code').val(this.formatted_code());
    if (this.stack.length < 4) {
      $('#codebox-code-display').addClass('has-error');
    } else {
      $('#codebox-code-display').removeClass('has-error');
    }
  },
  "press" : function(code) {
     if (this.stack.length < 4) {
       this.stack.push(code);
       this.update_dom();
     }
   },
   "delete" : function() {
     this.stack.pop();
     this.update_dom();
   },
   "enter" : function() {
     if (this.stack.length < 4) { return; }
     window.location = "/enter/" + this.formatted_code() + "/" + timer.time;
   }
}

timer = {
  "active" : false,
  "time": 0,
  "update_time" : function(time) {
    this.time = time;
    if (time < 0) {
      window.location.reload();
    }
    this.update_dom();
  },
  "formatted_time" : function() {
    var minutes = Helpers.padleft(Math.floor(this.time / 60), 2, '0');
    var seconds = Helpers.padleft(this.time % 60, 2, '0');
    return minutes + ":" + seconds
  },
  "update_dom" : function() {
    $('#timer-output').val(this.formatted_time());
    if (this.time < 10) {
      time = 10 - this.time;
      $('.progress-bar').css({"width" : time + "0%"});
    } else {
      $('.progress-bar').css({"width" : "0%"});
    }
  },
  "increment" : function() {
    if (!this.active) {
      this.update_time(this.time + 1);
    }
  },
  "decrement" : function() {
    if (!this.active && this.time > 1) {
      this.update_time(this.time - 1);
    }
  },
  "start" : function() {
    this.active = true;
    setInterval(function() {
      timer.update_time(timer.time - 1)
    }, 1000);
  },
  "reset" : function() {
    if (!this.active) {
      this.update_time(30);
    }
  }
}

wirebox = {
  "snip" : function(color) {
    window.location = "/snip/" + color;
  }
}

Helpers = {
  "padleft" : function(string, count, fill) {
    var buff = '' + string
    for(var idx = buff.length; idx < count; idx++) {
      buff = fill + buff;
    }
    return buff;
  },
  "padright" : function(string, count, char) {
    var buff = '' + string
    for(var idx = buff.length; idx < count; idx++) {
      buff += fill
    }
    return buff;
  }
}

window.onload = function() {
  $('#codebox button').click(function(e) {
    var code = e.target.getAttribute('data-value');
    codebox.press(code);
  });

  $('#codebox-delete').click(function(e) {
    codebox.delete();
  });

  $('#codebox-enter').click(function(e) {
    codebox.enter();
  });

  $('.wire').click(function(e) {
    var color = e.target.getAttribute('data-value');
    wirebox.snip(color);
  });

  $('#timer-increment').click(function() {
    timer.increment();
  });
  $('#timer-decrement').click(function() {
    timer.decrement();
  });
  $('#timer-reset').click(function() {
    timer.reset();
  });

  var time_left = parseInt($('#timer-time').val());
  timer.update_time(time_left);
  var active_state = $('#codebox table caption').attr('data-value');
  if (active_state === "active") {
    timer.start();
  }
}
