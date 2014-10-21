json.array!(@event_dates) do |event_date|
  json.extract! event_date, :id
  json.title event_date.event.name
  json.description event_date.event.description
  json.start event_date.date_time
  json.end event_date.date_time + 2.hours
  json.url event_url(event_date.event_id, format: :html)

  #
  # json.url event_date_url(event_date, format: :json)
end