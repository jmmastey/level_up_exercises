# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require 'dm-sqlite-adapter'
enable :sessions

class Hash
  def self.to_ostructs(obj, memo={})
    return obj unless obj.is_a? Hash
    os = memo[obj] = OpenStruct.new
    obj.each { |k,v| os.send("#{k}=", memo[v] || to_ostructs(v, memo)) }
    os
  end
end

class Overlord < Sinatra::Application
 configure :development do
    DataMapper::Logger.new($stdout, :debug)
    DataMapper.setup(
        :default,
        "sqlite3://#{Dir.pwd}/bomb.db"
    )
  end
  get '/' do
    "Time to build an app around here. Start time: " + start_time
  end

  def start_time
    session[:start_time] ||= (Time.now).to_s
  end

  run! if app_file == $PROGRAM_NAME
end
require_relative 'models/init'
require_relative 'helpers/init'
