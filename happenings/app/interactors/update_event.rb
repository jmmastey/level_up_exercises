module UpdateEvent
  def self.update(event, event_info)
    return nil unless event
    event_info.delete(:id)
    event.update(event_info)
  end
end
