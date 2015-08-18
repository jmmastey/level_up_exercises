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
    replace_empty_params(activation, deactivation)
    valid = Bomb.validate_codes(activation, deactivation)
    new_bomb_errors(valid) unless valid == 0
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

  def no_bomb_redirect
    redirect to('/?error=3') unless session.key?(:bomb)
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

  def new_bomb_errors(error)
    redirect to("/?error=#{error}")
  end

  def activate_bomb(key)
    activated_this_turn = session[:bomb].activate(key)
    already_activated = session[:bomb].status == 'Active'
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

  def replace_empty_params(activation, deactivation)
    activation.replace('1234') if activation == ''
    deactivation.replace('0000') if deactivation == ''
  end

  enable :sessions
  run! if app_file == $PROGRAM_NAME
end
