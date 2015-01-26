$(document).ready( function() {
   $(".calc_btn").click(function(){
    $('.screen').append($(this).val());
  });
  $(".operator").click(function(){
    btnVal = $(this).val();
    if(btnVal == 'Activate'){
            $( "#dialog-confirm" ).dialog({
              resizable: false,
              height:200,
              modal: true,
              buttons: {
                "Activate bomb?": function() {
                  evaluateCode($('.screen').val(), btnVal, $("#bomb_id").val());
                  $( this ).dialog( "close" );
                },
                Cancel: function() {
                  $( this ).dialog( "close" );
                }
              }
            });
          }
      else if((btnVal == 'Submit') || (btnVal == 'Deactivate'))  {
        evaluateCode($('.screen').val(), btnVal, $("#bomb_id").val());
      }
  });
  var start = 0;
  var refreshId = window.setInterval(function(){
        $.ajax({
          type: "GET",
          url: "http://localhost:9292/bomb/"+$("#bomb_id").val(),
          dataType: "json",
          success: function(returnObject)
          {
            if(returnObject.status == "active")
            {
              $('.timer').css("display", "block");
              $(".bomb_wires").css("display", "block");
              $("#bomb_status").removeClass("bomb_inactive");
              $("#bomb_status").removeClass("bomb_explode");
              $("#bomb_status").addClass("bomb_active");
              $("#bomb_status").val("Active");
              $('.timer').html(((returnObject.detonation_time) - start) + " Seconds ");
              var html = ""
              var str = ""
              var btn_str = ""


              start += 1
            }
            else if(returnObject.status == "inactive")
            {
              $("#bomb_status").removeClass("bomb_active");
              $("#bomb_status").removeClass("bomb_explode");
              $("#bomb_status").addClass("bomb_inactive");
              $("#bomb_status").val("Inactive");
            }
            else
            {
              $('.timer').html(((returnObject.detonation_time) - start) + " Seconds ");
              $("#bomb_status").removeClass("bomb_active");
              $("#bomb_status").removeClass("bomb_inactive");
              $("#bomb_status").addClass("bomb_explode");
              $("#bomb_status").val("Exploded");
              start += 1
            }
          },
          error: function (xhr){
            if(xhr.status == 0)
            {
              clearInterval(refreshId);
            }
            }
        });
      }, 1000);

  function evaluateCode(code, btnvalue, bombid)
    {
      var action = btnvalue.toLowerCase();
      var datalist = {}
      if(action == "activate"){
        datalist = {activation_code: code, bomb_id: bombid}
      }
      else
      {
        datalist = {deactivation_code: code, bomb_id: bombid}
      }

      $.ajax({
        type: "POST",
        url: " http://localhost:9292/bomb/"+action,
        dataType: "json",
        data: JSON.stringify(datalist),
        success: function(returnObject)
        {

          if(returnObject.status == "active")
          {
            $("#bomb_status").removeClass("bomb_inactive");
            $("#bomb_status").addClass("bomb_active");
            $("#bomb_status").val("Active");
          }
        },
        error: function (xhr){  alert( 'xhr = '+xhr.status ); }
      });
    }

});
