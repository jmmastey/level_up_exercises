// Get all the keys from document
var keys = document.querySelectorAll('#bomb span');
var operators = ['+', '-', 'x', '÷'];
var decimalAdded = false;

for(var i = 0; i < keys.length; i++) {
  keys[i].onclick = function(e) {
    var input = document.querySelector('.screen');
    var inputVal = input.innerHTML;
    var btnVal = this.innerHTML;

    if(btnVal == 'C') {
      input.innerHTML = '';
      decimalAdded = false;
    }


    else {

      var lastChar = inputVal[inputVal.length - 1];

      if(inputVal != '' && operators.indexOf(lastChar) == -1)
        input.innerHTML += btnVal;

      else if(inputVal == '' && btnVal == '-')
        input.innerHTML += btnVal;

      if(operators.indexOf(lastChar) > -1 && inputVal.length > 1) {
        input.innerHTML = inputVal.replace(/.$/, btnVal);
      }

      decimalAdded =false;
    }

    // prevent page jumps
    e.preventDefault();
  }
}

$(document).ready( function() {

      $(".wire_btn").click(function(){
        var btn_color = this.id.split("_")[0];
        var datalist = { color: btn_color, bomb_id: $("#bomb_id").val() };
        $.ajax({
          type: "POST",
          url: $("#base_url").val()+"/bomb/diffuse",
          data: JSON.stringify(datalist),
          dataType: "json",
          success: function(returnObject)
          {
          }
        });
      })

      var keys = document.querySelectorAll('#bomb span');
      for(var i = 0; i < keys.length; i++) {
        keys[i].onclick = function(e) {
          var input = document.querySelector('.screen');
          var inputVal = input.innerHTML;
          var btnVal = this.innerHTML;
          if(btnVal == 'Activate'){
          $( "#dialog-confirm" ).dialog({
              resizable: false,
              height:200,
              modal: true,
              buttons: {
                "Activate bomb?": function() {
                  evaluateCode(input.innerHTML, btnVal, $("#bomb_id").val());
                  $( this ).dialog( "close" );
                },
                Cancel: function() {
                  $( this ).dialog( "close" );
                }
              }
            });
          }
          else if((btnVal == 'Submit') || (btnVal == 'Deactivate'))  {
            evaluateCode(input.innerHTML, btnVal, $("#bomb_id").val());
          }
          else if (btnVal == 'Configure')
          {
            configureBomb();
          }
          else if(btnVal == 'C') {
            input.innerHTML = '';
          }
          else {
            input.innerHTML += btnVal;
          }
        }
      }
      var start = 0;
      var refreshId = window.setInterval(function(){
        var baseurl = $("#base_url").val();
        $.ajax({
          type: "GET",
          url: baseurl+"/bomb/"+$("#bomb_id").val(),
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
              $("#bomb_status").removeClass("bomb_active");
              $("#bomb_status").removeClass("bomb_inactive");
              $("#bomb_status").addClass("bomb_explode");
              $('.timer').html(((returnObject.detonation_time) - start) + " Seconds ");
              $("#bomb_status").val("Exploded");
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
        url: $("#base_url").val()+"/bomb/"+action,
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
