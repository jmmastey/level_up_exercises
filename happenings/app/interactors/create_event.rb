module CreateEvent
  def self.create(event_info)
    default_values = { event_source: :theatre_in_chicago }
    Event.create(default_values.merge(event_info))
  end
end
