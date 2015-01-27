
$(document).ready( function() {
   $(".calc_btn").click(function(){
    $('.screen').val($('.screen').val() + $(this).val());
  });
  $(".clear").click(function(){
    $('.screen').val('');
  });
});