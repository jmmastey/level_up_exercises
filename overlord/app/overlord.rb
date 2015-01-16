# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require 'dm-sqlite-adapter'
require "sinatra/activerecord"
require 'sinatra/sprockets'
require_relative 'overlord_helpers'
enable :sessions

register Sinatra::Sprockets

class Hash
  def self.to_ostructs(obj, memo={})
    return obj unless obj.is_a? Hash
    os = memo[obj] = OpenStruct.new
    obj.each { |k,v| os.send("#{k}=", memo[v] || to_ostructs(v, memo)) }
    os
  end
end

set :database, {adapter: "sqlite3", database: "detonation_device"}
set :views, "#{File.dirname(__FILE__)}/views"

class Overlord < Sinatra::Application
  include OverlordHelpers
  configure :development do
    DataMapper::Logger.new($stdout, :debug)
  end
  get '/' do
    Bomb.destroy_all
    haml :index
  end

  run! if app_file == $PROGRAM_NAME
end


require_relative 'models/init'
require_relative 'helpers/init'
require_relative 'routes/init'

