$(document).ready(function () {
  var success = $('.alert.success');
  if (success.length > 0) {
    setTimeout(function () {
      success.slideUp(200);
    }, 3000);
  }
});
