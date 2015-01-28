
$(document).ready( function() {
  var start = 0;
  var refreshId = window.setInterval(function(){
    if($("#bomb_status").val() == "active")
    {
      $('.timer').css("display", "block");
      $(".bomb_wires").css("display", "block");
      $("#bomb_status").removeClass("bomb_inactive");
      $("#bomb_status").removeClass("bomb_explode");
      $("#bomb_status").addClass("bomb_active");
      $('.timer').html(((returnObject.detonation_time) - start) + " Seconds ");
      start += 1

    }
    else if($("#bomb_status").val() == "inactive")
    {
      $("#bomb_status").removeClass("bomb_active");
      $("#bomb_status").removeClass("bomb_explode");
      $("#bomb_status").addClass("bomb_inactive");
    }
    else if($("#bomb_status").val() == "explode")
    {
      $("#bomb_status").removeClass("bomb_active");
      $("#bomb_status").removeClass("bomb_inactive");
      $("#bomb_status").addClass("bomb_explode");
      $('.timer').html(((returnObject.detonation_time) - start) + " Seconds ");
    }
  },1000);
});