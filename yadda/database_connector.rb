require 'pg'
require 'securerandom'

# Connect to database
db_connection = PG.connect(dbname: 'yadda')

# Create User Records

first_names = ["Amy", "Brian", "Chris", "David", "Emily", "Frank", "George", "Heather", "John", "Isabel", "Mike"]
last_names = ["Fernandez", "Perham", "Campbell", "Cardarealla", "Souza", "Michael", "Haddad", "Hansson", "Fried", "Kemper", "Matz"]

200000.times do
  db_connection.exec("INSERT INTO users (username, password, first_name, last_name, address, city, state, zip_code, email, created_by) VALUES ('#{SecureRandom.base64(25)}', 'password', '#{first_names.sample}', '#{last_names.sample}', '123 Main Street', 'Chicago', 'IL', '60614', 'name@enova.com','Paul');")
end

# Create Brewery Records

db_connection.exec("INSERT INTO breweries (name, address, city, state, zip_code, description, founding_year, created_by, updated_by) VALUES ('Goose Island', '123 Wacker Drive', 'Chicago', 'IL', '60614', 'Known for their 312', '1960', 1, 1);")
db_connection.exec("INSERT INTO breweries (name, address, city, state, zip_code, description, founding_year, created_by, updated_by) VALUES ('Great Lakes', '123 Lake Shore Drive', 'Cleveland', 'OH', '43214', 'Known for their Dortmunder Gold', '1980', 1, 1);")
db_connection.exec("INSERT INTO breweries (name, address, city, state, zip_code, description, founding_year, created_by, updated_by) VALUES ('Sierra Nevada', '123 Pacific Coast Highway', 'San Francisco', 'CA', '00983', 'Known for their Pale Ale', '1960', 1, 1);")
db_connection.exec("INSERT INTO breweries (name, address, city, state, zip_code, description, founding_year, created_by, updated_by) VALUES ('Stone Brewery', '123 Stone Way', 'Los Angeles', 'CA', '09745', 'Not sure what they are known for', '1960', 1, 1);")
db_connection.exec("INSERT INTO breweries (name, address, city, state, zip_code, description, founding_year, created_by, updated_by) VALUES ('Revolution Brewing', '123 Lasalle', 'Chicago', 'IL', '60614', 'Known for their IPA', '2005', 1, 1);")

# Create Beer Styles Lookup Table

db_connection.exec("INSERT INTO beer_styles_lookup (name) VALUES ('Pale Ale');")
db_connection.exec("INSERT INTO beer_styles_lookup (name) VALUES ('India Pale Ale');")
db_connection.exec("INSERT INTO beer_styles_lookup (name) VALUES ('Lager');")
db_connection.exec("INSERT INTO beer_styles_lookup (name) VALUES ('Pilsner');")
db_connection.exec("INSERT INTO beer_styles_lookup (name) VALUES ('American Ale');")
db_connection.exec("INSERT INTO beer_styles_lookup (name) VALUES ('Drought');")
db_connection.exec("INSERT INTO beer_styles_lookup (name) VALUES ('Hefeweizen');")

# Create Beer Records
breweries = { 1 => "Goose Island", 2 => "Great Lakes", 3 => "Sierra Nevada", 4 => "Stone Brewery", 5 => "Revolution Brewing" }
beers = ["Beer A", "Beer B", "Beer C", "Beer D", "Beer E", "Beer F", "Beer G", "Beer H", "Beer I", "Beer J"]

breweries.each do |id, brewery| # 5 breweries
  beers.each do |beer| # 10 beers per brewery
    user = 1 + rand(200000)
    style = 1 + rand(7)
    db_connection.exec("INSERT INTO beers (name, style_id, description, brewing_year, created_by, updated_by, brewery_id) VALUES ('#{brewery + '-' + beer}', #{style}, 'A great beer', '1988', #{user}, #{user}, #{id});")
  end
end

# Create Ratings Records

1000000.times do
  look_rating = (1 + rand(5)) * 1.0
  smell_rating = (1 + rand(5)) * 1.0
  taste_rating = (1 + rand(5)) * 1.0
  feel_rating = (1 + rand(5)) * 1.0
  user_id = 1 + rand(200000)
  beer_id = 1 + rand(50)
  db_connection.exec("INSERT INTO ratings (look, smell, taste, feel, user_id, beer_id) VALUES (#{look_rating}, #{smell_rating}, #{smell_rating}, #{feel_rating}, #{user_id}, #{beer_id});")
end
