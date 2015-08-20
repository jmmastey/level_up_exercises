require 'active_record'
require 'factory_girl'
require 'faker'
Dir['models/*.rb'].each { |f| require_relative f }
Dir['factories/*.rb'].each { |f| require_relative f }

module YaddaGenerator
  CONFIG = { adapter: 'postgresql', database: 'yadda' }

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
    beer_style_names = File.readlines('data/beer_styles.txt').map(&:chomp)
    beer_style_names.each { |name| FactoryGirl.create(:beer_style, name: name) }
  end

  def self.create_breweries
    100.times do |i|
      FactoryGirl.create(:brewery)
      puts "#{i}/100 breweries" if i % 10 == 0
    end
  end

  def self.create_users
    100_000.times do |i|
      FactoryGirl.create(:user)
      puts "#{i}/100,000 drinkers" if i % 10_000 == 0
    end
  end

  def self.create_ratings
    all_user_ids = User.pluck(:id)
    all_beer_ids = Beer.pluck(:id)
    200_000.times do |i|
      FactoryGirl.create(:rating, user_id: all_user_ids.sample,
                                  beer_id: all_beer_ids.sample)
      puts "#{i}/200,000 ratings" if i % 10_000 == 0
    end
  end
end

YaddaGenerator
  .tap(&:reload_schema)
  .tap(&:connect_to_database)
  .tap(&:create_data)
