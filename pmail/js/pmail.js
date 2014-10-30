$(document).ready(function(){

  $('li').click(function() {
     $("li").removeClass("bold");
});
   $('li').click(function(event){
     event.stopPropagation();
     $(this).addClass("bold");
     });

    $('li').click(function() {
     $(this).css({"border-left": "0px"});
});
   $('li').click(function(event){
     event.stopPropagation();
     $(this).css({"border-left":"4px solid #dd4b39"});

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
