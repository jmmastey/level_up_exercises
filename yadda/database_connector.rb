require 'pg'
require 'securerandom'
require 'faker'

# Connect to database
db_connection = PG.connect(dbname: 'yadda')

# Helper Methods

user_id_array = (1..200000).to_a
beer_id_array = (1..50).to_a
rating_array = (1..5).to_a
style_id_array = (1..7).to_a

def beer_id(id_array)
  id_array.sample
end

def rating(id_array)
  id_array.sample
end

def user_id(id_array)
  id_array.sample
end

def style_id(id_array)
  id_array.sample
end

# Create User Records

200000.times do
  db_connection.exec_params("INSERT INTO users (username, password, first_name, last_name, \
                            address, city, state, zip_code, email, created_by) \
                            VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10);", [SecureRandom.base64(25), \
                            'password', Faker::Name.first_name, \
                            Faker::Name.last_name, Faker::Address.street_address, Faker::Address.city, \
                            Faker::Address.state_abbr, Faker::Address.zip_code, \
                            Faker::Internet.email, user_id(user_id_array)])
end

# Create Brewery Records

breweries = ["Goose Island", "Great Lakes", "Sierra Nevada", "Stone Brewery", "Revolution Brewing"]

breweries.each do |brewery|
  db_connection.exec_params("INSERT INTO breweries (name, address, city, state, zip_code, description, \
    founding_year, created_by, updated_by) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9);", [brewery, \
    Faker::Address.street_address, Faker::Address.city, Faker::Address.state_abbr, \
    Faker::Address.zip_code, 'A beer company', '1980', user_id(user_id_array), user_id(user_id_array)])
end

# Create Beer Styles Lookup Table

beer_styles = ['Pale Ale', 'India Pale Ale', 'Lager', 'Pilsner', 'American Ale', 'Drought', 'Hefeweizen']

beer_styles.each do |style|
  db_connection.exec_params("INSERT INTO beer_styles_lookup (name) VALUES ($1);", [style])
end

# Create Beer Records

breweries = { 1 => "Goose Island", 2 => "Great Lakes", 3 => "Sierra Nevada", 4 => "Stone Brewery", 5 => "Revolution Brewing" }
beers = ["Beer A", "Beer B", "Beer C", "Beer D", "Beer E", "Beer F", "Beer G", "Beer H", "Beer I", "Beer J"]

breweries.each do |brewery_id, brewery| # 5 breweries
  beers.each do |beer| # 10 beers per brewery
    db_connection.exec_params("INSERT INTO beers (name, style_id, description, brewing_year, created_by, updated_by, brewery_id) \
      VALUES ($1, $2, $3, $4, $5, $6, $7);", ["#{brewery}-#{beer}", style_id(style_id_array), 'A great beer', '1988', \
      user_id(user_id_array), user_id(user_id_array), brewery_id])
  end
end

# Create Ratings Records

1000000.times do
  db_connection.exec_params("INSERT INTO ratings (look, smell, taste, feel, user_id, beer_id) VALUES ($1, $2, $3, $4, $5, $6);", \
    [rating(rating_array), rating(rating_array), rating(rating_array), rating(rating_array), user_id(user_id_array), beer_id(beer_id_array)])
end
