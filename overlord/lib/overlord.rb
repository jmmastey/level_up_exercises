require 'sinatra/base'
require "pry"
require_relative "models/bomb"

class Overlord < Sinatra::Base
  enable :sessions

  before '/bomb/*' do
    if session[:incorrect_deactivate_attempts] >= 3 || Time.now >= (session[:timer] + 7)
      redirect "/exploded"
    end
  end

  get '/' do
    session.clear
    session[:incorrect_deactivate_attempts] = 0
    session[:timer] = Time.new(3000,11,1)
    erb :new_bomb
  end

  post '/bomb' do
    session[:bomb] = Bomb.new(params[:bomb])
    @bomb = session[:bomb]
    redirect "/bomb/inactive"
  end

  get '/bomb/inactive' do
    @bomb = session[:bomb]
    @activate_errors = session[:activate_errors]
    @deactived_status = session[:deactived_status]
    erb :inactive_bomb
  end

  post '/bomb/activate' do
    @bomb = session[:bomb]
    @bomb.activate(params[:activation_code])
    if @bomb.active?
      session[:activate_errors] = nil
      session[:timer] = Time.now
      redirect "bomb/active"
    else
      session[:activate_errors] = "Incorrect code - bomb not active"
      redirect '/bomb/inactive'
    end
  end

  get '/bomb/active' do
    @bomb = session[:bomb]
    @deactivate_error = session[:deactivate_error]
    @attempts = session[:incorrect_deactivate_attempts]
    erb :active_bomb
  end 

  post '/bomb/deactivate' do
    # binding.pry
    @bomb = session[:bomb]
    @bomb.deactivate(params[:deactivation_code])
    if @bomb.active?
      session[:deactivate_error] = "Incorrect code - ur still gonna blow!"
      session[:incorrect_deactivate_attempts] += 1
      redirect "/bomb/active"
    else
      session[:timer] = Time.new(3000,11,1)
      session[:deactivate_error] = nil
      session[:deactived_status] = "Bomb has been deactivated"
      redirect '/bomb/inactive'
    end
  end

  get "/exploded" do
    "<h1>Everyone's dead</h1> <br> <h2>It's a cold world.</h2>"
  end

# ==================================================

  def start_time
    session[:start_time] ||= (Time.now).to_s
  end

  run! if app_file == $0
end
