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
   "submit" : function() {
     // add code to send ajax
   }
}


window.onload = function() {
  $('#codebox button').click(function(e) {
    var code = e.target.textContent;
    codebox.press(code);
  });

  $('#codebox-delete').click(function(e) {
    codebox.delete();
  });
}
