$(document).ready(function() {
  $("#boot-bomb").click(function bootBomb(){
    $("#error").html('');
    $.ajax({
      url: "/boot",
      data: {
        activation_code : $("#activation-code").val(),
        deactivation_code : $("#deactivation-code").val() },
      dataType: "json"
    }).done(function callback(response){
      console.log('response=' + JSON.stringify(response));
      if(response.error != null) {
        $("#error").html(response.error);
      } else {
        $('.boot_elem').css('visibility', 'hidden');
        $('.active_elem').css('visibility', 'visible');
      }
    });
  });

  $("#activate-bomb").click(function startBomb(){
    $("#error").html('');
    $.ajax({
      url: "/activate",
      data: {
        code : $("#code").val(),
        time: $("#time").val() },
      dataType: "json"
    }).done(function callback(response){
      console.log('response=' + JSON.stringify(response));
      if(response.error != null) {
        $("#error").html(response.error);
      }
      if(response.state == ':active') {
        $("#alarm").show();
        pollBombStatus();
      }
    });
  });

  $("#deactivate-bomb").click(function stopBomb(){
    $("#error").html('');
    $.ajax({
      url: "/deactivate",
      data: { code : $("#code").val() },
      dataType: "json"
    }).done(function callback(response){
      console.log('response=' + JSON.stringify(response));
      if(response.error != null) {
        $("#error").html(response.error);
      }
    });
  });
});

var pollBombStatus = function poll(){
    setTimeout(function() {
      var poll_xhr = $.ajax({
        url: "/state",
        dataType: "json",
        complete: poll,
        success: function(response) {
          console.log('poll response=' + JSON.stringify(response));
          $("#state").html(response.state);
          if(response.state == ':exploded') {
            addExplodeBackground();
          } else if(response.state != ':active') {
            $("#alarm").hide();
          }
        }
      });
    }, 1000);
};

function addExplodeBackground() {
  $body = $("body");
  $body.empty();
  $body.css("background-color", "black");
  $body.css("background-image", "url('img/boom.gif')");
  $body.css("background-repeat", "no-repeat");
  $body.css("background-attachment", "fixed");
  $body.css("background-position", "center");
}