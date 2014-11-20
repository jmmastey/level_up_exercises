# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require 'capybara/rspec'
require_relative 'bomb'

class Overlord < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions

  get '/' do
    erb :index
  end

  post '/boot' do
    user_activation_code = params['activation-code']
    user_deactivation_code = params['deactivation-code']
    bomb = Bomb.new(activation_code: user_activation_code, deactivation_code: user_deactivation_code)
    redirect '/bomb'
  end

  get '/bomb' do
    #erb :bomb, locals: { bomb_state: 'inactive' }
    #"Time to build an app around here. Start time: " + start_time
  end

  post '/bomb' do
    user_code = params['code'].to_i
    status = :inactive
    status = check_user_code(user_code)

    erb :bomb, locals: { bomb_state: status }
    # see if the code matches the activation code or deactivation code
    # if it matches activation code, activate the bomb
  end

  # we can shove stuff into the session cookie YAY!
  def start_time
    session[:start_time] ||= (Time.now).to_s
  end

  not_found do
    erb :error
  end

  #@start_time = start_time
end
