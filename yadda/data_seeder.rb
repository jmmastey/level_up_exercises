require "sequel"
require_relative "data_generator"

class DataSeeder
  def initialize(database, host = "localhost",
    total_users = 100, total_ratings = 1000,
    total_breweries = nil, total_beers = nil)
    @connection_string = "postgres://#{host}/#{database}"
    @total_users = total_users.to_i
    @total_ratings = total_ratings.to_i
    @total_beers = (total_beers || @total_ratings / 10).to_i
    @total_breweries = (total_breweries || @total_beers / 10).to_i
    @user_ids = []
    @breweries = []
    @beer_styles = []
    @beer_ids = []
  end

  def seed
    conn.transaction do
      add_users
      add_breweries
      add_beer_styles
      add_beers
      add_ratings
    end
  end

  def add_users
    print "Adding #{@total_users} users"
    @total_users.times do |n|
      add_user
      print "." if ten_percent?(@total_users, n + 1)
    end
    puts
  end

  def add_user
    first_name = DataGenerator.first_name
    last_name = DataGenerator.last_name
    created_on = DateTime.now
    @user_ids << conn[:users].insert(
      created_on: created_on,
      updated_on: created_on,
      name: "#{first_name} #{last_name}",
      email: "#{first_name.downcase}.#{last_name.downcase}@gmail.com",
      password_hash: "abcdefghijklmnopqrstuvwxyz"
    )
  end

  def add_breweries
    print "Adding #{@total_breweries} breweries"
    @total_breweries.times do |n|
      add_brewery
      print "." if ten_percent?(@total_breweries, n + 1)
    end
    puts
  end

  def add_brewery
    name = "#{DataGenerator.last_name} Brewing"
    created_on = DateTime.now
    created_by = @user_ids.sample
    id = conn[:breweries].insert(
      created_on: created_on,
      created_by: created_by,
      updated_on: created_on,
      updated_by: created_by,
      name: name
    )
    @breweries << { name: name, id: id }
  end

  def add_beer_styles
    puts "Adding beer styles"
    DataGenerator.beer_styles.each do |style|
      created_on = DateTime.now
      created_by = @user_ids.sample
      id = conn[:beer_styles].insert(
        created_on: created_on,
        created_by: created_by,
        updated_on: created_on,
        updated_by: created_by,
        name: style
      )
      @beer_styles << { name: style, id: id }
    end
  end

  def add_beers
    print "Adding #{@total_beers} beers"
    @total_beers.times do |n|
      add_beer
      print "." if ten_percent?(@total_beers, n + 1)
    end
    puts
  end

  def add_beer
    brewery = @breweries.sample
    style = @beer_styles.sample
    name = "#{brewery[:name]} #{style[:name]}"
    created_on = DateTime.now
    created_by = @user_ids.sample
    @beer_ids << conn[:beers].insert(
      brewery_id: brewery[:id],
      beer_style_id: style[:id],
      created_on: created_on,
      created_by: created_by,
      updated_on: created_on,
      updated_by: created_by,
      name: name
    )
  end

  def add_ratings
    print "Adding #{@total_ratings} ratings"
    @total_ratings.times do |n|
      add_rating
      print "." if ten_percent?(@total_ratings, n + 1)
    end
    puts
  end

  def add_rating
    created_on = DateTime.now
    conn[:ratings].insert(
      user_id: @user_ids.sample,
      beer_id: @beer_ids.sample,
      created_on: created_on,
      updated_on: created_on,
      appearance: DataGenerator.beer_rating,
      aroma: DataGenerator.beer_rating,
      taste: DataGenerator.beer_rating,
      texture: DataGenerator.beer_rating,
      overall: DataGenerator.beer_rating
    )
  end

  private

  def conn
    @conn ||= Sequel.connect(@connection_string)
  end

  def ten_percent?(total, n)
    n % (total / 10) == 0
  end
end

if __FILE__ == $PROGRAM_NAME
  seeder = DataSeeder.new(*ARGV)
  seeder.seed
end
