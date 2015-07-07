# run `ruby overlord.rb` to run a webserver for this app

require 'json'
require 'sinatra'
require './classes/bomb.rb'

enable :sessions

get '/index' do
  haml :index, :locals => {:bomb => session[:bomb]}
end

get '/hack' do
  b = params[:binary].split(//).map(&:to_i)
  p = params[:panel].to_i

  content_type :json
  {'success' => session[:bomb].attempt_hack(b, p),
    'done' => session[:bomb].all_hacked? }.to_json
end

get '/code' do
  if(session[:bomb].armed?)
    session[:bomb].disarm(params[:code])
  else
    session[:bomb].arm(params[:code])
  end

  content_type :json
  {'armed' => session[:bomb].armed? }.to_json
end

post "/setcodes" do
  puts params
  session[:bomb] = Bomb.new(params)
end
