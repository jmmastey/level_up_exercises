$(function() {

  // Check and uncheck emails

  $('.emails').on('click', 'tr span:first-of-type', function() {
    var $checkbox = $(this);
    $checkbox.closest('tr').toggleClass('checked');
    $checkbox.toggleClass('fa-square-o fa-check-square-o');
  });

});
