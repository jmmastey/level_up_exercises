require 'pg'
require 'faker'

# Connect to the db
@conn = PG.connect(user: "rcowan",
                   password: "",
                   dbname: "yadda")

def main
  generate_person_records 2
  generate_brewery_records 1
  generate_beer_records 10
  generate_rating_records 1000

  display_records "person"
  display_records "brewery"
  display_records "beer"
  display_records "rating"
end

def generate_rating_records count=100
  count.times do
    insert_record "rating", {
      person_id: (get_record_id "person"),
      beer_id: (get_record_id "beer"),
      look: Faker::Number.digit,
      smell: Faker::Number.digit,
      taste: Faker::Number.digit,
      feel: Faker::Number.digit,
      overall: Faker::Number.digit,
      description: Faker::Lorem.sentence(3),
      updated_by: (get_record_id "person")
    }
  end
end

def generate_beer_records count=100
  count.times do
    insert_record "beer", {
      brewery_id: (get_record_id "brewery"),
      name: Faker::Company.name.gsub("'"){""},
      style: Faker::Hacker.noun,
      description: Faker::Lorem.sentence(3),
      brewing_year: Faker::Date.between("2000-01-01", Date.today).year,
      updated_by: (get_record_id "person")
    }
  end
end

def generate_brewery_records count=100
  count.times do
    insert_record "brewery", {
      name: Faker::Company.name.gsub("'"){""},
      address: Faker::Address.street_address.gsub("'"){""},
      city: Faker::Address.city.gsub("'"){""},
      state: Faker::Address.state_abbr,
      postal_code: Faker::Number.number(5),
      description: Faker::Lorem.sentence(3),
      founding_year: Faker::Date.between("1500-01-01", Date.today).year,
      updated_by: (get_record_id "person")
    }
  end
end

def generate_person_records count=100
  count.times do
    insert_record "person", {
      name: Faker::Name.first_name.gsub("'"){""},
      email: Faker::Internet.email,
      birthday: Faker::Date.between("1900-01-01", Date.today),
      description: Faker::Lorem.sentence(3),
      updated_by: 1
    }
  end
end

def get_record_id table
  record = @conn.exec( "SELECT #{table}_id FROM #{table} ORDER BY RANDOM() LIMIT 1" ).first
  record["#{table}_id"]
end

def insert_record table, info_hash
  @conn.exec( "INSERT INTO #{table} (#{info_hash.keys.join(",")})" \
    "VALUES('#{info_hash.values.join("','")}')" )
end

def display_records table
  @conn.exec( "SELECT * FROM #{table}" ) do |result|
    result.each do |row|
      puts row
    end
  end
end

main
