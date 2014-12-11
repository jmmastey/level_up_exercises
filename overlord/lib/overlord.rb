require 'sinatra/base'
require_relative "models/bomb"

class Overlord < Sinatra::Base
  enable :sessions

  get '/' do
    "Time to build an app around here. Start time: " + start_time
  end

  get '/bomb/new' do
  	erb :new_bomb
  end

  post '/bomb' do
  	session[:bomb] = Bomb.new(params)
  	@bomb = session[:bomb]
  	redirect "bomb/inactive"
  end

  get '/bomb/inactive' do
  	@bomb = session[:bomb]
  	erb :inactive_bomb
  end

  post '/bomb/activate' do
  	@bomb = session[:bomb]
  	@bomb.activate(params[:activation_code])
  	if @bomb.active?
  		erb :active_bomb
  	else
  		redirect 'bomb/inactive', locals: {errors: @bomb.errors}
  	end
  end

# ==================================================

  def start_time
    session[:start_time] ||= (Time.now).to_s
  end

  run! if app_file == $0
end
