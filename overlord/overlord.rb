# run `ruby overlord.rb` to run a webserver for this app
require_relative('bomb.rb')
require 'sinatra'

class Overlord < Sinatra::Base
  get '/' do
    error_code = root_error_codes(params[:error].to_i)
    erb :input_codes, locals: { status: 'Inactive', error: error_code }
  end

  get '/activate/' do
    no_bomb_redirect
    erb :activate, locals: { status: current_status }
  end

  post '/activate/' do
    activation = params[:activation]
    deactivation = params[:deactivation]
    validate_codes(activation, deactivation)
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
      session[:bomb].status_reader
    else
      'Inactive'
    end
  end

  def no_bomb_redirect
    redirect to('/?error=3') unless session.key?(:bomb)
  end

  def bomb_status_redirect
    if session[:bomb].status_reader == 'Active'
      redirect to('/deactivate/')
    elsif session[:bomb].status_reader == 'Blown Up'
      redirect to('/boom/')
    else
      redirect to('/hero/')
    end
  end

  def validate_codes(activation, deactivation)
    valid_activation_code = Bomb.valid_code?(activation)
    redirect to('/?error=1') unless valid_activation_code
    valid_deactivation_code = Bomb.valid_code?(deactivation)
    redirect to('/?error=2') unless valid_deactivation_code
  end

  def activate_bomb(key)
    activated_this_turn = session[:bomb].activate(key)
    already_activated = session[:bomb].status_reader == 'Active'
    redirect to('/activate/') unless activated_this_turn || already_activated
  end

  def root_error_codes(index)
    case index
      when 1
        'Invalid activation code. Activation code must be only numbers.'
      when 2
        'Invalid deactivation code. Deactivation code must be only numbers'
      when 3
        'Nice try hero, back to square one for you.'
      else
        ''
    end
  end

  enable :sessions
  run! if app_file == $PROGRAM_NAME
end
