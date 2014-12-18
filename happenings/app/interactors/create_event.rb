class CreateEvent
  def initialize(event_info)
    @event_info = event_info
  end

  def self.create(event_info)
    new(event_info).create
  end

  def create
    default_values = { event_source: :theatre_in_chicago }
    attribs = default_values.merge(@event_info)
   
    #return nil if event_exists?(convert_attribs(attribs))
    Event.create(attribs)
  end

  private

  def event_exists?(event_info)
    time = 
    date = 
    Event.where(event_info).present?
  end

  def convert_attribs(event_info)
    dup_event_info = event_info.dup
    event_source_id = EventSource[dup_event_info.delete(:event_source)].id
    dup_event_info[:event_source_id] = event_source_id
    dup_event_info
  end
end
