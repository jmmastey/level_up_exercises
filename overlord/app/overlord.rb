# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require 'dm-sqlite-adapter'
require "sinatra/activerecord"
require 'sinatra/sprockets'

enable :sessions

register Sinatra::Sprockets

set :database, adapter: "sqlite3", database: "detonation_device"
set :views, "#{File.dirname(__FILE__)}/views"

class Overlord < Sinatra::Application
  class_attribute :error_message
  configure :development do
    DataMapper::Logger.new($stdout, :debug)
  end

  def start_time
    session[:start_time] ||= (Time.now).to_s
  end
  set :error_message, ''
  get '/' do
    @bombs = Bomb.all
    session[:url] = "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
    haml :index
  end

  run! if app_file == $PROGRAM_NAME
end

require_relative 'models/init'
require_relative 'helpers/init'
require_relative 'routes/init'
