$(function () {
  var typingTimer;
  var doneTypingInterval = 300;
  var search_form_selector = "#card-search";

  function makeRequest(data) {
    $.get($(search_form_selector).attr("action"), $(search_form_selector).serialize(), null, "script");
  }

  function loadCards () {
    $('input[name="page"]').val("1");
    makeRequest();
  }

  function loadPagination (page) {
    $('input[name="page"]').val(page);
    makeRequest();
  }

  // Search by cardname
  $(search_form_selector).submit(function () { return false; });
  $(search_form_selector + " input").on("keyup", function () {
    if (typingTimer) clearTimeout(typingTimer);
    typingTimer = setTimeout(loadCards, doneTypingInterval);
  });

  // Search by tagname
  $.getJSON("/types", function (types) {
    $("#types").tagit({
      fieldName: "cardtypes[]",
      placeholderText: "Card type",
      availableTags: types,
      showAutocompleteOnFocus: true,
      beforeTagAdded: function (event, ui) {
        var type = ui.tag[0].children[2].value;
        return types.indexOf(type) != -1;
      },
      afterTagAdded: function (event, ui) {
        loadCards();
      },
      afterTagRemoved: function (event, ui) {
        loadCards();
      }
    });
  });
  $("#types").on("focusin", function () { $(this).addClass("focus"); });
  $("#types").on("focusout", function () { $(this).removeClass("focus"); });

  // Pagination
  $(document).on("click", ".divide.cards .pagination a", function (event) {
    event.preventDefault();
    var page = $(this).html();
    loadPagination(page);
    return false;
  });
});
