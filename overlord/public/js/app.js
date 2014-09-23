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
     window.location = "/enter/" + this.formatted_code();
   }
}

timer = {
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
  },
  "start" : function() {
    setInterval(function() {
      timer.update_time(timer.time - 1)
    }, 1000);
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

  var time_left = $('#timer-time').val();
  timer.update_time(time_left);
  var active_state = $('#codebox table caption').attr('data-value');
  if (active_state === "active") {
    timer.start();
  }
}
