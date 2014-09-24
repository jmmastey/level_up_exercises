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
  set :port, 80

  get '/' do
    @bomb = session[:bomb] || new_bomb
    session[:bomb] = @bomb
    haml(:index)
  end

  get '/snip/:color' do
    @bomb = session[:bomb]
    @bomb.devices[:wirebox].snip(params[:color].to_sym)
    redirect to('/')
  end

  get '/enter/:code/:seconds' do
    @bomb = session[:bomb]
    codebox = @bomb.devices[:codebox]
    timer = @bomb.devices[:timer]
    if codebox.active?
      codebox.deactivate(params[:code])
      timer.stop unless codebox.active?
    else
      codebox.activate(params[:code])
      timer.reset(params[:seconds].to_i)
      timer.start
    end
    redirect to('/')
  end

  get '/reset' do
    session[:bomb] = new_bomb
    redirect to('/')
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
