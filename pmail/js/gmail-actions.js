function unstar (elem) {
  var starred_img = "images/star-outline.png";
  $(elem).toggleClass('starred');
  $(elem).toggleClass('star');
  $(elem).attr('src', starred_img);
}

function star (elem) {
  var star_img = "images/star.png";
  $(elem).toggleClass('star');
  $(elem).toggleClass('starred');
  $(elem).attr('src', star_img);
}

function toggleStarred (elem) {
  $(elem).hasClass('starred') ? unstar(elem) : star(elem);
}

function getNextSelectedEmailIndex (key_code) {
  var selected_email = $('tr.selected')[0];
  if (selected_email === undefined) return 1;

  var current_index = $('tr').index(selected_email) + 1;
  if (key_code === 38) {
    return (current_index === 1) ? current_index : current_index - 1;
  } else {
    return current_index + 1;
  }
}

function selectEmail (key_code) {
  var row = $('tr:nth-child(' + getNextSelectedEmailIndex(key_code) + ')');
  $('tr').removeClass('selected');
  row.addClass('selected');
}

function setupEmailSelectKeyboardShortcut () {
  $(window).on('keydown', function (event) {
    if (event.keyCode !== 38 && event.keyCode !== 40) return;
    event.preventDefault();
    selectEmail(event.keyCode);
  });
}

function setupStarringClickEvent () {
  $('.star, .starred').on('click', function (event) { toggleStarred(this); });
}

function setupSelectAllClickEvent () {
  $('.select-all input[type="checkbox"]').on('change', function () {
    var select_all = this.checked;
    $('input[type="checkbox"]').prop('checked', select_all);
  });
}

function setupToggleSettingsPanel () {
  $('.settings').on('click', function () { $('.settings-panel').toggle(); });
}

$(document).ready(function () {
  setupEmailSelectKeyboardShortcut();
  setupStarringClickEvent();
  setupSelectAllClickEvent();
  setupToggleSettingsPanel();
});
