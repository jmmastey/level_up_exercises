var intruder =0
$(document).ready(function(){
  // $('#reset').hide();
  // $('#activate').on('click', function(event){
  //   var entered_code = $('#code').val();
  //   var activate_code = '<%= session[:activate]%>'
  //   if (entered_code != '1234'){
  //     event.preventDefault();
  //     intruder++
  //    if (intruder < 3) {
  //     $('#login').append('<br>Failed attempt ' + intruder)
  //     } else {
  //       alert('Booooom')
  //       $('#reset').show();
  //       window.location.href = "/explode";
  //     }


  $('#change').on('click', function(event){
    var new_code = $('#new_activate').val();
    var new_dcode = $('#new_deactivate').val();

    if (new_code.match(/^\d+$/)!=new_code  || new_dcode.match(/^\d+$/)!=new_dcode) {
      event.preventDefault();
      $('.change').append('<br>Code may only contain numeric values')
    }
  });
});
// Use javascript to ensure only numbers for the
