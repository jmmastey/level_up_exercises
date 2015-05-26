require 'pg'
require 'faker'

@conn = PG.connect(user: "rcowan",
                   password: "",
                   dbname: "yadda")

def main
  generate_person_records 200000
  generate_brewery_records 1000
  generate_style_records 25
  generate_beer_records 10000
  generate_rating_records 1000000
end

def generate_rating_records(count=1000)
  count.times do
    insert_record "ratings", {
      person_id: (get_record_id "persons", "person_id"),
      beer_id: (get_record_id "beers", "beer_id"),
      look: Faker::Number.digit,
      smell: Faker::Number.digit,
      taste: Faker::Number.digit,
      feel: Faker::Number.digit,
      overall: Faker::Number.digit,
      description: Faker::Lorem.sentence(3),
      created_at: Faker::Date.between("2014-01-01", Date.today),
      updated_by: (get_record_id "persons", "person_id")
    }
  end
end

def generate_style_records(count=10)
  count.times do
    insert_record "styles", {
      style: Faker::Hacker.noun,
      created_at: Faker::Date.between("2014-01-01", Date.today),
      created_by: (get_record_id "persons", "person_id"),
      updated_at: Faker::Date.between("2014-01-01", Date.today),
      updated_by: (get_record_id "persons", "person_id")
    }
  end
end

def generate_beer_records(count=100)
  count.times do
    insert_record "beers", {
      brewery_id: (get_record_id "breweries", "brewery_id"),
      name: Faker::Company.name.gsub("'"){""},
      style_id: (get_record_id "styles", "style_id"),
      description: Faker::Lorem.sentence(3),
      brewing_year: Faker::Date.between("2000-01-01", Date.today).year,
      created_at: Faker::Date.between("2014-01-01", Date.today),
      updated_by: (get_record_id "persons", "person_id")
    }
  end
end

def generate_brewery_records(count=20)
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
      updated_by: (get_record_id "persons", "person_id")
    }
  end
end

def generate_person_records(count=100)
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

def get_record_id(table, primary_key)
  record = @conn.exec("SELECT #{primary_key} FROM #{table} ORDER BY RANDOM() LIMIT 1").first
  record["#{primary_key}"]
end

def insert_record(table, info_hash)
  placeholder = []
  info_hash.keys.each_index {|x| placeholder << "$#{x+1}"}

  @conn.exec_params("INSERT INTO #{table} (#{info_hash.keys.join(",")}) VALUES(#{placeholder.join(",")})",
    info_hash.values)
end

main
