
/**************************************
            CREATE CHANNEL
**************************************/
function new_channel(e) {
  e.preventDefault();

  var name = $('#channel_name').val();
  var tags = $('#channel_tags').val().split(',');
  $.post('/channel/create', {'name':name, 'tags':tags});

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
  $.get('/channel/status', {'name': name}, function(data) {
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