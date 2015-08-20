/**************************************
                TOGGLES
**************************************/
function show_details() {
  $('.player .details').removeClass('hidden');
}
function hide_details() {
  if(player.getPlayerState() == YT.PlayerState.PAUSED) return;
  if(mouseover) return;

  $('.player .details').addClass('hidden');
}

function toggle_guide() {
  if($('.guide').hasClass('hidden')) {
    show_guide();
  }
  else {
    hide_guide();
  }
}
function show_guide() {
  $('.guide').removeClass('hidden');
  showScrollIcons();
}
function showScrollIcons() {
  var channels = $('.channels')[0];
  if(channels.scrollHeight > channels.clientHeight) {
    $('.ld').removeClass('hidden');
  }
  else {
    $('.ld').addClass('hidden');
  }
}
function hide_guide() {
  $('.guide').addClass('hidden');
}

function toggle_new_channel_dialog() {
  if($('.new-channel-dialog').css('display') == 'none')
    show_new_channel_dialog();
  else
    hide_new_channel_dialog();
}
function hide_new_channel_dialog() {
  $('#channel_name').val('');
  $('#channel_tags').val('');
  $('.new-channel-dialog').fadeOut();
}
function show_new_channel_dialog() {
  $('.new-channel-dialog').fadeIn();
}