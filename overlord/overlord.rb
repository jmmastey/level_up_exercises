require 'json'
require 'sinatra'
require 'haml'
require './bomb'

enable :sessions
$bomb ||= nil

get '/' do
  if $bomb
    if $bomb.detonated?
      haml :index, locals: { bomb_view: :_bomb_detonated }
    elsif $bomb.active?
      haml :index, locals: { bomb_view: :_bomb_active }
    else
      haml :index, locals: { bomb_view: :_bomb_inactive }
    end
  else
    haml :index, locals: { bomb_view: :_bomb_new }
  end
end

post '/initialize' do
  activation_code = params['activation_code']
  deactivation_code = params['deactivation_code']

  $bomb = Bomb.new(activation_code, deactivation_code)
end

post '/activate' do
  activation_code = params['activation_code']
  $bomb.activate(activation_code)
end

post '/deactivate' do
  deactivation_code = params['deactivation_code']
  $bomb.deactivate(deactivation_code)
end
