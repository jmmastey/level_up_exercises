$(document).ready(function() {
    $('#activate-bomb').click(function(e) {
        var regex = /(^\d{4}$)/;
        var activationCode = $('#activation-code').val();

        if (activationCode === "" || !activationCode.match(regex)) {
            $('#notice').text('Activation code was inaccurate.');
        } else {
            $('#notice').text('');
            window.location = '/enter/' + activationCode;
        }
    });

    $('#deactivate-bomb').click(function(e) {
        var regex = /(^\d{4}$)/;
        var deactivationCode = $('#deactivation-code').val();

        if (deactivationCode === "" || !deactivationCode.match(regex)) {
            $('#notice').text('Deactivation code was inaccurate.');
        } else {
            $('#notice').text('');
            window.location = '/enter/' + deactivationCode;
        }
    })
});
