/*
  On click of
*/
$(function(){
  manageButtonAction = "";
  checkStatus();
});

var checkStatus = function(){
  $.get("/bomb_status",function(status){
    $("#status").html("Status: "+status);


    if (status == "No Bomb") {
      $("#manageBtn").html("Create Bomb");
      manageButtonAction = "/create_bomb";
    } else if (status == "Inactive Bomb") {
      manageButtonAction = "/activate_bomb";
      $("#manageBtn").html("Activate Bomb");
      $(".activate").show();
      $(".deactivate").hide();
    } else if (status == "Active Bomb") {
      manageButtonAction = "/deactivate_bomb";
      $("#manageBtn").html("Deactivate Bomb");
      $(".activate").hide();
      $(".deactivate").show();
    }

  });
}
$("#manageBtn").click(function(){
  // var activationCode =
  $.post(manageButtonAction, $("form").serialize())
    .done(function(response){
      postProcess(response);
    });
});

var postProcess = function(response){
  console.log(response);
  checkStatus();
}
