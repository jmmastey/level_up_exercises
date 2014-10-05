json.array!(@events) do |event|
  json.extract! event, :id, :name, :venue_id, :description, :price, :show_type, :phone_number, :running_time, :event_url
  json.url event_url(event, format: :json)
end
