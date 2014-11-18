// $(document).ready(function(){
//    $('.menu li ').click(function(){
//      $(".menu li").removeClass("active");
//      $(this).addClass("active");
//   });
//  });

$(document).ready(function(){
   $('.menu li').click(function(){
     $(".menu li").removeClass("float-bar");
     $(this).addClass("float-bar");
});

$('.select-button').click(function(){
  $(".boxmenu").toggle();
});

$('.more-button').click(function(){
  $(".morebox").toggle();
});

$('.mail-button').click(function(){
  $(".mail-dropdown").toggle();
});


$(".settings-button").click(function(){
  $('.box').toggle();
});


$(".app-image").click(function(){
  $('.app-wrapper').toggle();
});

});
