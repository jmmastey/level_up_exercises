json.extract! @review, :id, :user_id, :performance_id, :rating, :review, :created_at, :updated_at, :sentiment
json.show @review.performance.show, :name, :description
