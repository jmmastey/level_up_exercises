require 'json'
require 'sinatra'
require 'haml'
require './bomb'

enable :sessions

get '/' do
  if session[:bomb]
    if session[:bomb].detonated?
      haml :index, locals: { bomb_view: :_bomb_detonated }
    elsif session[:bomb].active?
      haml :index, locals: { bomb_view: :_bomb_active }
    else
      haml :index, locals: { bomb_view: :_bomb_inactive }
    end
  else
    haml :index, locals: { bomb_view: :_bomb_new }
  end
end

post '/initialize' do
  return if session[:bomb]

  activation_code = params['activation_code']
  deactivation_code = params['deactivation_code']

  session[:bomb] = Bomb.new(activation_code, deactivation_code)
end

post '/activate' do
  activation_code = params['activation_code']
  session[:bomb].activate(activation_code)
end

post '/deactivate' do
  deactivation_code = params['deactivation_code']
  session[:bomb].deactivate(deactivation_code)
end
