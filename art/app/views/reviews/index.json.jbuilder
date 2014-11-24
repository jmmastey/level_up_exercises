json.array!(@reviews) do |review|
  json.extract! review, :id, :performance_id, :rating, :review, :created_at, :sentiment
  json.url review_url(review, format: :json)
  json.author do
    json.name review.user.name
    json.username review.user.username
  end
end
