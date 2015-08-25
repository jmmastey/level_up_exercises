$(function () {
  if (!$("body").hasClass("cards index") && !$("body").hasClass("decks edit")) return;
  var typingTimer, sliderTimer;
  var doneTypingInterval = 300;
  var doneSlidingInterval = 200;
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

  function loadCardsFromSlider () {
    if (sliderTimer) clearTimeout(sliderTimer);
    sliderTimer = setTimeout(loadCards, doneSlidingInterval);
  }

  // Toggle advanced options
  $("#toggle-advanced-search .btn").on('click', function (event) {
    $("#advanced-options").slideToggle();
  });

  // Search by cardname
  $(search_form_selector).submit(function () { return false; });
  $(search_form_selector + " input").on("keyup", function () {
    if (typingTimer) clearTimeout(typingTimer);
    typingTimer = setTimeout(loadCards, doneTypingInterval);
  });

  // Search by cardcolor
  $("#mana input[type='checkbox']").on("change", function (event) {
    loadCards();
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

  // Initialize noUISlider
  function createRange(a, b) {
    var range = {min: a, max: b};
    for (var i = a + 1; i < b; i++) range[(i*10/2).toString()+'%'] = i;
    return range;
  }
  var slider = $(".mana-slider")[0];
  noUiSlider.create(slider, {
    range: createRange(0, 20),
    snap: true,
    start: [0, 20],
    connect: true,
    animate: false
  });
  slider.noUiSlider.on('update', function(values, handle) {
  	var value = parseInt(values[handle]);
    var min_or_max = (handle) ? 'maxmana' : 'minmana';
		$("input#" + min_or_max).val(value);
    loadCardsFromSlider();
  });
  $("input#minmana").on('change', function (event) {
    slider.noUiSlider.set([this.value, null]);
    loadCardsFromSlider();
  });
  $("input#maxmana").on('change', function (event) {
    slider.noUiSlider.set([null, this.value]);
    loadCardsFromSlider();
  });
  $("input#exactmana").on('change', function (event) {
    var range = this.value ? [this.value, this.value] : [0, 20];
    slider.noUiSlider.set(range);
    loadCardsFromSlider();
  });

  // Pagination
  $(document).on("click", ".divide.cards .pagination a", function (event) {
    event.preventDefault();
    var page = $(this).html();
    loadPagination(page);
  });
});
