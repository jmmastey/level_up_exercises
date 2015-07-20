# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require 'sinatra/base'
require 'capybara/rspec'
require 'tilt/erubis'
require './bomb'


class Overlord < Sinatra::Base

  enable :sessions

  set :port, 8888
  set :views, "views"
  set :run, true
  set :raise_errors, true
  set :dump_errors, false
  # enable :lock


  get '/' do
    "Time to build an app around here. Start time: " + start_time
  end

  get '/boot/' do
     erb :boot_form
  end

  post '/boot/' do
    the_bomb.load(:deactivation_code=> params[:deactivation],:activation_code=> params[:activation])
    erb :index, :locals => {'activation' => params[:activation], 'deactivation' => params[:deactivation]}
  end

  get '/arm/' do
    erb :index
  end

  post '/arm/' do
    the_bomb.arm(params[:armingcode])
    erb :index#, :locals => {'armingcode' => params[:armingcode]}
  end

  get '/disarm/' do
    erb :index
  end

  post '/disarm/' do
    the_bomb.disarm(params[:disarmingcode])
    erb :index#, :locals => {'armingcode' => params[:armingcode]}
  end

  def the_bomb
    session[:bomb] ||=Bomb.new
     session[:bomb]
  end

# we can shove stuff into the session cookie YAY!
  def start_time
    session[:start_time] ||= (Time.now).to_s
  end

  get '/*' do
    viewname = params[:splat].first   # eg "some/path/here"

    # if File.exist?("views/#{viewname}.erb")
    #   erb :"#{viewname}"

    # else
    #   "Nopers, I can't find it."
    # end
  end


  # get '/:name' do
  #   "Hello, #{params[:name]}!, it is: " + start_time
  # end

  def setup
    Capybara.app = Sinatra::Application.new
  end

private



  run! if app_file == $0
end
