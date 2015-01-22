# run `ruby overlord.rb` to run a webserver for this app

require_relative 'bomb'
require 'sinatra'

enable :sessions

get '/' do
  session.clear
  session[:bomb] = nil
  redirect to('/boot_bomb')
end

get '/boot_bomb' do
  haml :enter_codes, locals: { bomb: bomb }
end

post '/boot_bomb' do
  create_bomb(params[:act_code], params[:deact_code])
  redirect to('/activate')
end

get '/activate' do
  haml :booted_bomb, locals: { bomb: bomb, bad_code: session[:bad_act_code] }
end

post '/activate' do
  bomb.try_to_activate(params[:submitted_act_code])
  if bomb.state == false
    session[:bad_act_code] = true
    redirect to('/activate')
  end
  haml :active_bomb, locals: { bomb: bomb }
end

get '/deactivate' do
  haml :active_bomb, locals: { bomb: bomb }
end

post '/deactivate' do
  if bomb.attempts_remaining > 0
    bomb.try_to_deactivate(params[:submitted_deact_code])
  end
  haml :active_bomb, locals: { bomb: bomb }
end

def create_bomb(act_code, deact_code)
  session[:bomb] = Bomb.new(act_code, deact_code)
end

def bomb
  session[:bomb]
end
