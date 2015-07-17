$(document).ready(function() {
    $('#activate-bomb').click(function(e) {
        var regex = /(^\d{4}$)/;
        var activationCode = $('#activation-code');

        if (activationCode.val() === "" || !activationCode.val().match(regex)) {
            $('#notice').text('Activation code was inaccurate.');
        } else {
            $('#notice').text('');
            $('#bomb-state').text('Bomb is active.');
        }
    });

    $('#deactivate-bomb').click(function(e) {
        var regex = /(^\d{4}$)/;
        var deactivationCode = $('#deactivation-code');

        if (deactivationCode.val() === "" || !deactivationCode.val().match(regex)) {
            $('#notice').text('Deactivation code was inaccurate.');
        } else {
            $('#notice').text('');
            $('#bomb-state').text('Bomb is inactive.');
        }
    })
});
