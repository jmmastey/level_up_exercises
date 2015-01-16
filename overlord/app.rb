require 'sinatra'
require 'active_support/all'
require './bomb'
require './bomb_form_text'
require 'pry'
require './bomb_form_errors'
include BombFormErrors

class Overlord < Sinatra::Base
  configure do
    enable :sessions
  end

  get '/' do
    start_time
    @errors = errors
    @bomb = bomb
    erb :bomb_form
  end

  post '/' do
    clear_previous_errors
    process_page
    redirect '/'
  end

  def process_page
    if bomb.configured?
      process_code_if_present
    else
      process_configuration
    end
  end

  def process_configuration
    process_activate_code_if_present
    process_deactivate_code_if_present
    bomb.configured = true unless errors.any?
  end

  def process_activate_code_if_present
    process_activate_code if params['activate_code'].present?
  end

  def process_activate_code
    bomb.activate_code = params['activate_code']
    rescue BombError => error
      errors << error.message
  end

  def process_deactivate_code_if_present
    process_deactivate_code if params['deactivate_code'].present?
  end

  def process_deactivate_code
    bomb.deactivate_code = params['deactivate_code']
    rescue BombError => error
      errors << error.message
  end

  def process_code_if_present
    if params['code'].present?
      process_code
    else
      errors << BombFormErrors.no_code
    end
  end

  def process_code
    bomb.process_code(params['code'])
    rescue BombError => error
      errors << error.message
  end

  def start_time
    session[:start_time] ||= (Time.now).to_s
  end

  def bomb
    session[:bomb] ||= Bomb.new
  end

  def clear_previous_errors
    session[:errors] = []
  end

  def errors
    session[:errors] ||= []
  end
end
