# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra/base'
require_relative 'bomb'

class Overlord < Sinatra::Base
  set :sessions, true

  get '/' do
    session[:bomb] ||= Bomb.new
    bomb = session[:bomb]

    read_bomb_state(bomb)
    redirect to('/boom') if @bomb_state == "EXPLODED"

    generate_index_page_vars
    erb :index
  end

  post '/' do
    bomb = session[:bomb]
    process_code(bomb, params[:code])

    read_bomb_state(bomb)
    redirect to('/boom') if @bomb_state == "EXPLODED"

    generate_index_page_vars
    erb :index
  end

  get '/boom' do
    erb :boom
  end

  def read_bomb_state(bomb)
    bomb = session[:bomb]
    @bomb_state = bomb.state
  end

  def generate_index_page_vars
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
