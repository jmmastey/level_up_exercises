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

    return nil if event_exists?(convert_attribs(attribs))
    Event.create(attribs)
  end

  private

  def event_exists?(event_info)
    Event.where(event_info).present?
  end

  def convert_attribs(event_info)
    dup_event_info = event_info.dup

    %w[ time(1i) time(2i) time(3i) ].each { |t| dup_event_info.delete(t) }
    # TODO: validate the specific time as a criteria to event duplication
    # time = Time.new(2000, 01, 01, dup_event_info.delete("time(4i)"), dup_event_info.delete("time(5i)"))
    # dup_event_info[:time] = time

    convert_date(dup_event_info)
    event_source_id = EventSource[dup_event_info.delete(:event_source)].id
    dup_event_info[:event_source_id] = event_source_id
    dup_event_info
  end

  def convert_date(event_info)
    unless event_info[:date]
      date = Date.new(event_info.delete("date(1i)").to_i,
                      event_info.delete("date(2i)").to_i,
                      event_info.delete("date(3i)").to_i)
      event_info[:date] = date
    end
  end
end
