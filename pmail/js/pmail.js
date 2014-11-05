// $(document).ready(function(){
//    $('.menu li ').click(function(){
//      $(".menu li").removeClass("active");
//      $(this).addClass("active");
//   });

$(document).ready(function(){
   $('.menu li').click(function(){
     $(".menu li").removeClass("float-bar");
     $(this).addClass("float-bar");
  });

 $('.menu li').hover(
   function (){
     $(this).css({"background-color":"#F2F2F0"});
  },
  function (){
    $(this).css({"background-color":"white"});
  });
 });
 