# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require 'json'
require './bomb'
require 'pry'

before do
   content_type :json
   headers 'Access-Control-Allow-Origin' => '*',
            'Access-Control-Allow-Methods' => 'OPTIONS, GET, POST, PUT'
end

set :protection, false

bomb = Bomb.new

get '/' do
  content_type :json
  { :message => bomb.status.to_s }.to_json
end

post '/boot' do
  content_type :json
  { :message => try_method(-> { bomb.boot },
                           -> { "Update: Bomb Status " +
                                bomb.status.to_s }) }.to_json
end

post '/submit_code' do
  content_type :json
  { :message => try_method(-> { bomb.enter_code(params[:code]) },
                           -> { "Update: Bomb Status " +
                                bomb.status.to_s }) }.to_json
end

get '/timer' do
  content_type :json
  { :message => bomb.time_left }.to_json
end

post '/set_activation_code' do
  content_type :json
  { :message => try_method(-> { bomb.activation_key = params[:code] },
                           -> { "Alert: Activation Code set to: " +
                                bomb.activation_key }) }.to_json
end

post '/set_deactivation_code' do
  content_type :json
  { :message => try_method(-> { bomb.deactivation_key = params[:code] },
                           -> { "Alert: Deactivation Code set to: " +
                                bomb.deactivation_key }) }.to_json
end

options "*" do
  200
end

put '/bomb' do
  content_type :json
  bomb = Bomb.new
  { :message => "Alert: New Bomb" }.to_json
end

def try_method(action, success)
  action.()
  success.()
rescue StandardError => e
  "Error: " + e.message
end
