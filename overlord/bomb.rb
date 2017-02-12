require 'sinatra/base'
require 'pry'
require 'json'

class Bomb < Sinatra::Base
  configure(:development) { set :session_secret, 'something' }
  enable :sessions

  get '/' do
    session[:state] = "Not boot"
    erb :index
  end
  
  get '/boot' do
    session[:state] = 'Not Activate'
    session[:wrong_code_count] = 0
    set_activate_code(params[:activation_code])
    set_deactivate_code(params[:deactivation_code])
    erb :bomb

  end
 
  post '/submit_code' do
    method_name = "#{params[:button_text].downcase}_bomb".to_sym
    result = send(method_name, params[:code])
    {result: result, bomb_state: session[:state] }.to_json
  end 
  
  get '/detonate' do
    session[:state] = 'Exploded'
    erb :boom
  end

  private
  
  def is_bomb_boot?
    redirect '/' if session[:state] == 'Not boot'
  end

  def activate_bomb(code)
    valid_code = session[:activation_code] == code ? true : false
    session[:state] = 'Activated' if valid_code
    valid_code
  end

  def deactivate_bomb(code)
    valid_code = session[:deactivation_code] == code ? true : false
    if valid_code
      session[:state] = 'Deactivated'
    else
      increment_wrong_deactivation_code_count
    end
    valid_code
  end
  
  def increment_wrong_deactivation_code_count
    session[:wrong_code_count] += 1
    session[:state] = 'Exploded' unless session[:wrong_code_count] < 3
  end

  def set_activate_code(code)
    session[:activation_code] = (code.length == 0 ? '1234' : code)
  end

  def set_deactivate_code(code)
    session[:deactivation_code] = (code.length == 0 ? '0000' : code)
  end
  
  run! if app_file == $0
end
