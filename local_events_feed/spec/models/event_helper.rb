def create_events
  [
   create_event("Party A", "North Side", "www.party.com/party-a.html"),
   create_event("Party B", "South Side", "www.party.com/party-b.html"),
   create_event("Party C", "East Side", "www.party.com/party-c.html")
  ]
end

def create_events_with_showings
  [
   create_event("Party A", "North Side", "www.party.com/party-a.html", [ten_oclock, nine_oclock, eight_oclock]),
   create_event("Party B", "South Side", "www.party.com/party-b.html", [eight_oclock]),
   create_event("Party C", "East Side", "www.party.com/party-c.html", [nine_oclock, ten_oclock])
  ]
end

def create_event(name, location, link, showing_times = [])
  event = Event.create(name: name, location: location, link: link)
  showing_times.each { |time| event.showings.create(time: time) }
  event
end

def new_event(name, location, link)
  Event.new(name: name, location: location, link: link)
end

def eight_oclock
  DateTime.parse("20141001T080000")
end

def nine_oclock
  DateTime.parse("20141001T090000")
end

def ten_oclock
  DateTime.parse("20141001T100000")
end
