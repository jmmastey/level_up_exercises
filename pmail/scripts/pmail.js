//check for keypresses, specifically up and down arrows
$(document).keydown(function(e) {
  if (e.which == 38) {
    mailNavigate('up');
  } else if (e.which == 40) {
    mailNavigate('down');
  }
});

//traverse, up and down, the list of mail being shown
function mailNavigate(direction) {
  mail_items = mailItems();
  mail_hover = mailHover();
  //check for no previous action
  if (mail_hover.length == 0 && mail_items.length > 0) {
    $(mail_items[0]).addClass('mail-item-hover');
  } else {
    hover_index = mail_hover[0].id.split("-")[1];

    if (direction == 'up' && hover_index != 1) {
      mailHighlight(hover_index, parseInt(hover_index) - 1);
    } else if (direction == 'down' && hover_index != mail_items.length) {
      mailHighlight(hover_index, parseInt(hover_index) + 1);
    }
  }
}

//highlight a new mail item, removing the highlight from the old item
function mailHighlight(old_id, new_id) {
  $('#mail-' + old_id).removeClass('mail-item-hover');
  $('#mail-' + new_id).addClass('mail-item-hover');
}

//get total mail items being shown
function mailItems() {
  return $('.mail-item').map(function(index) {
    return this;
  });
}

//get total mail items being shown
function mailHover() {
  return $('.mail-item-hover').map(function(index) {
    return this;
  });
}

//show the user profile popup box
function showUserProfile() {
  $("#popup-user-profile-container").show();
}

//hide the user profile popup box
function hideUserProfile() {
  $("#popup-user-profile-container").hide();
}