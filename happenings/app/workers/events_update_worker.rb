class EventsUpdateWorker
  @queue = :normal

  def generate(source = :theatre_in_chicago)
    events = EventAggregator.for(source).get_events_between
    events.each do |event|
      Resque.enqueue(self, event)
    end
  end

  def perform(event_info)
    CreateEvent.create(event_info)
  end
end
