# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra/base'
require_relative 'bomb'

class Overlord < Sinatra::Base
  set :sessions, true

  get '/' do
    session[:bomb] ||= Bomb.new
    bomb = session[:bomb]
    read_bomb_state(bomb)
    set_prompt(bomb.state)
    erb :index
  end

  post '/' do
    bomb = session[:bomb]
    code = params[:code]
    process_code(bomb, code)
    read_bomb_state(bomb)
    erb :index
  end

  def read_bomb_state(bomb)
    bomb = session[:bomb]
    @bomb_state = bomb.state
    @bomb_state_class = @bomb_state.downcase
  end

  def process_code(bomb, code)
    state = bomb.state
    if (state == "INACTIVE")
      bomb.arm(code)
    elsif (state == "ARMED")
      bomb.disarm(code)
    end

    state = bomb.state
    set_prompt(state)
  end

  def set_prompt(state)
    @prompt = ""
    if state == "INACTIVE"
        @prompt = "Enter activation code to arm bomb:"
    elsif state == "ARMED"
        @prompt = "Enter deactivation code to disarm bomb:"
    end
  end

  run! if app_file == $0
end
