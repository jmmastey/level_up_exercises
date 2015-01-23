# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require 'dm-sqlite-adapter'
require "sinatra/activerecord"
require 'sinatra/sprockets'
require_relative 'overlord_helpers'
enable :sessions

register Sinatra::Sprockets

set :database, adapter: "sqlite3", database: "detonation_device"
set :views, "#{File.dirname(__FILE__)}/views"

class Overlord < Sinatra::Application
  include OverlordHelpers
  configure :development do
    DataMapper::Logger.new($stdout, :debug)
  end
  get '/' do
    @bombs = Bomb.all
    @url_base = base_url
    haml :index
  end

  use Rack::Session::Cookie, key: 'rack.session',
                           domain: 'http://localhost:9292/',
                           path: '/',
                           expire_after: 2592000, # In seconds
                           secret: 'change_me'

  run! if app_file == $PROGRAM_NAME
end

require_relative 'models/init'
require_relative 'helpers/init'
require_relative 'routes/init'
