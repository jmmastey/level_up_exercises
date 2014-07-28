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
          regexp: {
            regexp: /^[0-9]{4}$/,
            message: 'Activation code must be 4 numbers'
          }
        }
      },
      'post[deactivation-code]': {
        message: 'The deactivation code is not valid',
        validators: {
          notEmpty: {
            message: 'Deactivation code required and cannot be empty'
          },
          regexp: {
            regexp: /^[0-9]{4}$/,
            message: 'Deactivation code must be 4 numbers'
          }
        }
      }
    }
  });

  $('#activateForm').bootstrapValidator({
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
      'post[seconds-to-boom]': {
        message: 'You are probably going to kill yourself.',
        validators: {
          notEmpty: {
            message: 'Do you really want to kill yourself? Give yourself at least one second.'
          },
          regexp: {
            regexp: /^([0-9]{1,5})$/,
            message: 'We need to see fireworks sooner.'
          }
        }
      },
      'post[activation-code]': {
        message: 'The activation code is not valid',
        validators: {
          notEmpty: {
            message: 'activation code required and cannot be empty'
          }
        }
      }
    }
  });

});
