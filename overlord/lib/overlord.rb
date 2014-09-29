# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require_relative 'bomb'

enable :sessions

get '/' do
  erb :index, layout: :layout_no_header
end

get '/start' do
  if bomb.exploded?
    erb :exploded
  elsif bomb.activated?
    erb :activated
  else
    erb :start
  end
end

get '/restart' do
  session[:bomb] = Bomb.new
  redirect '/start'
end

post '/activate' do
  begin
    bomb.activate(params[:activation_code], params[:deactivation_code])
    erb :activated
  rescue ArgumentError => @activation_error
    erb :start
  rescue Bomb::BombError => @bomb_error
    erb :exploded
  end
end

post '/deactivate' do
  begin
    bomb.deactivate(params[:deactivation_code])
    if bomb.exploded?
      erb :exploded
    elsif bomb.activated?
      @bomb_error = "Incorrect deactivation code"
      erb :activated
    else
      erb :deactivated
    end
  rescue Bomb::BombError => @bomb_error
    erb :activated
  end
end

def bomb
  session[:bomb] ||= Bomb.new
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end
