var monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
];
var after = "";
var before = "";
var page = 0;
var key_selected = 0;

$(function() {
  $(document).keydown(handleKeyDown);
  $('.dropdown').click(handleDropdownClick);
  $('.settings ~ .menu li').click(function(event) {
    $('.settings ~ .menu').addClass('hidden');
  });
  $('.current-app ~ .menu li').click(function(event) {
    $('.current-app ~ .menu li').removeClass('active');
    $(event.currentTarget).addClass('active');
    $('.current-app ~ .menu').addClass('hidden');
  })
  $('.gbutton.select .checkbox').click(handleSelect);
  $('.gbutton.select ~ .menu li').click(handleSelect);
  $('.tab-select div').click(function(event) {
    $('.tab-select div').removeClass('active');
    $(event.currentTarget).addClass('active');
  });
  $('.inboxes li').click(function(event) {
    $('.inboxes li').removeClass('active');
    $(event.currentTarget).addClass('active');
  });
  $('.picture').click(function(event) {
    $('.profile-dialog').toggleClass('hidden');
  });
  $('.prev-page').click(prevPage);
  $('.next-page').click(nextPage);
  nextPage();
});

function handleKeyDown(event) {
  if(event.keyCode != 38 
    && event.keyCode != 40
    && event.keyCode != 13) return;

  var $messages = $('.message');
  if(event.keyCode == 38)
    key_selected = Math.max(key_selected-1, 0);
  else if(event.keyCode == 40)
    key_selected = Math.min(key_selected+1, $messages.size()-1);
  else {
    console.log('clicking link!');
    $messages.eq(key_selected).find('a')[0].click();
  }

  $messages.removeClass('key-selected');
  $messages.eq(key_selected).addClass('key-selected');
}
function handleDropdownClick(event) {
  var clicked = "." + $(event.currentTarget).attr('class').split(/\s+/).join('.');

  var was_hidden = $(clicked+' ~ ul').hasClass('hidden');
  $('.menu').addClass('hidden');
  if(was_hidden)
    $(clicked+' ~ ul').removeClass('hidden');
}

function handleSelect(event) {
  $('.gbutton.select .checkbox').toggleClass('select-all');

  if($('.gbutton.select .checkbox').hasClass('select-all')){
    $('.select-check').prop('checked', true);
    $('.message').addClass('selected');
  }
  else {
    $('.select-check').prop('checked', false);
    $('.message').removeClass('selected');
  }
  $('.gbutton.select ~ .menu').addClass('hidden');
  event.stopPropagation();
}

function nextPage() {
  if((!after || after=="") && page != 0) return;

  page+=1;
  $.get('https://www.reddit.com/hot.json', {'after':after}, addMessages)
}
function prevPage() {
  if((!before || before=="") && page < 2) return;

  page-=1;
  $.get('https://www.reddit.com/hot.json', {'before':before}, addMessages)
}

function addMessages(json_data) {
  before = after;
  $('.messages').empty();

  var posts = json_data.data.children;
  after = json_data.data.after;
  posts.sort(postSort);

  for(var k=0; k<posts.length; k++) {
    addMessage(posts[k]);
  }

  $('.star').click(function(event) {
    $(event.currentTarget).toggleClass('starred');
  });
  $('.message input[type="checkbox"]').click(function(event) {
    $(event.currentTarget).parent().toggleClass('selected');
  });
  $('.message:first-child').addClass('key-selected');
}

function postSort(a,b) {
  return a.data.created_utc - b.data.created_utc;
}

function dateString(time) {
  var posted = new Date(1000 * parseInt(time));
  var today = new Date();
  var time_str = "";
  if(posted.getMonth() == today.getMonth()
    && posted.getDate() == today.getDate()) {
    var mins = posted.getMinutes();
    var hour = posted.getHours() + 1;
    time_str = hour + ":" + (mins < 10? "0" : "") + mins;
    time_str += (hour < 12 ? " am" : " pm");
  }
  else {
    time_str = monthNames[posted.getMonth()]+" "+posted.getDate();
  }
  return time_str;
}

function addMessage(params) {
  var message = '<li class="message ${read}">\
                  <input class="select-check" type="checkbox"/>\
                  <span class="star ${starred}"></span>\
                  <a href="${url}">\
                    <span class="sender">${author}</span>\
                    <span class="preview">\
                      <span class="subject">${title}</span>\
                      <span class="body">-${body}</span>\
                    </span>\
                    <span class="date">${date}</span>\
                  </a>\
                </li>';
  if(Math.random() < 0.75) 
    message = message.replace(' ${read}','');
  else 
    message = message.replace(' ${read}',' unread');

  if(Math.random() < 0.2) 
    message = message.replace(' ${starred}',' starred');
  else 
    message = message.replace(' ${starred}',' unstarred');

  message = message.replace('${author}', params.data.subreddit);
  message = message.replace('${title}', params.data.title);
  message = message.replace('${body}', params.data.url);
  message = message.replace('${url}', params.data.url);
  message = message.replace('${date}', dateString(params.data.created_utc));
  $('.messages').append($(message));
}