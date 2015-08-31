# run `ruby overlord.rb` to run a webserver for this app
require_relative('bomb.rb')
require 'sinatra'

class Overlord < Sinatra::Base
  get '/' do
    error = session[:error]
    session.delete(:error)
    erb :input_codes, locals: { status: 'Inactive', error: error }
  end

  get '/activate/' do
    no_bomb_redirect
    erb :activate, locals: { status: current_status }
  end

  post '/activate/' do
    activation = params[:activation]
    deactivation = params[:deactivation]
    code_redirect(activation, deactivation)
    session[:bomb] = Bomb.new(activation, deactivation)
    erb :activate, locals: { status: current_status }
  end

  get '/deactivate/' do
    no_bomb_redirect
    erb :deactivate, locals: { status: current_status }
  end

  post '/deactivate/' do
    activate_bomb(params[:activation])
    deactivation = params[:deactivation]
    session[:bomb].deactivate(deactivation) unless deactivation.nil?
    bomb_status_redirect
  end

  get '/hero/' do
    no_bomb_redirect
    erb :hero
  end

  get '/boom/' do
    no_bomb_redirect
    erb :boom
  end

  def current_status
    if session.key?(:bomb)
      session[:bomb].status
    else
      'Inactive'
    end
  end

  def code_redirect(activation, deactivation)
    error = Bomb.validate_codes(activation, deactivation)
    return '' if error.nil?
    session[:error] = error
    redirect to('/')
  end

  # Redirect with error if we try to jump to a page/state we shouldn't
  def no_bomb_redirect
    session[:error] = 'Nice try hero, back to square one for you.'
    redirect to('/') unless session.key?(:bomb)
  end

  def bomb_status_redirect
    if session[:bomb].status == 'Active'
      redirect to('/deactivate/')
    elsif session[:bomb].status == 'Blown Up'
      redirect to('/boom/')
    else
      redirect to('/hero/')
    end
  end

  def activate_bomb(key)
    activated_this_turn = session[:bomb].activate(key)
    already_activated = session[:bomb].status == 'Active'
    redirect to('/activate/') unless activated_this_turn || already_activated
  end

  enable :sessions
  run! if app_file == $PROGRAM_NAME
end
