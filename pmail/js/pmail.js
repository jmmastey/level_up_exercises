$(document).ready(function(){

  $('li').click(function() {
     $("li").removeClass("bold");
});
   $('li').click(function(event){
     event.stopPropagation();
     $(this).addClass("bold");
     });
  

 $('li').hover(
   function (){
     $(this).css({"background-color":"#F2F2F0"});
  },
  function () {
           $(this).css({"background-color":"white"});
  }

  );
 });