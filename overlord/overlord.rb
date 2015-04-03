require 'json'
require 'sinatra'
require 'haml'
require './bomb'

enable :sessions

get '/' do
  if bomb
    if bomb.detonated?
      haml :index, locals: { bomb_view: :_bomb_detonated, default_codes: nil }
    elsif bomb.active?
      haml :index, locals: { bomb_view: :_bomb_active, default_codes: bomb.using_default_codes? }
    else
      haml :index, locals: { bomb_view: :_bomb_inactive, default_codes: bomb.using_default_codes? }
    end
  else
    haml :index, locals: { bomb_view: :_bomb_new, default_codes: nil }
  end
end

post '/initialize' do
  return unless bomb.detonated? if bomb

  activation_code = params['activation_code']
  deactivation_code = params['deactivation_code']

  session[:bomb] = Bomb.new(activation_code, deactivation_code)
end

post '/activate' do
  activation_code = params['activation_code']
  bomb.activate(activation_code)
end

post '/deactivate' do
  deactivation_code = params['deactivation_code']
  bomb.deactivate(deactivation_code)
end

def bomb
  session[:bomb]
end
