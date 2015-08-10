var player = false;
var auto_switch = false;
var mouseover = false;

$(window).load(function() {
  first_video();
  $('.next-channel').click(next_channel);
  $('.prev-channel').click(prev_channel);
  $('.next-show').click(next_show);
  $('.prev-show').click(prev_show);
  $('.guide-button').click(toggle_guide);
  $('.channel').click(to_channel);
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
function to_channel(event) {
  var $targ = $(event.currentTarget);
  if($targ.hasClass('active')) return;

  var name = $targ.find('.channel-name').html();
  $.get('/to_channel',{'name': name}, update_player);
}

function first_video() {
  $.get('/now_showing', {}, update_player);
}

function update_player(player_info) {
  /* update detailed player information */
  $('.player .channel-details .number').html(player_info.channel_number);
  $('.player .channel-details .name').html(player_info.channel_name);
  $('.player .show-details .name').html(player_info.show_name);
  show_details();

  /* udpate active channel on guide */
  $('.channel.active').removeClass('active');
  $('.channel:nth-child('+(player_info.index+1)+')').addClass('active');
  setTimeout(hide_guide, 400);

  if(player){
    player.loadVideoById(player_info.show_id);
  }
  else {
    initialize_player(player_info.show_id);
    initialize_mouse_functions();
  }
}
function initialize_player(show) {
  player = new YT.Player('video', {
    videoId: show,
    playerVars: {
      iv_load_policy: 3,
      rel: false,
      showinfo: false
    },
    events: {
      'onReady': onPlayerReady,
      'onStateChange': onPlayerStateChange
    }
  });
}

function initialize_mouse_functions() {
  $('#video').mouseenter(function() {
    mouseover = true;
    show_details();
  });
  $('#video').mouseleave(function() {
    mouseover = false;
    hide_details();
  });
}

function onPlayerReady(event) {
  player_ready = true;
  event.target.playVideo();
}

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

function onPlayerStateChange(event) {
  clearTimeout(auto_switch);

  switch(event.data) {
    case YT.PlayerState.ENDED:
      next_show();
      break;
    case YT.PlayerState.UNSTARTED:
      auto_switch = setTimeout(next_show, 200);
      break;
    case YT.PlayerState.PLAYING:
      setTimeout(function() {
        hide_details();
      }, 2000);
      break;
    case YT.PlayerState.PAUSED:
    case YT.PlayerState.BUFFERING:
      show_details();
      break;
  }
}