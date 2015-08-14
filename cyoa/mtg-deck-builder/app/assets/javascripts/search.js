$(function () {
  var typingTimer;
  var doneTypingInterval = 300;
  var form_selector = "#card-search";

  function loadCards() {
   $.get($(form_selector).attr("action"), $(form_selector).serialize(), null, "script");
  }

  // Search form
  $(form_selector).submit(function () { return false; });
  $(form_selector + " input").on("keyup", function () {
    if (typingTimer) clearTimeout(typingTimer);
    typingTimer = setTimeout(loadCards, doneTypingInterval);
  });

  $(form_selector + " input").on("keydown", function () {
    clearTimeout(typingTimer);
  });
});
