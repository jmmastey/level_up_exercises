require 'sinatra'
require_relative 'bomb'

enable :sessions

set :codes, {}

def bomb
  session[:bomb] ||= Bomb.new(settings.codes)
end

get '/' do
  erb bomb.status
end

post '/activate' do
  bomb.activate(params['activation-code'])
  redirect to('/')
end

post '/deactivate' do
  bomb.deactivate(params['deactivation-code'])
  redirect to('/')
end

get '/new' do
  session[:bomb] = Bomb.new(settings.codes)
  redirect to('/')
end
