var now_playing = []

$(function() {
  $('.next-channel').click(next_show);
  $('.prev-channel').click(prev_show);
});

function next_show() {
  $.get('/nextshow', {}, update_player);
}

function prev_show() {
  $.get('/prevshow', {}, update_player);
}

function next_channel() {
  $.get('/nextchannel', {}, update_player);
}

function prev_channel() {
  $.get('/prevchannel', {}, update_player);
}

function update_player(channel_info) {
  $('.player .channel .number').html(channel_info.number);
  $('.player .channel .name').html(channel_info.name);
  $('.video').html(video(channel_info.show));
}

function video(src) {
  return $("<embed>").attr('src', src);
}