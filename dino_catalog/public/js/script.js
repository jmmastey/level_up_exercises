$(document).ready(function() {
  $('.remove-empty-values').submit(function() {
    $(this).find(':input').filter(function() { return !this.value; }).attr('disabled', 'disabled');
    return true; // make sure that the form is still submitted
  });
});
