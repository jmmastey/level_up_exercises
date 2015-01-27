require_relative 'bomb'
require 'sinatra'

set :haml, format: :html5
enable :sessions

get '/' do
  session.clear
  create_bomb
  redirect to('/boot')
end

get '/boot' do
  haml :enter_codes, locals: { bomb: bomb }
end

post '/boot' do
  begin
    bomb.boot(params[:act_code], params[:deact_code])
  rescue Bomb::ArgumentError
    redirect to('/boot')
  end
  redirect to('/activate')
end

get '/activate' do
  haml :booted_bomb, locals: { bomb: bomb, bad_act_code: false }
end

post '/activate' do
  bomb.activate(params[:submitted_act_code])
  if !bomb.active && !bomb.exploded
    session[:bad_act_code] = true
    redirect to('/activate')
  haml :live_bomb, locals: { bomb: bomb }
end

get '/deactivate' do
  haml :live_bomb, locals: { bomb: bomb }
end

post '/deactivate' do
  if bomb.attempts_remaining > 0
    bomb.deactivate(params[:submitted_deact_code])
  end
  haml :live_bomb, locals: { bomb: bomb }
end

def create_bomb
  session[:bomb] = Bomb.new
end

def bomb
  session[:bomb]
end
