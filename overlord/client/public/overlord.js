$(function() {
  $("#bomb_reset_btn").click(function() {
    $.ajax({
      url: 'http://localhost:4567/bomb',
      type: 'PUT',
      crossDomain: true,
      success: function(data) {
        message = data["message"];
        $("#bomb_reset_btn").parent().find(".status").text(message)
      },
      error: function(data) {
        alert("Error Resetting Bomb");
      }
    });
  });

  $("#bomb_boot_btn").click(function() {
    $.ajax({
      url: 'http://localhost:4567/boot',
      type: 'POST',
      crossDomain: true,
      success: function(data) {
        message = data["message"];
        $("#bomb_boot_btn").parent().find(".status").text(message)
      },
      error: function(data) {
        alert("Error Booting Bomb");
      }
    });
  });

  status_timer = setInterval(function() {
    $.ajax({
      url: 'http://localhost:4567/',
      type: 'GET',
      crossDomain: true,
      success: function(data) {
        message = data["message"];
        $("#bomb_state").text(message)
      },
      error: function(data) {
        alert("Error Resetting Bomb");
      }
    });
  }, 500);
});
