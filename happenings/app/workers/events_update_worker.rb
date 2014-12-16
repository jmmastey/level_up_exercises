class EventsUpdateWorker
  def generate
    events = EventSchedule.get_new_events
    Resque.enqueue(self, event_info)
  end

  def perform(event_info)
    Event.create(event_info)
  end
end
