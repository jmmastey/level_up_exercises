# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require_relative 'lib/bomb'

enable :sessions

get '/bomb/:activation_code/:deactivation_code' do
  @bomb = get_bomb params
  erb :bomb
end

get '/newbomb/:activation_code/:deactivation_code' do
  @bomb = new_bomb params
  set_bomb @bomb
  redirect to('/bomb')
end

get '/bomb' do
  @bomb = get_bomb params
  set_bomb @bomb
  erb :bomb
end

post '/activate' do
  @bomb = get_bomb params
  @bomb.enter_code(params[:activation_code])
  set_bomb @bomb
  redirect to('/bomb')
end

post '/deactivate' do
  @bomb = get_bomb params
  puts "params: #{params}"
  @bomb.enter_code(params[:deactivation_code])
  set_bomb @bomb
  redirect to('/bomb')
end

post '/newbomb' do
  session[:bomb] = nil
  redirect to('/bomb')
end

def new_bomb params
  raise "need a number for code" unless is_number?(params[:activation_code]) and 
                                        is_number?(params[:deactivation_code])
  Bomb.new(params[:activation_code] || "1234", 
           params[:deactivation_code] || "0000")
end

def set_bomb(bomb)
  session[:bomb] = bomb
end

def get_bomb(params)
  puts "found session bomb #{session[:bomb]}"
  session[:bomb] || new_bomb(params)
end

def is_number? string
  return true if string.nil? || string == ''
  true if Integer(string) rescue false
end
