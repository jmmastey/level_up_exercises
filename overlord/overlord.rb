require 'sinatra/base'
require 'rack-flash'
require_relative 'application_controller'

class Overlord < Sinatra::Application

  enable :sessions
  set :pseudo_in_memory_store, Hash.new({})
  set :env, environment
  use Rack::Flash

  Tilt.register Tilt::ERBTemplate, 'html.erb'

  get '/' do
    destination, redirected, message = ApplicationController.new.service(get_in_memory_session, request)
    flash[:notice] = message if message
    redirect to(destination) if redirected

    erb :bomb_activation 
  end

  post '/activate' do
    destination, redirected = ApplicationController.new.service(get_in_memory_session, request)
    redirect to(destination)
  end

  get '/activated' do
    server_side_session = get_in_memory_session
    destination, redirected = ApplicationController.new.service(get_in_memory_session, request)
    redirect to(destination) if redirected

    erb :armed_countdown, locals: {armed_at: server_side_session[:bomb].state[:armed_at], timer: server_side_session[:bomb].state[:timer].to_i, env: settings.env}
  end

  post '/deactivate' do
    destination, redirected, message = ApplicationController.new.service(get_in_memory_session, request)
    flash[:notice] = message
    redirect to(destination)
  end

  get '/boom' do
    destination, redirected, message = ApplicationController.new.service(get_in_memory_session, request)
    flash[:notice] = message
    redirect to(destination) if redirected

    erb :blown
  end

  not_found do
    flash[:notice] = "Sorry, maybe try looking in Narnia?"
    redirect to('/')
  end

  error do
    flash[:notice] = "We screwed up, sorry!"
    reset_in_memory_session
    redirect to ('/')
  end

  private
  def get_in_memory_session
    settings.pseudo_in_memory_store[session[:session_id]]
  end

  def reset_in_memory_session
    settings.pseudo_in_memory_store[session[:session_id]] = {}
  end

end
