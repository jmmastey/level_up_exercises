json.array!(@reviews) do |review|
  json.extract! review, :id, :user_id, :performance_id, :rating, :review
  json.url review_url(review, format: :json)
end
