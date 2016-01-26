# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require_relative "lib/bomb"
require_relative "lib/timer"
require_relative "lib/wire_bundle"
require_relative "lib/wire"

enable :sessions

# get '/' do
#   "Time to build an app around here. Start time: " + start_time
# end

get '/' do
  erb :index
end

get '/codes/' do
  erb :codes_form
end

post '/codes/' do
  activation_code = params[:activation_code] || "You have no activation code"
  defuse_code = params[:defuse_code] || "You have no defuse code"

  erb :index, locals: { 'activation_code' => activation_code, 'defuse_code' => defuse_code }
  session[:bomb] ||= (Bomb.new(activation_code, defuse_code))
  redirect index
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end

def set_up
  session[:bomb] ||= (Bomb.new(1111, 9999))
end
