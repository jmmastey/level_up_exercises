$(document).ready(function() {
    $('#change-bomb-state').click(function(e) {
        var regex = /(^\d{4}$)/;
        var enteredCode = $('#trigger-code').val();

        if (!enteredCode.match(regex)) {
            if ($('#change-bomb-state').val() === 'Activate') {
                $('#notice').text('Activation code was inaccurate.');
            } else {
                $('#notice').text('Deactivation code was inaccurate.');
            }
        } else {
            $('#notice').text('');
            window.location = '/enter/' + enteredCode;
        }
    });
});
