# run `ruby overlord.rb` to run a webserver for this app

require "haml"
require "pry"
require "sinatra/base"
require "sinatra"
require_relative "src/bomb"
require_relative "src/wire_box"
require_relative "src/bomb_timer"
require_relative "src/bomb_code_box"

enable :sessions

class Overlord < Sinatra::Application
  WIREBOX_COLORS = [:red, :green, :blue, :yellow, :orange]
  set :haml, format: :html5
  set :sessions, true

  get '/' do
    @bomb = new_bomb
    session[:bomb] = @bomb
    haml(:index)
  end

  def new_bomb
    wirebox = random_wirebox
    codebox = BombCodeBox.new
    timer = BombTimer.new
    Bomb.new(wirebox: wirebox, timer: timer, codebox: codebox)
  end

  def random_wirebox
    WireBox.new(wire_colors: WIREBOX_COLORS, safe_color: WIREBOX_COLORS.sample)
  end

  run! if app_file == $PROGRAM_NAME
end
