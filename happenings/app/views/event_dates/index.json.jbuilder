json.array!(@event_dates) do |event_date|
  json.extract! event_date, :id, :venue_id, :date_time, :event_id
  json.url event_date_url(event_date, format: :json)
end
