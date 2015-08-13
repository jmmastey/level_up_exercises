$(document).ready(function () {
  $(".add").on("click", function () {
    var elem = $(this).siblings(".number-in-deck");
    elem.html(parseInt(elem.html()) + 1);
  });

  $(".remove").on("click", function () {
    var elem = $(this).siblings(".number-in-deck");
    if (elem.html() == 0) return;
    elem.html(parseInt(elem.html()) - 1);
  });
})
