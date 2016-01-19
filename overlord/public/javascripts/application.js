$(document).ready(function(){
fetchBombCodes();
$('#deactivation_code').hide();
function processState() {
  var user_input;
  var prev_active;
  fetchBombState();
  if($('#bomb-state').text()=='active') {
    user_input = $('#deactivation_code').val();
    prev_active = true;
  }
  else if($('#bomb-state').text()=='inactive') {
    user_input = $('#activation_code').val();
    prev_active = false;
  }
  verifyCode(user_input, prev_active);
}

function updateFromResult(prev_active) {
  var state = $('#bomb-state').text();
  if(prev_active == true) {
    if(state == 'disarmed'){
      $('#submit_code').hide();
    } 
    else if(state == 'active') {
      alert('Please enter correct deactivation code');
    } 
    else {
      $('#deactivation_code').hide();
      $('#submit_code').hide();
    }
  } 
  else{
    if(state == 'inactive') {}
    else{
      $('#activation_code').hide();
      $('#deactivation_code').show();
      $('#submit_code').prop('value', 'Deactivate');
      $('#bomb-state').text('active');
    }
  }
}
$('#submit_code').on('click', processState);

function fetchBombState() {
  $.ajax('/state',{
    success: function(response) {
       $('#bomb-state').text(response.state);
      }
  }
  );
}

function verifyCode(user_input, prev_active) {
  if(/^\d+$/.test(user_input)) {
  var url = '/verify_code/'.concat(user_input);
  $.ajax(url,{
      success: function(response) {
       $('#bomb-state').text(response.state);
      } ,
      complete: function() { updateFromResult(prev_active); }
  });
  }
  else {
    alert('Please enter numeric codes only!');
  }
}

function fetchBombCodes() {
  $.ajax('/fetch_bomb_codes',{
    success: function(response) {
       $('#bomb-state-div').data('activation-cd', response.activation_code);
       $('#bomb-state-div').data('deactivation-cd', response.deactivation_code);
      }
  }
  );
}
});
