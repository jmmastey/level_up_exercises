$('.configuration form').on('submit', function (event) {
    event.preventDefault();
    $.ajax({
        url: '/configure',
        type: 'POST',
        data: {
            'activation_code': $('input[name="configure_activation_code"]').val(),
            'deactivation_code': $('input[name="configure_deactivation_code"]').val()
        },
        dataType: 'text'
    })
      .done(function() {
          $('.interface').show();
          changePanel('panel-info');
          $('.bomb_status').html('Booted up!');
          $('.configuration').hide();
      })
      .fail(function() {
          $('.configuration .alert').show();
      });
});

$('.activate form').on('submit', function(event) {
    event.preventDefault();
    $.ajax({
        url: '/activate',
        type: 'POST',
        data: { 'activation_code': $('.activate input').val()},
        dataType: 'text'
    })
      .done(function() {
          $('.activate').hide();
          $('.bomb_status').html('Activated!');
          changePanel('panel-warning');
          $('.deactivate').show();
          $('.attempts').show();
          startTimer();
      })
      .fail(function() {
          $('.activate .alert').show();
      });
})

$('.deactivate form').on('submit', function(event) {
    event.preventDefault();
    $.ajax({
        url: '/deactivate',
        type: 'POST',
        data: { 'deactivation_code': $('.deactivate input').val()},
        dataType: 'text',

        success: function() {
            $('.interface').hide();
            changePanel('panel-success');
            $('.bomb_status').html('Deactivated!');
            $('.safe').show();
            $('.timer').hide();
        },
        statusCode: {
            400: function() {
                explode();
            },
            422: function (responseData) {
                $('.deactivate .alert').show();
                $('.attempts').html(responseData.responseText);
            }
        }
    });
})

function startTimer() {
    $('.timer').show();
    var c = $('.timer').attr('id');
    $('.timer').text(c);
    var dangerFlashing = null;
    setInterval(function() {
        c--;
        if (c >= 0) {
            $('.timer').text(c + ' seconds left');
        }
        if (c == 10) {
            $('.countdown').css('color', 'red');
            changePanel('panel-danger');
            dangerFlashing = setInterval(function(){
               $('body').toggleClass('backgroundRed');
            }, 500);
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

function changePanel(newClass) {
    var lastClass = $('.panel').attr('class').split(' ').pop();
    $('.panel').removeClass(lastClass);
    $('.panel').addClass(newClass);
}
