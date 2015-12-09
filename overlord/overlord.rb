# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require_relative 'lib/bomb'

enable :sessions

get '/' do
  @bomb = new_default_bomb
  erb :bomb, :locals => { :name => 'test' }
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end

def new_default_bomb
  Bomb.new("1234", "0000")
end

def serialize_to_session bomb
  session[:bomb] = bomb.serialize
end

def deserialize_session
  return new_default_bomb unless session[:bomb]
end