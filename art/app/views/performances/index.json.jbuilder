json.array!(@performances) do |performance|
  json.extract! performance, :id, :show_id, :performed_on
  json.url performance_url(performance, format: :json)
end
