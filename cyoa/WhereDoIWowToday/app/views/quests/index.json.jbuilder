json.array!(@quests) do |quest|
  json.extract! quest, :id, :blizzard_id, :title, :category, :req_level, :level
  json.url quest_url(quest, format: :json)
end
