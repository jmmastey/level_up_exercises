json.array!(@users) do |user|
  json.extract! user, :id, :name, :username, :password, :profile_img_url
  json.url user_url(user, format: :json)
end
