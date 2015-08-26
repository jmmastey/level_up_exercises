function maybeTrue () {
  return Math.random() < 0.5;
}

function maybeUnread () {
  return maybeTrue() ? 'class="unread"' : '';
}

function maybeStarred() {
  var is_starred = maybeTrue();
  var class_name = is_starred ? "starred" : "star";
  var image_src = is_starred ? "images/star.png" : "images/star-outline.png";
  var alt = is_starred ? "Unstar this email" : "Star this email";

  var star = '<img class="' + class_name + '" ';
  star += 'src="' + image_src + '" ';
  star += 'alt="' + alt + '" />';
  return star;
}

function createTable (n_rows) {
  var table = "<table>"
  for (var i = 0; i <= n_rows; i++) {
    table += "<tr " + maybeUnread() + ">";
    table += '<td class="checkbox-select"><input type="checkbox" /></td>';
    table += '<td class="star-email">' + maybeStarred(); + '</td>';
    table += '<td class="from">From</td>';
    table += '<td class="subject">This is a subject line';
    table += "<span>- This is a preview of your message.</span>"
    table += "</td>";
    table += '<td class="time-sent">Jan 1</td>';
    table += "</tr>";
  }
  table += "</table>";
  return table;
}

function countUnread () {
  return $('tr.unread').length;
}

function setHeightForEmailsOverflow () {
  $('.emails').css('height', getHeightForEmailsOverflow());
}

function getHeightForEmailsOverflow () {
  var window_h = $(window).height();
  var header_h = $("#header").outerHeight()
  var section_header_h = $(".content .section-header").outerHeight();
  return window_h - header_h - section_header_h;
}

$(document).ready(function () {
  setHeightForEmailsOverflow();
  $(window).resize(setHeightForEmailsOverflow);

  $('.emails').html(createTable(25))
  $('.n-unread').html(countUnread());
});
