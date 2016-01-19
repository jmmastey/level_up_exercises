require 'sinatra'
require 'json'
require 'pry'
require_relative 'lib/bomb.rb'

public
get '/' do
  @@bomb = Bomb.new
  erb :bomb, :locals => {:bomb => @@bomb}
end

get '/state' do
#binding.pry
  content_type :json
  {:state => @@bomb.state.to_s}.to_json  
end

get '/fetch_bomb_codes' do
#binding.pry
  content_type :json
  {
   :activation_code => @@bomb.activation_code,
   :deactivation_code => @@bomb.deactivation_code,
   :state => @@bomb.state.to_s
  }.to_json
end

get '/email' do
  File.read(File.join('public', 'email.html'))
end

get '/verify_code/:code' do
#binding.pry
  @@bomb.enter_code(params[:code]) 
  redirect to('/state') 
end

get '/email_list' do
  File.read(File.join('public', 'email_list.html'))
end
