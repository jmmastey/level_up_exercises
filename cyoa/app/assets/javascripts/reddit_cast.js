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
  $.get('/nextshow', {}, update_player);
}

function prev_show() {
  $('.loading-show').fadeIn();
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

  $('.active').removeClass('active');
  $targ.addClass('active');
  var name = $targ.find('.channel-name').html();
  $.get('/to_channel',{'name': name}, update_player);
}
function now_showing() {
  $.get('/now_showing', {}, update_player);
}

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

/**************************************
            CREATE CHANNEL
**************************************/
function new_channel(e) {
  e.preventDefault();

  var name = $('#channel_name').val();
  var tags = $('#channel_tags').val().split(',');
  $.post('/newchannel', {'name':name, 'tags':tags});

  $('.loading-new-channel span').html("Creating channel "+name+"...");
  $('.loading-new-channel').fadeIn();

  /* poll to see when ready */
  subscribers[name] = setInterval(function() {
    poll_for_new_channel(name)
  }, 1000);
  hide_new_channel_dialog();
  hide_guide();
}
function poll_for_new_channel(name) {
  $.get('/status', {'name': name}, function(data) {
    if(!data['ready']) return;

    console.log(data);

    addChannelToGuide(name);
    clearInterval(subscribers[name]);
    $('.loading-new-channel').fadeOut();

    if(data['count'] == 1) now_showing();
  });
}
function addChannelToGuide(name) {
  var channel_number = $('.channel').size() + 1;
  channel_number = (channel_number < 10 ? "0" : "") + channel_number

  var $channel = $('<div>').addClass('channel').click(to_channel);
  var $delete_icon = $('<i>').addClass('delete-icon fa fa-times').click(function(e) {
    show_delete_channel_dialog();
    e.stopPropagation();
  });
  var $active_icon = $('<i>').addClass('active-icon fa fa-play-circle-o');
  var $name = $('<span>').addClass('channel-name').html(name);
  var $num = $('<span>').addClass('channel-number').html(channel_number);

  $channel.append($delete_icon);
  $channel.append($active_icon);
  $channel.append($num);
  $channel.append($name);
  $('.channels').append($channel);
}

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
  $.post('/delete_channel', {'name': name});
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