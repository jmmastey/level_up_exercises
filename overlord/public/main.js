$(document).ready(function() {
  $("#boot-bomb").click(bootBomb);
  $("#activate-bomb").click(startBomb);
  $("#deactivate-bomb").click(stopBomb);
});

function bootBomb() {
  $(getErrorId()).html('');
  $.ajax({
    url: "/boot",
    data: {
      activation_code : $("#activation-code").val(),
      deactivation_code : $("#deactivation-code").val() },
    dataType: "json"
  }).done(function callback(response) {
    if(response.error != null) {
      $(getErrorId()).html(response.error);
    } else {
      $('.boot_elem').css('visibility', 'hidden');
      $('.active_elem').css('visibility', 'visible');
    }
  });
}

function startBomb() {
  $(getErrorId()).html('');
  $.ajax({
    url: "/activate",
    data: {
      code : $("#code").val(),
      time: $("#time").val() },
    dataType: "json"
  }).done(function callback(response) {
    if(response.error != null) {
      $(getErrorId()).html(response.error);
    }
    if(response.state == ':active') {
      $("#alarm").show();
      pollBombStatus();
    } else {
      $(getErrorId()).html("ERROR: " + response);
    }
  });
}

function stopBomb() {
  $(getErrorId()).html('');
  $.ajax({
    url: "/deactivate",
    data: { code : $("#code").val() },
    dataType: "json"
  }).done(function callback(response) {
    if(response.error != null) {
      $(getErrorId()).html(response.error);
    }
  });
}

var pollBombStatus = function poll() {
    setTimeout(function() {
      var poll_xhr = $.ajax({
        url: "/state",
        dataType: "json",
        complete: poll,
        success: function(response) {
          $("#state").html(response.state);
          if(response.state == ':exploded') {
            addExplodeBackground();
          } else if(response.state != ':active') {
            $("#alarm").hide();
          } else {
            $(getErrorId()).html("ERROR: " + response);
          }
        }
      });
    }, 1000);
};

function getErrorId() {
  return "#error";
}

function addExplodeBackground() {
  $body = $("body");
  $body.empty();
  $body.css("background-color", "black");
  $body.css("background-image", "url('img/boom.gif')");
  $body.css("background-repeat", "no-repeat");
  $body.css("background-attachment", "fixed");
  $body.css("background-position", "center");
}