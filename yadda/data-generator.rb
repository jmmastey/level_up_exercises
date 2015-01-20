require 'pg'
require 'faker'

# Connect to the db
@conn = PG.connect(user: "rcowan",
                   password: "",
                   dbname: "yadda")

def main
  # generate_person_records 5
  # generate_brewery_records 1
  # beer
  #rating

  display_records "brewery"
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
      "VALUES('#{name}', '#{address}', '#{city}', '#{state}', '#{zip_code}', '#{description}', '#{founding_year}', NOW(), 1)" );
  end
end

def generate_person_records count=100
  count.times do
    name = Faker::Name.first_name
    email = Faker::Internet.email
    birthday = Faker::Date.between("1900-01-01", Date.today)
    description = Faker::Lorem.sentence(3)

    @conn.exec( "INSERT INTO person(name, email, description, birthday, modified_by) " \
      "VALUES('#{name}', '#{email}', '#{description}', '#{birthday}', 1)" );
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