# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require 'sinatra/flash'
require_relative 'lib/bomb'

  enable :sessions

  get '/' do
    erb :index
  end

  get '/bomb' do
    bomb = nil if bomb
    erb :bomb
  end

  post '/boot' do
    activation_code = params[:activation_code]
    deactivation_code = params[:deactivation_code]
    max_failed_deactivations = 3
    if empty?(activation_code) || empty?(deactivation_code)
      flash_validation
      redirect '/bomb'
    elsif activation_code == deactivation_code
      flash[:duplicate] = "Codes must be different."
      redirect '/bomb'
    elsif !(numeric?(activation_code) && numeric?(deactivation_code))
      flash_validation
      redirect '/bomb'
    else
      create_bomb(activation_code, deactivation_code, max_failed_deactivations)
      redirect '/inactive_bomb'
    end
  end

  get '/inactive_bomb' do
    erb :inactive_bomb
  end

  post '/activate' do
    bomb.enter_code(params[:activation_code])
    if bomb.active?
      redirect '/active_bomb'
    else
      flash[:error] = "Please enter in the correct code, yo!"
      redirect '/inactive_bomb'
    end
  end

  get '/active_bomb' do
    erb :active_bomb
  end

  post '/deactivate' do
    bomb.enter_code(params[:deactivation_code])
    if bomb.inactive?
      flash[:safe] = "You've Saved Megaton! For now..."
      redirect '/inactive_bomb'
    elsif bomb.active?
      flash[:uhoh] = "The Bomb Is Still Active!"
      redirect '/active_bomb'
    else bomb.exploded?
      redirect '/explosion'
    end
  end

  get '/explosion' do
    bomb.exploded?
    erb :explosion
  end

  not_found do
    status 404
    erb :please_stand_by
  end

  # we can shove stuff into the session cookie YAY!
  def start_time
    session[:start_time] ||= (Time.now).to_s
  end

  def bomb
    session[:bomb]
  end

  def create_bomb(activation_code, deactivation_code, max_failed_deactivations)
    bomb = Bomb.new(activation_code, deactivation_code, max_failed_deactivations)
    puts bomb.active?
    session[:bomb] = bomb
  end

  def numeric?(code)
    (/[^[:digit:]]+/).match(code).to_s.empty?
  end

  def empty?(code)
    code.empty?
  end

  def flash_validation
    flash[:validation] = "Codes can only be numeric."
  end
