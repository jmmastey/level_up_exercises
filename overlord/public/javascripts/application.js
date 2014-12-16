var intruder =0
$(document).ready(function(){
  $('#reset').hide();
  $('#activate').on('click', function(event){
    var entered_code = $('#code').val();
    var activate_code = '<%= session[:activate]%>'
    if (entered_code != '1234'){
      event.preventDefault();
      intruder++
     if (intruder < 3) {
      $('#login').append('<br>Failed attempt ' + intruder)
      } else {
        alert('Booooom')
        $('#reset').show();
        window.location.href = "/explode";
      }
    }
  })
});

