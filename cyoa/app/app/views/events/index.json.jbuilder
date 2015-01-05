json.array!(@events) do |event|
  json.extract! event, :id, :avg_price, :low_price, :high_price, :title
  json.url event_url(event, format: :json)
end
