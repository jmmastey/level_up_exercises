$(document).ready(function() {
    $('#change-bomb-state').click(function(e) {
        var regex = /(^\d{4}$)/;
        var enteredCode = $('#trigger-code').val();

        if (!enteredCode.match(regex)) {
            if ($('#change-bomb-state').val() === 'Activate') {
                $('#notice').text('Activation code was invalid.');
            } else {
                $('#notice').text('Deactivation code was invalid.');
            }
        } else {
            $('#notice').text('');
            window.location = '/enter/' + enteredCode;
        }
    });
});
