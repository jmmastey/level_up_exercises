require 'sinatra/base'
require_relative 'bomb'

class Overlord < Sinatra::Base
  set :sessions, true

  get '/' do
    redirect to('/configure') unless session[:bomb]

    bomb = session[:bomb]
    redirect to('/boom') if bomb.exploded?

    set_home_page_vars
    erb :home_page
  end

  post '/' do
    success = process_code(params[:code])
    bomb = session[:bomb]
    set_error_message if bomb.armed? && !success

    redirect to('/boom') if bomb.exploded?

    set_home_page_vars
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

  def set_home_page_vars
    bomb = session[:bomb]
    @bomb_state = bomb.state
    @bomb_state_class = @bomb_state.downcase
    @prompt = generate_prompt
  end

  def generate_prompt
    bomb = session[:bomb]
    if bomb.inactive?
      prompt = "Enter activation code to arm bomb:"
    elsif bomb.armed?
      prompt = "Enter deactivation code to disarm bomb:"
    end
    prompt || ""
  end

  def process_code(code)
    bomb = session[:bomb]
    # ignore empty codes
    # ignore the correct activation code after the bomb is armed
    return true if code.strip == "" || (bomb.armed? && code == bomb.arm_code)
    return bomb.arm(code) if bomb.inactive?
    return bomb.disarm(code) if bomb.armed?
    false
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
