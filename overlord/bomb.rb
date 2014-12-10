require 'sinatra/base'
require 'pry'
require 'json'

class Bomb < Sinatra::Base
  configure(:development) { set :session_secret, 'something' }
  enable :sessions

  get '/' do
    session[:state] = :not_booted
    erb :index
  end

  post '/boot' do
    session[:state] = :not_activated
    session[:wrong_code_count] = 0
    set_activate_code(params['activation-code'])
    set_deactivate_code(params['deactivation-code'])
    erb :bomb

  end

  post '/submit_code' do
    return 'exploded' unless session[:state] != :exploded
    method_name = "#{params[:code_type].downcase}_bomb".to_sym
    result = send(method_name, params[:code])
    { result: result, bomb_state: format_string(session[:state]) }.to_json
  end

  get '/detonate' do
    session[:state] = :exploded
    erb :boom
  end

  private

  def activate_bomb(code)
    return unless session[:activation_code] == code
    session[:state] = :activated
    true
  end

  def deactivate_bomb(code)
    unless session[:deactivation_code] == code
      increment_wrong_deactivation_code_count
      return false
    end
    session[:state] = :deactivated
    true
  end

  def increment_wrong_deactivation_code_count
    session[:wrong_code_count] += 1
    session[:state] = :exploded unless session[:wrong_code_count] < 3
  end

  def set_activate_code(code)
    session[:activation_code] = validated_code(code) || '1234'
  end

  def set_deactivate_code(code)
    session[:deactivation_code] = validated_code(code) || '0000'
  end

  def validated_code(code)
    code if !code.nil? && !code.empty?
  end
  
  def format_string(sym_state)
    sym_state.to_s.sub('_', ' ')
  end
  run! if app_file == $0
end
