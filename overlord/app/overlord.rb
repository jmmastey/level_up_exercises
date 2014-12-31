require 'sinatra/base'
require 'rubygems'
require File.dirname(__FILE__) + '/../vendor/bundle/ruby/2.0.0/gems/rack-flash3-1.0.5/lib/rack-flash'
# require 'rack-flash3' # why isn't this working??

require_relative "models/bomb"

class Overlord < Sinatra::Base
  enable :sessions
  use Rack::Flash, sweep: true

  before '/bomb/*' do
    redirect "/" unless session[:bomb]
    @bomb = bomb(params[:bomb])
    redirect "/exploded" if bomb.exploded?
  end

  get '/' do
    session.clear
    erb :new_bomb
  end

  post '/' do
    @bomb = bomb(params[:bomb])
    redirect "/bomb/inactive"
  end

  get '/bomb/inactive' do
    @bomb = bomb
    erb :inactive_bomb
  end

  post '/bomb/activate' do
    @bomb = bomb
    @bomb.activate(params[:activation_code])
    if bomb.active?
      redirect "bomb/active"
    else
      flash[:notice] = "Incorrect code - bomb not active"
      redirect '/bomb/inactive'
    end
  end

  get '/bomb/active' do
    @bomb = bomb
    erb :active_bomb
  end

  post '/bomb/deactivate' do
    @bomb = bomb
    @bomb.deactivate(params[:deactivation_code])
    if @bomb.active?
      flash[:notice] = "Incorrect code - ur still gonna blow! <br> \
                       Incorrect Attempts: #{@bomb.deactivation_attempts}"
      redirect "/bomb/active"
    else
      flash[:notice] = "Bomb has been deactivated"
      redirect '/bomb/inactive'
    end
  end

  get "/exploded" do
    erb :exploded
  end

  # ==================================================

  def bomb(options = {})
    session[:bomb] ||= Bomb.new(options)
  end

  run! if app_file == $PROGRAM_NAME
end
