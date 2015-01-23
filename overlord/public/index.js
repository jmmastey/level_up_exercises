$(document).ready( function() {
      $(".submit").click(function(){
        datalist = { activation_code: $("#activation_code").val(), deactivation_code: $("#deactivation_code").val(),detonation_time: $("#detonation_time").val() };
        $.ajax({
        type: "POST",
        url: "http://localhost:9292/bomb",
        dataType: "json",
        data: JSON.stringify(datalist),
        success: function(returnObject)
        {
          $(location).attr('href',"http://localhost:9292/bomb/"+returnObject.id);
        },
        error: function (xhr){  alert( 'xhr = '+xhr.status ); }
      });
      });
    });