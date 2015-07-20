# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require_relative './bomb'
require 'pry'
require 'haml'

enable :sessions

get '/' do
  haml :index
end

post '/configure' do
  bomb = Bomb.new(params['activation_code'], params['deactivation_code'])
  if bomb.booted?
    session[:bomb] = bomb
    redirect "/bomb"
  else
    @message = "Invalid code"
    haml :index
  end
end

get '/bomb' do
  @bomb = session[:bomb]
  haml :bomb
end

post '/activate' do
  @bomb = session[:bomb]
  @bomb.activate(params['activation_code']) unless @bomb.activated?
  redirect 'bomb'
end

post '/deactivate' do
  @bomb = session[:bomb]
  @bomb.deactivate(params['deactivation_code'])
  if @bomb.deactivated?
    redirect 'safe'
  elsif @bomb.exploded?
    redirect 'exploded'
  else
    redirect 'bomb'
  end
end

get '/safe' do
  haml :safe
end

get '/exploded' do
  haml :exploded
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end
