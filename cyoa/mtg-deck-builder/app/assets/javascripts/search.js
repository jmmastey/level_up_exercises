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
      tabIndex: 2,
      beforeTagAdded: function (event, ui) {
        var type = ui.tag[0].children[2].value;
        return types.indexOf(type) != -1;
      },
      afterTagAdded: function (event, ui) { loadCards(); },
      afterTagRemoved: function (event, ui) { loadCards(); }
    });
  });
  // Make tagit consistent with inputs
  $("#types").on("focusin", function () { $(this).addClass("focus"); });
  $("#types").on("focusout", function () { $(this).removeClass("focus"); });

  // Search by tagname
  $("#cardtext").tagit({
    fieldName: "cardtext[]",
    placeholderText: "Card text",
    allowSpaces: true,
    tabIndex: 3,
    afterTagAdded: function (event, ui) { loadCards(); },
    afterTagRemoved: function (event, ui) { loadCards(); }
  });
  $("#cardtext").on("focusin", function () { $(this).addClass("focus"); });
  $("#cardtext").on("focusout", function () { $(this).removeClass("focus"); });

  // Pagination
  $(document).on("click", ".divide.cards .pagination a", function (event) {
    event.preventDefault();
    var page = $(this).html();
    loadPagination(page);
  });
});
