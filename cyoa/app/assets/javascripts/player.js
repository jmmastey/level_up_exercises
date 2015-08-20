/**************************************
          PLAYER INIT/UPDATES
**************************************/
function update_player(player_info) {
  $('.loading-show').fadeOut();

  /* update detailed player information */
  $('.player .channel-details .number').html(player_info.channel_number);
  $('.player .channel-details .name').html(player_info.channel_name);
  $('.player .show-details .name').html(player_info.show_name);
  show_details();

  /* udpate active channel on guide */
  $('.channel.active').removeClass('active');
  $('.channel:nth-child('+(player_info.index+1)+')').addClass('active');

  if(player_info.show_id == "") {
    $('#video').css('visibility', 'hidden');
    return;
  }

  $('#video').css('visibility', 'visible');
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