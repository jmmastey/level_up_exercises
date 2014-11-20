$(function() {

  function is_valid_input(input) {
    return !!input.match(/^\s*\d{4}\s*$/)
  }

  function activate_on_valid_input(element) {
    var input  = $(element).val();
    var btn    = $(element).parents('form').find('button[type=submit]');

    is_valid_input(input) ? btn.removeAttr('disabled') : btn.attr('disabled', 'disabled');
  }

  $('body').on('keyup change', '.code-input', function() {
    activate_on_valid_input(this);
  });

  // Handle case where villain decide to copy paste the codes
  $('body').on('paste', '.code-input', function() {
    var that = this;

    setTimeout(function() {
      activate_on_valid_input(that)
    }, 100)
  });

});
