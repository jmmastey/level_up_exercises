json.array!(@artists) do |artist|
  json.extract! artist, :id, :slug
  json.url artist_url(artist, format: :json)
end
