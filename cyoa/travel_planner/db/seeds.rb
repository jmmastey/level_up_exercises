Location.where(name: "O'Hare").first_or_create(name:        "O'Hare",
  address1:    "10000 W O'Hare Ave",
  city:        "Chicago",
  state:       "IL",
  postal_code: "60666")

Location.where(name: "LaGuardia").first_or_create(name:        "LaGuardia",
  address1:    "LaGuardia Airport",
  city:        "New York",
  state:       "NY",
  postal_code: "11371")

puts "Total locations: #{Location.count}"

Airport.where(name: "O'Hare").first_or_create(name:     "O'Hare",
  code:     "ORD",
  location: Location.find_by_name("O'Hare"))

Airport.where(name: "LaGuardia").first_or_create(name:     "LaGuardia",
  code:     "LGA",
  location: Location.find_by_name("LaGuardia"))

puts "Total Airports: #{Airport.count}"
