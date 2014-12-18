json.array!(@event_sources) do |event_source|
  json.extract! event_source, :id, :name, :source_type, :uri, :frequency, :last_harvest
  json.url event_source_url(event_source, format: :json)
end
