settings = {eventLimit:{
  'agenda': 6,
  'default': true
},
header:{
  left: 'prev,next today',
  center: 'title',
  right: 'month,agendaWeek,agendaDay'
},
editable: false,
eventLimit: true,
events: 'event_dates.json'}

$(document).ready ->
  $('#calendar').fullCalendar settings

