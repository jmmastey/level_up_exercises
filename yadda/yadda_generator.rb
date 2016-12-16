require 'faker'
require 'pg'

module YaddaGenerator
  CONFIG = { adapter: 'postgresql', database: 'yadda' }
  BREWERY_COUNT = 100_000
  ADDRESS_COUNT = 50_000
  BEER_COUNT = 1_000_000
  USER_COUNT = 200_000
  RATING_COUNT = 100_000

  def self.connect
    @conn = PG.connect(dbname: 'yadda')
  end

  def self.reload_schema
    `psql -f sql/schema.sql`
  end

  def self.create_data
    create_beer_styles
    create_addresses
    create_breweries
    create_beers
    create_users
    create_ratings
  end

  def self.create_beer_styles
    @conn.prepare("insert_beer_style", "INSERT INTO beer_styles (id, name, created_by) values ($1, $2, $3)")
    File.foreach('data/beer_styles.txt').with_index do |beer_style, index|
      @conn.exec_prepared("insert_beer_style", [index, beer_style.chomp, 'script'])
    end
  end

  def self.create_addresses
    @conn.prepare("insert_address", "INSERT INTO addresses (id, address_line_1, address_line_2, city, state, zipcode, country, created_by) values ($1, $2, $3, $4, $5, $6, $7, $8)")
    ADDRESS_COUNT.times do |i|
      address_line_1 = Faker::Address.street_address
      address_line_2 = Faker::Address.secondary_address
      city = Faker::Address.city
      state = Faker::Address.state_abbr
      zipcode = Faker::Address.zip_code[0..4]
      country = 'US'
      @conn.exec_prepared("insert_address", [i, address_line_1, address_line_2, city, state, zipcode, country, 'script'])
    end
  end

  def self.create_breweries
    @conn.prepare("insert_brewery", "INSERT INTO breweries (id, name, description, founding_year, address_id, created_by) values ($1, $2, $3, $4, $5, $6)")
    BREWERY_COUNT.times do |i|
      name = Faker::Name.first_name << ' Brewery'
      description = Faker::Lorem.paragraph
      date = Faker::Date.between(Date.today - 2 * 365, Date.today).year
      @conn.exec_prepared("insert_brewery", [i, name, description, date, rand(1..ADDRESS_COUNT-1), 'script'])
    end
  end

  def self.create_beers
    @conn.prepare("insert_beer", "INSERT INTO beers (id, name, description, brewing_year, beer_style_id, brewery_id, created_by) values ($1, $2, $3, $4, $5, $6, $7)")
    num_beer_styles = File.readlines('data/beer_styles.txt').count
    BEER_COUNT.times do |i|
      name = "#{Faker::Lorem.word}"
      description = Faker::Lorem.paragraph
      date = Faker::Date.between(Date.today - 2 * 365, Date.today).year
      @conn.exec_prepared("insert_beer", [i, name, description, date, rand(1..num_beer_styles-1), rand(1..BREWERY_COUNT-1), 'script'])
    end
  end

  def self.create_users
    @conn.prepare("insert_user", "INSERT INTO users (id, fname, lname, username, age, weight_in_lbs, height_in_inches, email, address_id, created_by) values ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)")
    USER_COUNT.times do |i|
      fname = Faker::Name.first_name
      lname = Faker::Name.last_name
      username = Faker::Internet.user_name
      age = Faker::Number.between(21, 125)
      weight_in_lbs = Faker::Number.between(10, 500)
      height_in_inches = Faker::Number.between(36, 100)
      email = Faker::Internet.email

      @conn.exec_prepared("insert_user", [i, fname, lname, username, age, weight_in_lbs, height_in_inches, email, rand(1..ADDRESS_COUNT-1), 'script'])
    end
  end

  def self.create_ratings
    @conn.prepare("insert_rating", "INSERT INTO ratings (id, look, smell, feel, taste, overall, notes, created_on, created_by, beer_id, user_id) values ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)")
    look = (rand * 5).round(2)
    smell = (rand * 5).round(2)
    feel = (rand * 5).round(2)
    taste = (rand * 5).round(2)
    overall = [look, smell, feel, taste].inject(:+).to_f / 4
    notes = Faker::Lorem.sentences(4).join(' ')
    created_on = Faker::Date.between(Date.today - 2*265, Date.today)

    RATING_COUNT.times do |i|
      @conn.exec_prepared("insert_rating", [i, look, smell, feel, taste, overall, notes, created_on, 'script', rand(1..BEER_COUNT-1), rand(1..USER_COUNT-1)])
    end
  end
end

YaddaGenerator
  .tap(&:reload_schema)
  .tap(&:connect)
  .tap(&:create_data)
