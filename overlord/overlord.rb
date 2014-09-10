require 'sinatra/base'
require 'rack-flash'
require_relative 'application_controller'

class Overlord < Sinatra::Application

  enable :sessions
  set :pseudo_in_memory_store, Hash.new({})
  set :env, environment
  use Rack::Flash

  Tilt.register Tilt::ERBTemplate, 'html.erb'

  before do
    @destination, @redirected, @message = ApplicationController.new.service(get_in_memory_session, request)
  end

  get '/' do
    flash[:notice] = @message if @message
    redirect to(@destination) if @redirected

    erb :bomb_activation 
  end

  post '/activate' do
    redirect to(@destination)
  end

  get '/activated' do
    redirect to(@destination) if @redirected

    erb :armed_countdown, locals: {armed_at: bomb_state(:armed_at), timer: bomb_state(:timer).to_i, env: settings.env}
  end

  post '/deactivate' do
    flash[:notice] = @message
    redirect to(@destination)
  end

  get '/boom' do
    flash[:notice] = @message
    redirect to(@destination) if @redirected

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

  def bomb_state state
    get_in_memory_session.send(:[], :bomb).state.send(:[], state)
  end

  def reset_in_memory_session
    settings.pseudo_in_memory_store[session[:session_id]] = {}
  end

end
