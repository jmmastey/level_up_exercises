require 'sinatra/base'
require 'Haml'
require_relative 'bomb'
require 'pry'

class Overlord < Sinatra::Base
  enable :sessions

  get '/' do
    session[:comment_text] = 'Bomb is inactive - configure codes'
    haml :index
  end

  post '/bomb' do
    @set_activecode = params[:set_activation_code]
    @set_deactivecode = params[:set_deactivation_code]
    begin
      session[:bomb] = Bomb.new(@set_activecode, @set_deactivecode)
      session[:comment_text] = ''
      haml :detonator
    rescue ArgumentError
      session[:comment_text] = 'Enter only numeric values.'
      haml :index
    end
  end

  post '/activate' do
    @detonatecode = params[:activation_code]
    session[:bomb].activate?(@detonatecode)
    session[:comment_text] = ''
    if session[:bomb].active
      session[:bomb].start_time
      session[:comment_text] = session[:bomb].message
    else
      session[:comment_text] = 'Incorrect activation code'
    end
    haml :detonator
  end

  post '/deactivate' do
    @deactivatecode = params[:deactivation_code]
    session[:bomb].deactivate(@deactivatecode)
    session[:bomb].check_time
    if !session[:bomb].active && !session[:bomb].exploded
      session[:comment_text] = ''
      redirect '/'
    else
      session[:comment_text] = session[:bomb].message
      haml :detonator
    end
  end

  run! if app_file == $0
end
