# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

artist_list = [
  "Alison Krauss",
  "Bassnectar",
  "Beyonce",
  "Big L",
  "Disclosure",
  "Jay Z",
  "Justice",
  "Kanye West",
  "Katy Perry",
  "Kesha",
  "Kiss",
  "Lady Gaga",
  "Lorde",
  "Madonna",
  "Metallica",
  "Paul Simon",
  "Phish",
  "Prince",
  "Sound Tribe Sector 9",
  "STS9",
  "SBTRKT",
  "Taylor Swift",
  "The Grateful Dead",
  "The Rolling Stones",
  "The Shins",
  "Umphrey's McGee"
]

artist_list.each do |name|
  Artist.find_or_create_by_unique_name(name)
end

