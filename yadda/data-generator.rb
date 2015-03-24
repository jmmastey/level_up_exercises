require 'pg'
require 'faker'

@conn = PG.connect(user: "rcowan",
                   password: "",
                   dbname: "yadda")

def main
  generate_person_records 2000
  generate_brewery_records 1000
  generate_beer_records 10000
  generate_rating_records 1000000
end

def generate_rating_records count=100
  count.times do
    insert_record "ratings", {
      person_id: (get_record_id "persons"),
      beer_id: (get_record_id "beers"),
      look: Faker::Number.digit,
      smell: Faker::Number.digit,
      taste: Faker::Number.digit,
      feel: Faker::Number.digit,
      overall: Faker::Number.digit,
      description: Faker::Lorem.sentence(3),
      created_at: Faker::Date.between("2014-01-01", Date.today),
      updated_by: (get_record_id "persons")
    }
  end
end

def generate_beer_records count=100
  count.times do
    insert_record "beers", {
      brewery_id: (get_record_id "breweries"),
      name: Faker::Company.name.gsub("'"){""},
      style: Faker::Hacker.noun,
      description: Faker::Lorem.sentence(3),
      brewing_year: Faker::Date.between("2000-01-01", Date.today).year,
      created_at: Faker::Date.between("2014-01-01", Date.today),
      updated_by: (get_record_id "persons")
    }
  end
end

def generate_brewery_records count=100
  count.times do
    insert_record "breweries", {
      name: Faker::Company.name.gsub("'"){""},
      address: Faker::Address.street_address.gsub("'"){""},
      city: Faker::Address.city.gsub("'"){""},
      state: Faker::Address.state_abbr,
      postal_code: Faker::Number.number(5),
      description: Faker::Lorem.sentence(3),
      founding_year: Faker::Date.between("1500-01-01", Date.today).year,
      created_at: Faker::Date.between("2014-01-01", Date.today),
      updated_by: (get_record_id "persons")
    }
  end
end

def generate_person_records count=100
  count.times do
    insert_record "persons", {
      name: Faker::Name.first_name.gsub("'"){""},
      email: Faker::Internet.email,
      birthday: Faker::Date.between("1900-01-01", Date.today),
      description: Faker::Lorem.sentence(3),
      created_at: Faker::Date.between("2014-01-01", Date.today),
      updated_by: 1
    }
  end
end

#refactor, move focus off DB
def get_record_id table
  record = @conn.exec( "SELECT #{table}_id FROM #{table} ORDER BY RANDOM() LIMIT 1" ).first
  record["#{table}_id"]
end

def insert_record table, info_hash
  placeholder = []
  info_hash.keys.each_index {|x| placeholder << "$#{x+1}"}

  @conn.exec_params("INSERT INTO #{table} (#{info_hash.keys.join(",")}) VALUES(#{placeholder.join(",")})",
    info_hash.values)
end

main
