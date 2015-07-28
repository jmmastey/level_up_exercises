var bomb = {
    timer:              null,
    dangerFlashing:     null,

    startTimer: function () {
        $('.timer').show();
        var c = $('.timer').attr('id');
        $('.timer').text(c);
        bomb.timer = setInterval(function() {
            c--;
            if (c >= 0) {
                $('.timer').text(c + ' seconds left');
            }
            if (c == 10) {
                bomb.danger();
            }
            if (c === 0) {
                bomb.explode();
                clearInterval(bomb.dangerFlashing);
            }
        }, 1000);
    },

    explode: function () {
        $('.interface').hide();
        bomb.changePanel('panel-danger');
        $('.bomb_status').html('Exploded!');
        $('.attempts').hide();
        $('.timer').hide();
        $('.exploded').show();
    },

    deactivate: function() {
        $('.interface').hide();
        bomb.changePanel('panel-success');
        $('.bomb_status').html('Deactivated!');
        $('.safe').show();
        $('.timer').hide();
        clearInterval(bomb.timer);
        clearInterval(bomb.dangerFlashing);
    },

    activate: function() {
        $('.activate').hide();
        $('.bomb_status').html('Activated!');
        bomb.changePanel('panel-warning');
        $('.deactivate').show();
        $('.attempts').show();
        bomb.startTimer();
    },

    boot: function() {
        $('.interface').show();
        bomb.changePanel('panel-info');
        $('.bomb_status').html('Booted up!');
        $('.configuration').hide();
    },

    danger: function() {
        $('.countdown').css('color', 'red');
        bomb.changePanel('panel-danger');
        bomb.dangerFlashing = setInterval(function() {
           $('body').toggleClass('backgroundRed');
        }, 500);
    },
    changePanel: function(newClass) {
        var lastClass = $('.panel').attr('class').split(' ').pop();
        $('.panel').removeClass(lastClass);
        $('.panel').addClass(newClass);
    },

    insertErrors: function(selector, errors) {
        $('.errors').html('');
        for(var i = 0; i < errors.length; i++) {
            var errorDiv = '<div class="alert alert-danger"' +
                           'style="display: block;">' +
                           errors[i] + '</div>';
            $(selector + ' .errors').append(errorDiv);
        }
        $(selector + ' .alert').show();
    }
};

$('.configuration form').on('submit', function (event) {
    event.preventDefault();
    var activationCode = $('input[name="configure_activation_code"]').val();
    var deactivationCode = $('input[name="configure_deactivation_code"]').val();

    $.ajax({
        url: '/configure',
        type: 'POST',
        data: {
            'activation_code':  activationCode,
            'deactivation_code': deactivationCode
        },
        dataType: 'json',
        success: function() { bomb.boot(); },
        error: function (data) {
            bomb.insertErrors('.configuration', data.responseJSON.errors);
        }
    });
});

$('.activate form').on('submit', function(event) {
    event.preventDefault();
    $.ajax({
        url: '/activate',
        type: 'POST',
        data: { 'activation_code': $('.activate input').val()},
        dataType: 'json',
        success: function() { bomb.activate(); },
        error: function (data) {
          bomb.insertErrors('.activate', data.responseJSON.errors);
        }
    });
});

$('.deactivate form').on('submit', function(event) {
    event.preventDefault();
    $.ajax({
        url: '/deactivate',
        type: 'POST',
        data: { 'deactivation_code': $('.deactivate input').val()},
        dataType: 'json',
        success: function() { bomb.deactivate(); },
        statusCode: {
            400: function() { bomb.explode(); },
            422: function (data) {
                bomb.insertErrors('.deactivate', data.responseJSON.errors);
                $('.attempts').html(data.responseJSON.attempts);
            }
        }
    });
});
