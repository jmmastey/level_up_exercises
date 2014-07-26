$(document).ready(function(){
  $('#bootForm').bootstrapValidator({
    feedbackIcons: {
      valid: 'glyphicon glyphicon-ok',
      invalid: 'glyphicon glyphicon-remove',
      validating: 'glyphicon glyphicon-refresh'
    },
    live: 'enabled',
    message: 'This value is not valid',
    submitButtons: 'button[type="submit"]',
    trigger: null,
    fields: {
      'post[activation-code]': {
        message: 'The activation code is not valid',
        validators: {
          notEmpty: {
            message: 'Activation code required and cannot be empty'
          },
          stringLength: {
            min: 4,
            max: 4,
            message: 'Activation code must be exactly 4 numbers'
          }
        }
      },
      'post[deactivation-code]': {
        message: 'The deactivation code is not valid',
        validators: {
          notEmpty: {
            message: 'Deactivation code required and cannot be empty'
          },
          stringLength: {
            min: 4,
            max: 4,
            message: 'Deactivation code must be exactly 4 numbers'
          }
        }
      }
    }
  });
});
