$(document).ready(function(){
$('#deactivation_code').hide();
function processState() {
if($('#bomb-state').text()=='active') {
user_input = $('#deactivation_code').val();
if(user_input == $('#bomb-state-div').data('deactivation-cd')){
  $('#bomb-state').text('disarmed');
  $('#submit_code').hide();
} else {
  var deac = $('#bomb-state-div').data('deactivations');
  $('#bomb-state-div').data('deactivations', deac+1);
  if(deac <=1) {
  alert('Please enter correct deactivation code');
  } else{
  $('#bomb-state').text('exploded');
  $('#deactivation_code').hide();
  $('#submit_code').hide();
}
}

}
else if($('#bomb-state').text()=='inactive'){
user_input = $('#activation_code').val();
if(user_input == $('#bomb-state-div').data('activation-cd')){
 alert("Bomb is Activated");
$('#bomb-state').text('active');
$('#activation_code').hide();
$('#deactivation_code').show();
}}}
$('#submit_code').on('click', processState);
});
