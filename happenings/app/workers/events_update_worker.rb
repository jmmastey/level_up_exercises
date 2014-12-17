class EventsUpdateWorker
  @queue = :normal

  def generate(category = :theatre_in_chicago)
    events = EventAggregator.for(category).get_new_events
    Resque.enqueue(self, event_info)
  end

  def perform(event_info)
    Event.create(event_info)
  end
end
