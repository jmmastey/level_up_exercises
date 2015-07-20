$('#boot_up').on('submit', function (event) {
  event.preventDefault();
  $.ajax({
    url: '/configure',
    type: 'POST',
    data: {
            'activation_code': $('input[name="configure_activation_code"]').val(),
            'deactivation_code': $('input[name="configure_deactivation_code"]').val()
          },
    accepts: "application/json",
    success: function(json) {
      $('.activation').show()
      $('.bomb_status').html("Bomb has been booted up!")
      $('.configuration').hide()
    },
    error: function(json) {
      $('.error').show();
    }
  })
});

$('#activation').on('submit', function(event) {
  event.preventDefault();
  $.ajax({
    url: '/activate',
    type: 'POST',
    data: { 'activation_code': $('input[name="submit_activation_code"]').val()},
    accepts: "application/json",
    success: function(json) {
      $('.activate').hide()
      $('.bomb_status').html("Bomb has been activated!")
      $('.deactivate').show()
    },
    error: function(json) {
      $('.activation_error').show()
    }
  })
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
      $('.bomb_status').html("Bomb has been deactivated!")
      $('.safe').show()
    },
    statusCode: {
      400: function() {
        $('.activation').hide()
        $('.bomb_status').html("Bomb has exploded!")
        $('.exploded').show()
      },
      422: function() {
        $('.deactivation_error').show()
      }
    }
  })
})
