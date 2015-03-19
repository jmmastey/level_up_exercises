require 'json'
require 'sinatra'
require 'haml'
require './bomb'

enable :sessions
$bomb ||= nil

get '/' do
  haml :index, locals: { bomb: $bomb }
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
