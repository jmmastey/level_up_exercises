require 'ostruct'
require 'sinatra' unless defined?(Sinatra)
require 'data_mapper'
require 'sinatra/param'
require 'sinatra/flash'

configure do
  #Site Configuration
  SiteConfig = OpenStruct.new(
                 :title => "Overlord - Valentine's Day Bomb",
                 :author => "Kareem Gan",
                 :url_base => 'http://localhost:9393/'
               )

  # load required files
  Dir["./mediators/init.rb"].sort.each { |f| require f }

  DataMapper.setup(:default, (ENV["DATABASE_URL"] || "sqlite3:///#{File.expand_path(File.dirname(__FILE__))}/#{Sinatra::Base.environment}.db"))
end
