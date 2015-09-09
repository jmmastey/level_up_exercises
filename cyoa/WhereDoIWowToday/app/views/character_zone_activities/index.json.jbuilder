json.array!(@character_zone_activities) do |character_zone_activity|
  json.extract! character_zone_activity, :id
  json.url character_zone_activity_url(character_zone_activity, format: :json)
end
