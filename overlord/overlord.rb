require_relative 'bomb'
require 'sinatra'

set :haml, format: :html5
enable :sessions

get '/' do
  session.clear
  create_bomb
  redirect to('/bomb')
end

get '/bomb' do
  haml :bomb, locals: { bomb: bomb }
end

post '/boot' do
  begin
    bomb.boot(params[:act_code], params[:deact_code])
    haml :bomb, locals: { bomb: bomb }
  rescue Bomb::ArgumentError
    redirect to('/bomb')
  end
end

post '/activate' do
  begin
    bomb.activate(params[:act_code])
    haml :bomb, locals: { bomb: bomb }
  rescue Bomb::RuntimeError
    redirect to('/bomb')
  end
end

post '/deactivate' do
  begin
    bomb.deactivate(params[:deact_code])
    haml :bomb, locals: { bomb: bomb }
  rescue Bomb::RuntimeError
    redirect to('/bomb')
  end
end

def create_bomb
  session[:bomb] = Bomb.new
end

def bomb
  session[:bomb]
end
