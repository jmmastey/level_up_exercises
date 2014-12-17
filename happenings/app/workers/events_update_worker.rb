class EventsUpdateWorker
  @queue = :normal

  def generate(category = :theatre_in_chicago)
    events = EventAggregator.for(category).get_new_events
    events.each do |event|
      Resque.enqueue(self, event)
    end
  end

  def perform(event_info)
    CreateEvent.create(event_info)
  end
end
