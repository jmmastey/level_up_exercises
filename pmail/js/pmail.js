$(document).ready(function(){

  $('li').click(function() {
     $("li").removeClass("bold");
});
   $('li').click(function(event){
     event.stopPropagation();
     $(this).addClass("bold");
     });
});