require 'active_record'
require 'factory_girl'
require 'faker'
require_relative 'factories'
require_relative 'models'

module YaddaGenerator
  CONFIG = { adapter: 'postgresql', database: 'yadda' }
  BREWERY_COUNT = 100
  USER_COUNT = 1_000
  RATING_COUNT = 100_000

  def self.reload_schema
    `psql -f sql/schema.sql`
  end

  def self.connect_to_database
    ActiveRecord::Base.establish_connection(CONFIG)
  end

  def self.create_data
    create_beer_styles
    create_breweries
    create_users
    create_ratings
  end

  def self.create_beer_styles
    File.foreach('data/beer_styles.txt') do |beer_style|
      FactoryGirl.create(:beer_style, name: beer_style.chomp)
    end
  end

  def self.create_breweries
    FactoryGirl.create_list(:brewery, BREWERY_COUNT)
  end

  def self.create_users
    FactoryGirl.create_list(:user, USER_COUNT)
  end

  def self.create_ratings
    FactoryGirl.create_list(:rating, RATING_COUNT)
  end
end

YaddaGenerator
  .tap(&:reload_schema)
  .tap(&:connect_to_database)
  .tap(&:create_data)
