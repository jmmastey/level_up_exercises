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
     // add code to send ajax
   }
}

timer = {
  "time": 0,
  "update_time" : function(time) {
    this.time = time;
    this.update_dom();
  },
  "formatted_time" : function() {
    var minutes = Helpers.padleft(Math.floor(this.time / 60), 2, '0');
    var seconds = Helpers.padleft(this.time % 60, 2, '0');
    return minutes + ":" + seconds
  },
  "update_dom" : function() {
    $('#timer-output').val(this.formatted_time());
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

  var time_left = $('#timer-time').val();
  timer.update_time(time_left);
}
