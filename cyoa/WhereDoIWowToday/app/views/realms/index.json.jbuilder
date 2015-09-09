json.array!(@realms) do |realm|
  json.extract! realm, :id, :name
  json.url realm_url(realm, format: :json)
end
