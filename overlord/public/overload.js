$('#boot_up').on('submit', function (event) {
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
    .done(function(data) {
      $('.activation').show()
      $('.panel').addClass('panel-info')
      $('.bomb_status').html("Booted up!")
      $('.configuration').hide()
    })
    .fail(function(data) {
      $('.error').show();
    });
});

$('#activation').on('submit', function(event) {
  event.preventDefault();
  $.ajax({
    url: '/activate',
    type: 'POST',
    data: { 'activation_code': $('input[name="submit_activation_code"]').val()},
    dataType: 'text'
  })
    .done(function(data) {
      $('.activate').hide()
      $('.bomb_status').html("Activated!")
      $('.panel').addClass('panel-warning')
      $('.deactivate').show()
      $('.attempts').show()
      start_timer();
    })
    .fail(function(json) {
      $('.activation_error').show()
    });
})


$('#deactivation').on('submit', function(event) {
  event.preventDefault();
  $.ajax({
    url: '/deactivate',
    type: 'POST',
    data: { 'deactivation_code': $('input[name="submit_deactivation_code"]').val()},
    accepts: "application/json",

    success: function(json) {
      $('.activation').hide()
      $('.panel').addClass('panel-success')
      $('.bomb_status').html("Deactivated!")
      $('.safe').show()
      $('.timer').hide()
    },
    statusCode: {
      400: function() {
        explode();
      },
      422: function (responseData, textStatus, errorThrown) {
        $('.deactivation_error').show()
        $('.attempts').html(responseData.responseText)
      }
    }
  })
})

function start_timer(){
    $('.timer').show()
    var c = $('.timer').attr('id');
    $('.timer').text(c);
    setInterval(function(){
        c--;
        if(c>=0){
            $('.timer').text(c + " seconds left");
        }
        if(c==0){
            // explode();
        }
    },1000);
}

function explode(){
  $('.activation').hide()
  $('.panel').addClass('panel-danger')
  $('.bomb_status').html("Exploded!")
  $('.attempts').hide()
  $('.timer').hide()
  $('.exploded').show()
}
