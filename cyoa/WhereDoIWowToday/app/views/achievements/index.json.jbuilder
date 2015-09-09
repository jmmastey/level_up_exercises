json.array!(@achievements) do |achievement|
  json.extract! achievement, :id, :blizzard_id, :title, :faction_id
  json.url achievement_url(achievement, format: :json)
end
