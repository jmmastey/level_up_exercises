
def create_event(name, location, time)
  event = Event.new
  event[:name] = name
  event[:location] = location
  event[:time] = time
  event
end
