$(document).ready(function(){
  $('#change').on('click', function(event){
    var new_code = $('#new_activate').val();
    var new_dcode = $('#new_deactivate').val();
    if (new_code.match(/^\d+$/)!=new_code  && new_code.length > 0) {
      event.preventDefault();
      $('.sidebar').append('<br>Code may only contain numeric values')
    }
    if (new_dcode.match(/^\d+$/)!=new_dcode && new_dcode.length > 0) {
      event.preventDefault();
      $('.sidebar').append('<br>Code may only contain numeric values')
    }
  });
});


