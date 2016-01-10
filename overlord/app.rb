require 'sinatra'
require 'pry'
require_relative 'lib/bomb.rb'

get '/' do
  bomb = Bomb.new
  erb :bomb, :locals => {:bomb => bomb}
end

get '/verify_activation_code' do
end
