json.array!(@feeds) do |feed|
  json.extract! feed, :id, :owner_user_id, :title, :description, :public
  json.url feed_url(feed, format: :json)
end
