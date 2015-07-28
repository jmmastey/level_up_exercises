var timer = null;
var dangerFlashing = null;

$('.configuration form').on('submit', function (event) {
    event.preventDefault();
    $.ajax({
        url: '/configure',
        type: 'POST',
        data: {
            'activation_code': $('input[name="configure_activation_code"]').val(),
            'deactivation_code': $('input[name="configure_deactivation_code"]').val()
        },
        dataType: 'json',
        success: function(data) { boot(); },
        error: function (data) {
            insert_errors('.configuration', data.responseJSON['errors'])
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
        success: function(data) { activate(); },
        error: function (data) {
          insert_errors('.activate', data.responseJSON['errors'])
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
        success: function(data) { deactivate(); },
        statusCode: {
            400: function() { explode(); },
            422: function (data) {
                insert_errors('.deactivate', data.responseJSON['errors'])
                $('.attempts').html(data.responseJSON['attempts']);
            }
        }
    });
})

function startTimer() {
    $('.timer').show();
    var c = $('.timer').attr('id');
    $('.timer').text(c);
    timer = setInterval(function() {
        c--;
        if (c >= 0) {
            $('.timer').text(c + ' seconds left');
        }
        if (c == 10) {
            danger();
        }
        if (c === 0) {
            explode();
            clearInterval(dangerFlashing);
        }
    }, 1000);
}

function explode() {
    $('.interface').hide();
    changePanel('panel-danger');
    $('.bomb_status').html('Exploded!');
    $('.attempts').hide();
    $('.timer').hide();
    $('.exploded').show();
}

function deactivate() {
    $('.interface').hide();
    changePanel('panel-success');
    $('.bomb_status').html('Deactivated!');
    $('.safe').show();
    $('.timer').hide();
    clearInterval(timer);
    clearInterval(dangerFlashing);
}

function activate() {
    $('.activate').hide();
    $('.bomb_status').html('Activated!');
    changePanel('panel-warning');
    $('.deactivate').show();
    $('.attempts').show();
    startTimer();
}

function boot() {
    $('.interface').show();
    changePanel('panel-info');
    $('.bomb_status').html('Booted up!');
    $('.configuration').hide();
}

function danger() {
    $('.countdown').css('color', 'red');
    changePanel('panel-danger');
    dangerFlashing = setInterval(function(){
       $('body').toggleClass('backgroundRed');
    }, 500);
}

function changePanel(newClass) {
    var lastClass = $('.panel').attr('class').split(' ').pop();
    $('.panel').removeClass(lastClass);
    $('.panel').addClass(newClass);
}

function insert_errors(selector, errors) {
    $('.errors').html('')
    for(var i = 0; i < errors.length; i++){
        error_div = '<div class="alert alert-danger" role="alert" style="display: block;"><span aria-hidden="true" class="glyphicon glyphicon-exclamation-sign"></span>' + errors[i] + '</div>'
        $(selector + ' .errors').append(error_div)
    }
    $(selector + ' .alert').show();
}
