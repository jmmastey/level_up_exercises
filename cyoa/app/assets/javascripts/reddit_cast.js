var player = false;
var auto_switch = false;
var mouseover = false;
var subscribers = {};

$(window).load(function() {
  now_showing();
  $(window).resize(showScrollIcons)
  $('.next-channel').click(next_channel);
  $('.prev-channel').click(prev_channel);
  $('.next-show').click(next_show);
  $('.prev-show').click(prev_show);
  $('.guide-button').click(toggle_guide);
  $('.channel').click(to_channel);
  $('.new-channel').click(show_new_channel_dialog);
  $('.cancel-new-channel').click(hide_new_channel_dialog);

  $('.channel-form').submit(new_channel);
  $('.delete-icon').click(function(e) {
    show_delete_channel_dialog();
    e.stopPropagation();
  });
  $('.cancel-delete').click(hide_delete_channel_dialog);
  $('.confirm-delete').click(delete_channel);
});

/**************************************
      CHANGING SHOWS/CHANNELS
**************************************/
function next_show() {
  $('.loading-show').fadeIn();
  $.get('/show/next', {}, update_player);
}

function prev_show() {
  $('.loading-show').fadeIn();
  $.get('/show/prev', {}, update_player);
}

function next_channel() {
  $.get('/channel/next', {}, update_player);
}

function prev_channel() {
  $.get('/channel/prev', {}, update_player);
}
function to_channel(event) {
  var $targ = $(event.currentTarget);
  if($targ.hasClass('active')) return;

  $('.active').removeClass('active');
  $targ.addClass('active');
  var name = $targ.find('.channel-name').html();
  $.get('/channel/to',{'name': name}, update_player);
}
function now_showing() {
  $.get('/channel', {}, update_player);
}


