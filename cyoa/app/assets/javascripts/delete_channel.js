
/**************************************
            DELETE CHANNEL
**************************************/
function toggle_delete_channel_dialog() {
  if($('.delete-channel-dialog').css('display') == 'none')
    show_delete_channel_dialog();
  else
    hide_delete_channel_dialog();
}
function hide_delete_channel_dialog() {
  $('.delete-channel-dialog').fadeOut();
}
function show_delete_channel_dialog() {
  var name = $(event.currentTarget).parent().find('.channel-name').html();
  var is_active = $(event.currentTarget).parent().hasClass('active');
  $('.delete-channel-dialog').data('name', name);
  $('.delete-channel-dialog').data('is_active', is_active);
  $('.delete-channel-dialog h2').html("Delete " + name + " Channel?");
  $('.delete-channel-dialog').fadeIn();
}
function delete_channel(event) {
  var name = $('.delete-channel-dialog').data('name');
  $.post('/channel/destroy', {'name': name});
  hide_delete_channel_dialog();

  /* update guide UI */
  var channels = $('.channel');
  var amend_channel_number = false;
  for(var k=channels.size() - 1; k>-1; k--) {
    var chname = channels.eq(k).find('.channel-name').html();
    if(chname == name) {
      channels.eq(k).remove();
      break;
    }
    else {
      var $num = channels.eq(k).find('.channel-number');
      var channel_number = parseInt($num.html());
      channel_number -= 1;
      channel_number = (channel_number < 10 ? "0" : "") + channel_number;
      $num.html(channel_number);
    }
  }

  /* Change channel if active*/
  if($('.delete-channel-dialog').data('is_active'))
    prev_channel();
}