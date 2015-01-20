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
    look = Faker::Number.digit
    smell = Faker::Number.digit
    taste = Faker::Number.digit
    feel = Faker::Number.digit
    overall = Faker::Number.digit
    description = Faker::Lorem.sentence(3)

    @conn.exec( "INSERT INTO rating (person_id, beer_id, look, smell, taste, feel, overall, description, modified_by)" \
      "VALUES(1, 1, #{look}, #{smell}, #{taste}, #{feel}, #{overall}, '#{description}', 1)" )
  end
end

def generate_beer_records count=100
  count.times do
    style = Faker::Hacker.noun
    description = Faker::Lorem.sentence(3)
    brewing_year = Faker::Date.between("2000-01-01", Date.today).year

    @conn.exec( "INSERT INTO beer (brewery_id, style, description, brewing_year, modified_on, modified_by)" \
      "VALUES(1, '#{style}', '#{description}', '#{brewing_year}', NOW(), 1)" )
  end
end

def generate_brewery_records count=100
  count.times do
    name = Faker::Company.name
    address = Faker::Address.street_address
    city = Faker::Address.city
    state = Faker::Address.state_abbr
    zip_code = Faker::Number.number(5)
    description = Faker::Lorem.sentence(3)
    founding_year = Faker::Date.between("1500-01-01", Date.today).year

    @conn.exec( "INSERT INTO brewery(name, address, city, state, zip_code, description, founding_year, modified_on, modified_by) " \
      "VALUES('#{name}', '#{address}', '#{city}', '#{state}', '#{zip_code}', '#{description}', '#{founding_year}', NOW(), 1)" )
  end
end

def generate_person_records count=100
  count.times do
    name = Faker::Name.first_name
    email = Faker::Internet.email
    birthday = Faker::Date.between("1900-01-01", Date.today)
    description = Faker::Lorem.sentence(3)

    @conn.exec( "INSERT INTO person(name, email, description, birthday, modified_by) " \
      "VALUES('#{name}', '#{email}', '#{description}', '#{birthday}', 1)" )
  end
end

def display_records table="person"
  @conn.exec( "SELECT * FROM #{table}" ) do |result|
    result.each do |row|
      puts row
    end
  end
end

main