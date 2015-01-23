json.array!(@events) do |event|
  json.extract! event, :id, :id, :placename, :cityname, :activity_start_date, :activity_end_date, :sales_status, :registration_url_adr
  json.url event_url(event, format: :json)
end
