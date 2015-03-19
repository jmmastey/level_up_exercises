# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra/base'
require_relative 'bomb'

class Overlord < Sinatra::Base
  set :sessions, true

  get '/' do
    redirect to('/configure') unless session[:bomb]

    bomb = session[:bomb]
    read_bomb_state(bomb)
    redirect to('/boom') if @bomb_state == "EXPLODED"

    set_index_page_vars
    erb :index
  end

  post '/' do
    bomb = session[:bomb]
    process_code(bomb, params[:code])

    read_bomb_state(bomb)
    redirect to('/boom') if @bomb_state == "EXPLODED"

    set_index_page_vars
    erb :index
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

  def read_bomb_state(bomb)
    bomb = session[:bomb]
    @bomb_state = bomb.state
  end

  def set_index_page_vars
    @bomb_state_class = @bomb_state.downcase
    @prompt = generate_prompt
  end

  def generate_prompt
    prompt = ""
    if @bomb_state == "INACTIVE"
      prompt = "Enter activation code to arm bomb:"
    elsif @bomb_state == "ARMED"
      prompt = "Enter deactivation code to disarm bomb:"
    end
    prompt
  end

  def process_code(bomb, code)
    return if code.strip == ""

    state = bomb.state
    bomb.arm(code) if state == "INACTIVE"
    bomb.disarm(code) if state == "ARMED" && code != bomb.arm_code
  end

  run! if app_file == $PROGRAM_NAME
end
