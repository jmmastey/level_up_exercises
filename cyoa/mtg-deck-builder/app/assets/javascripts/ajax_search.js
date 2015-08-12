$(function () {
  // Disable form
  var form_selector = "#card-search";
  $(form_selector).submit(function () { return false; });
  // Search
  $(form_selector + " input").keyup(function () {
    $.get($(form_selector).attr("action"), $(form_selector).serialize(), null, "script");
  });
});
