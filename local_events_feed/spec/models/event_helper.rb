def create_events
  [create_event("Party A", "North Side", "2014-10-01T18:00:00", "www.party.com/party-a.html"),
   create_event("Party B", "South Side", "2014-10-02T19:00:00", "www.party.com/party-b.html"),
   create_event("Party C", "East Side", "2014-10-03T20:00:00", "www.party.com/party-c.html")]
end

def create_event(name, location, time, link)
  Event.create(name: name,
               location: location,
               time: time,
               link: link)
end

def new_event(name, location, time, link)
  Event.new(name: name,
            location: location,
            time: time,
            link: link)
end
