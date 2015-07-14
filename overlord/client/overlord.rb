# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require './bomb'
require 'pry'

bomb = Bomb.new

get '/' do
  bomb.status.to_s
end

post '/boot' do
  try_method(-> { bomb.boot },
             -> { bomb.status.to_s })
end

post '/submit_code' do
  try_method(-> { bomb.enter_code(params[:code]) },
             -> { bomb.status.to_s })
end

get '/timer' do
  bomb.time_left
end

post '/set_activation_key' do
  try_method(-> { bomb.activation_key = params[:key] },
             -> { bomb.activation_key })
end

post '/set_deactivation_key' do
  try_method(-> { bomb.deactivation_key = params[:key] },
             -> { bomb.deactivation_key })
end

# Temporary Debug Method
put '/bomb' do
  bomb = Bomb.new
  "new bomb"
end

def try_method(action, success)
  action.()
  success.()
rescue StandardError => e
  e.message
end
