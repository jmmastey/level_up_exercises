require 'sinatra/base'
require "pry"
require_relative "models/bomb"

class Overlord < Sinatra::Base
  enable :sessions

  before '/bomb/*' do
    if bomb_exploded?
      redirect "/exploded"
    end
  end

  get '/' do
    erb :new_bomb
  end

  post '/bomb' do
    @bomb = bomb(params[:bomb])
    redirect "/bomb/inactive"
  end

  get '/bomb/inactive' do
    @bomb = bomb
    # I could just pass in the bomb object, but I like
    # the explicitness of this code better - I think it makes
    # clearer what info the view uses, which i find useful
    @activate_errors = bomb.errors[:activate_errors]
    @deactived_status = bomb.errors[:deactivate_status]
    erb :inactive_bomb
  end

  post '/bomb/activate' do
    @bomb = bomb
    bomb.activate(params[:activation_code])
    if bomb.active?
      bomb.start_timer
      bomb.errors[:activate_errors] = nil
      redirect "bomb/active"
    else
      bomb.errors[:activate_errors] = "Incorrect code - bomb not active"
      redirect '/bomb/inactive'
    end
  end

  get '/bomb/active' do
    @bomb = bomb
    @deactivate_error = bomb.errors[:deactivate_error]
    
    @attempts = bomb.deactivation_attempts
    bomb.errors[:incorrect_deactivate_attempts]

    erb :active_bomb
  end 

  post '/bomb/deactivate' do
    @bomb = bomb
    bomb.deactivate(params[:deactivation_code])
    if @bomb.active?
      # The problem with these methods is that they don't
      # tell me what is being done. Should I care?
      # Should I name the method better?
      bomb.bad_deactivation_attempt
      redirect "/bomb/active"
    else
      bomb.deactivation_sequence
      redirect '/bomb/inactive'
    end
  end

  get "/exploded" do
    "<h1>Everyone's dead</h1> <br> <h2>It's a cold world.</h2>"
  end

# ==================================================

  def bomb(options = {})
    session[:bomb] ||= Bomb.new(options)
  end

  def bomb_exploded?()
    bomb.too_many_deactivation_attempts? || bomb.timer_ended?
  end

  run! if app_file == $0
end
