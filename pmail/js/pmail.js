$(document).ready(function(){
   $('.menu li ').click(function(){
     $(".menu li").removeClass("active");
     $(this).addClass("active");

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
