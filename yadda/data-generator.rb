require 'pg'
require 'faker'

# Connect to the db
@conn = PG.connect(user: "rcowan",
                   password: "",
                   dbname: "yadda")

def main
  generate_person_records 1
  generate_brewery_records 5
  generate_beer_records 5
  generate_rating_records 3

  display_records "person"
  display_records "brewery"
  display_records "beer"
  display_records "rating"
end

def generate_rating_records count=100
  count.times do
    insert_record "rating", {
      person_id: 1,
      beer_id: 1,
      look: "'#{Faker::Number.digit}'",
      smell: "'#{Faker::Number.digit}'",
      taste: "'#{Faker::Number.digit}'",
      feel: "'#{Faker::Number.digit}'",
      overall: "'#{Faker::Number.digit}'",
      description: "'#{Faker::Lorem.sentence(3)}'",
    }
  end
end

def generate_beer_records count=100
  count.times do
    insert_record "beer", {
      brewery_id: 1,
      style: "'#{Faker::Hacker.noun}'",
      description: "'#{Faker::Lorem.sentence(3)}'",
      brewing_year: "'#{Faker::Date.between("2000-01-01", Date.today).year}'",
      updated_on: "NOW()",
      updated_by: 1
    }
  end
end

def generate_brewery_records count=100
  count.times do
    insert_record "brewery", {
      name: "'#{Faker::Company.name}'",
      address: "'#{Faker::Address.street_address}'",
      city: "'#{Faker::Address.city}'",
      state: "'#{Faker::Address.state_abbr}'",
      zip_code: "'#{Faker::Number.number(5)}'",
      description: "'#{Faker::Lorem.sentence(3)}'",
      founding_year: "'#{Faker::Date.between("1500-01-01", Date.today).year}'",
      updated_on: "NOW()",
      updated_by: 1
    }
  end
end

def generate_person_records count=100
  count.times do
    insert_record "person", {
      name: "'#{Faker::Name.first_name}'",
      email: "'#{Faker::Internet.email}'",
      birthday: "'#{Faker::Date.between("1900-01-01", Date.today)}'",
      description: "'#{Faker::Lorem.sentence(3)}'",
      updated_by: 1
    }
  end
end

def insert_record table, info_hash
  @conn.exec( "INSERT INTO #{table} (#{info_hash.keys.join(",")})" \
    "VALUES(#{info_hash.values.join(",")})" )
end

def display_records table="person"
  @conn.exec( "SELECT * FROM #{table}" ) do |result|
    result.each do |row|
      puts row
    end
  end
end

main