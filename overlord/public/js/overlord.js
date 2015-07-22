timer = {
    time : 0,

    timeDisplay : function() {
        var minutes = Math.floor(this.time / 60);
        var seconds = this.time % 60;
        return minutes + ":" + seconds;
    },

    updateDisplay : function() {
        $('#timer-output').val(this.timeDisplay());
    },

    updateTimeDisplay : function(time) {
        this.time = time;
        if (time < 0) {
            //window.location.reload();
        }
        this.updateDisplay();
    },

    start : function() {
        setInterval(function() {
            timer.updateTimeDisplay(timer.time - 1)
        }, 1000);
    }
}

trigger = {
    activate : function() {
        $.post('/set/' + timer.time, function() {
            window.location = '/enter/' + $('#trigger-code').val();
        });
    }
}

$(document).ready(function() {
    $('#change-bomb-state').click(function(e) {
        trigger.activate();
    });

    $('#provision_bomb').validate({
        rules: {
            activation_code: {
                digits: true,
                minlength: 4,
                maxlength: 4
            },
            deactivation_code: {
                digits: true,
                minlength: 4,
                maxlength: 4
            },
            countdown_value: {
                digits: true
            }
        },
        messages: {
            activation_code: 'The activation code must be four numeric characters.',
            deactivation_code: 'The deactivation code must be four numeric characters.',
            countdown_value: 'The countdown value must be a whole number.'
        },
        errorLabelContainer: "#provision-error"
    });

    $('#provision-error').hide();

    var time_remaining = parseInt($('#timer-countdown').val());
    timer.updateTimeDisplay(time_remaining);
    if ($('#timer-started').val() == "true") {
        timer.start();
    }
});
