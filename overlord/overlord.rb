# run `ruby overlord.rb` to run a webserver for this app

require 'json'
require 'sinatra'
require './classes/bomb.rb'

enable :sessions

get '/index' do
  session[:bomb] = Bomb.new
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
  success = false
  if(session[:bomb].attempts_remain > 0)
    if(session[:bomb].armed?)
      success = session[:bomb].disarm(params[:code])
    else
      success = session[:bomb].arm(params[:code])
    end
  end

  content_type :json
  response = {'success' => success}
  response['attempts_remain'] = session[:bomb].attempts_remain
  response['state'] = session[:bomb].state_to_s

  response.to_json
end

post "/setcodes" do
  session[:bomb].set_codes(params)
end
