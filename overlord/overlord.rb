# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require 'sinatra/base'
require 'capybara/rspec'
require 'tilt/erubis'
require './bomb'

class Overlord < Sinatra::Base
  enable :sessions

  set :port, 8888
  set :views, 'views'
  set :run, true
  set :raise_errors, true
  set :dump_errors, false
  # enable :lock

  get '/' do
    'Time to boot a bomb. Start time: ' << start_time
  end

  get '/boot/' do
    erb :boot_form
  end

  post '/boot/' do
    the_bomb.boot(params[:activation], params[:deactivation])
    erb :index, locals: { activation: params[:activation], deactivation: params[:deactivation] }
  end

  get '/arm/' do
    erb :index
  end

  post '/arm/' do
    the_bomb.arm(params[:armingcode])
    erb :index
  end

  get '/disarm/' do
    erb :index
  end

  post '/disarm/' do
    the_bomb.disarm(params[:disarmingcode])
    erb :index
  end

  def the_bomb
    session[:bomb] ||= Bomb.new
    session[:bomb]
  end

  def start_time
    session[:start_time] ||= (Time.now).to_s
  end

  def setup
    Capybara.app = Sinatra::Application.new
  end

  run! if app_file == $PROGRAM_NAME
end
