require 'sinatra/base'
require_relative 'bomb'

class Overlord < Sinatra::Base
  set :sessions, true

  get '/' do
    @bomb = session[:bomb]
    redirect to('/configure') unless @bomb
    redirect to('/boom') if @bomb.exploded?
    erb :home_page
  end

  post '/' do
    @bomb = session[:bomb]
    success = @bomb.process_code(params[:code])
    set_error_message if @bomb.armed? && !success
    redirect to('/boom') if @bomb.exploded?
    erb :home_page
  end

  get '/configure' do
    redirect to('/') if session[:bomb]
    set_configure_page_vars
    erb :configure
  end

  post '/configure' do
    arm_code = fetch_arm_code
    disarm_code = fetch_disarm_code

    if codes_valid?(arm_code, disarm_code)
      session[:bomb] = Bomb.new(arm_code, disarm_code)
      redirect to('/')
    end

    @error_msg = "You entered an invalid code"
    set_configure_page_vars
    erb :configure
  end

  get '/boom' do
    erb :boom
  end

  def fetch_arm_code
    arm_code = params[:arm_code].strip
    arm_code = Bomb.arm_code_default if arm_code == ""
    arm_code
  end

  def fetch_disarm_code
    disarm_code = params[:disarm_code].strip
    disarm_code = Bomb.disarm_code_default if disarm_code == ""
    disarm_code
  end

  def set_configure_page_vars
    @arm_code_default = Bomb.arm_code_default
    @disarm_code_default = Bomb.disarm_code_default
  end

  def codes_valid?(arm_code, disarm_code)
    Bomb.code_valid?(arm_code) && Bomb.code_valid?(disarm_code)
  end

  def set_error_message
    bomb = session[:bomb]
    @error_msg = "Incorrect code. "
    if bomb.disarm_retries == 1
      @error_msg += "You have 1 try remaining."
    else
      @error_msg += "You have #{bomb.disarm_retries} tries remaining."
    end
  end

  run! if app_file == $PROGRAM_NAME
end
