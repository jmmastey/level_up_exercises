var player = false;
var auto_switch = false;

$(window).load(function() {
  first_video();
  $('.next-channel').click(next_channel);
  $('.prev-channel').click(prev_channel);
  $('.next-show').click(next_show);
  $('.prev-show').click(prev_show);
  $('.player').mouseenter(function() {
    console.log("entering video...");
    show_details();
  });
  $('.player').mouseleave(function() {
    console.log("exiting video...");
    hide_details();
  });
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

function first_video() {
  $.get('/now_showing', {}, update_player);
}

function update_player(player_info) {
  console.log(player_info);
  $('.player .channel-details .number').html(player_info.channel_number);
  $('.player .channel-details .name').html(player_info.channel_name);
  $('.player .show-details .name').html(player_info.show_name);
  show_details();

  if(player){
    player.loadVideoById(player_info.show_id);
  }
  else {
    initialize_player(player_info.show_id);
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

function onPlayerReady(event) {
  player_ready = true;
  event.target.playVideo();
}

function show_details() {
  $('.player .details').removeClass('hidden');
}
function hide_details() {
  if(player.getPlayerState() == YT.PlayerState.PAUSED) return;

  $('.player .details').addClass('hidden');
}

function onPlayerStateChange(event) {
  console.log("State change: "+event.data);
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