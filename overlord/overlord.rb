require_relative 'bomb'
require 'sinatra'
# require 'pry'

enable :sessions
set :haml, format: :html5
set :assets_css_compressor, :scss

get '/assets/css/:name.scss' do |name|
  require './views/scss/bourbon/lib/bourbon.rb'
  content_type :css
  scss "scss/#{name}".to_sym, :layout => false
end

get '/' do
  develop_bomb
  haml :index, locals: { bomb: bomb }
end

post '/boot' do
  bomb.boot(params['activation_code'], params['deactivation_code'])
  haml :booted, locals: { bomb: bomb }
end

get '/boot' do
  haml :booted, locals: { bomb: bomb }
end

post '/activate' do
  bomb.activation_attempt(params['activation_code'])
  page_to_load = bomb.status == :activated ? :active : :booted
  haml page_to_load, locals: { bomb: bomb }
end

post '/deactivate' do
  bomb.deactivation_attempt(params['deactivation_code'])

  page_to_load = load_page_by_status
  puts page_to_load
  haml page_to_load, locals: { bomb: bomb }
end

def develop_bomb
  session[:bomb] = Bomb.new
end

def bomb
  session[:bomb]
end

def load_page_by_status
  case bomb.status
    when :invalid
      :active
    when :deactivated
      :booted
    when :exploded
      :explode
  end
end
