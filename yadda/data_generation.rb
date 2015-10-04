require 'faker'
require 'colorize'
require_relative 'database'

# Constants used to slice strings in order to ensure they fit in the db.
# Would it be better to define everything like this, or to just include numbers?
MAX_MODIFIED = 50
MAX_CREATED = 50

MAX_USER_NAME = 50
MAX_USER_EMAIL = 100
MAX_USER_PASSWORD = 50

MAX_BREWERY_NAME = 100
MAX_BREWERY_STREET = 100
MAX_BREWERY_CITY = 200
MAX_BREWERY_COUNTRY = 50
MAX_BREWERY_ZIP = 10

MAX_STYLE_NAME = 50

MAX_BEER_NAME = 100

# Constants for how much data to generate
THREAD_MULTIPLIER = 10

USER_COUNT = 10_000
BREWERIES_COUNT = 1_000
STYLES_COUNT = 4_000
BEERS_COUNT = 7_000
RATINGS_COUNT = 10_000

def insert_fake_user
  @database.insert(
    'users',
    name: Faker::Name.name[0, MAX_USER_NAME],
    email: Faker::Internet.email[0, MAX_USER_EMAIL],
    birthday: Faker::Time.between(DateTime.now - 30, DateTime.now),
    password: Faker::Internet.password(8, 49)[0, MAX_USER_PASSWORD],
    modified_by: Faker::Internet.user_name[0, MAX_MODIFIED],
  )
end

def insert_fake_brewery
  @database.insert(
    'breweries',
    name: Faker::Company.name[0, MAX_BREWERY_NAME],
    street_address: Faker::Address.street_address[0, MAX_BREWERY_STREET],
    city: Faker::Address.city[0, MAX_BREWERY_CITY],
    country: Faker::Address.country[0, MAX_BREWERY_COUNTRY],
    zip_code: Faker::Address.zip_code[0, MAX_BREWERY_ZIP],
    description: Faker::Lorem.sentence,
    founding_year: rand(1900..2015),
    modified_by: Faker::Internet.user_name[0, MAX_MODIFIED],
    created_by: Faker::Internet.user_name[0, MAX_CREATED],
  )
end

def insert_fake_style
  @database.insert(
    'styles',
    name: Faker::Lorem.word[0, MAX_STYLE_NAME],
  )
end

# Ensure that we have styles and breweries inserted before calling
def insert_fake_beer
  @database.insert(
    'beers',
    name: Faker::Company.name[0, MAX_BEER_NAME],
    style_id: @database.random_id('styles'),
    description: Faker::Lorem.sentence,
    brew_year: rand(1900..2015),
    brewery_id: @database.random_id('breweries'),
    modified_by: Faker::Internet.user_name[0, MAX_MODIFIED],
    created_by: Faker::Internet.user_name[0, MAX_CREATED],
  )
end

# Ensure we have beers and users! (which means styles and breweries too!)
def insert_fake_rating
  @database.insert(
    'ratings',
    user_id: @database.random_id('users'),
    beer_id: @database.random_id('beers'),
    look: rand(1..10),
    smell: rand(1..10),
    taste: rand(1..10),
    overall: rand(1..10),
    modified_by: Faker::Internet.user_name[0, MAX_MODIFIED],
    created_by: Faker::Internet.user_name[0, MAX_CREATED],
  )
end

def percent(count, multiplier)
  ((count * 100) / (count * multiplier)).to_i
end

def table_to_s(name)
  return 'breweries' if name == 'brewery'
  name + 's'
end

def fake(table, count, multiplier)
  puts "Started faking #{count * multiplier} #{table_to_s(table)}".yellow
  multiplier.times do
    @threads << Thread.new do
      count.times { send("insert_fake_#{table}") }
      puts "Generated #{percent(count, multiplier)}% of the ".green +
        table_to_s(table).green
    end
  end
end

def fake_it
  @threads = []
  fake('user', USER_COUNT, THREAD_MULTIPLIER)
  fake('brewery', BREWERIES_COUNT, THREAD_MULTIPLIER)
  fake('style', STYLES_COUNT, THREAD_MULTIPLIER)
  fake('beer', BEERS_COUNT, THREAD_MULTIPLIER)
  fake('rating', RATINGS_COUNT, THREAD_MULTIPLIER)
  @threads.each(&:join)
end

@database = Database.new('yadda', THREAD_MULTIPLIER)
fake_it
