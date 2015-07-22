$(document).ready(function() {
    $('#change-bomb-state').click(function(e) {
        window.location = '/enter/' + $('#trigger-code').val();
    });

    $('#provision_bomb').validate({
        rules: {
            activation_code: {
                number: true,
                minlength: 4,
                maxlength: 4
            },
            deactivation_code: {
                number: true,
                minlength: 4,
                maxlength: 4
            }
        },
        messages: {
            activation_code: 'The activation code must be four numeric characters.',
            deactivation_code: 'The deactivation code must be four numeric characters.'
        },
        errorLabelContainer: "#code-error"
    });

    $('#code-error').hide();
});
