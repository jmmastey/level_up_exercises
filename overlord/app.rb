require 'sinatra'
require 'active_support/all'
require './bomb'
require './bomb_form_text'
require 'pry'
require './bomb_form_errors'
include BombFormErrors

class Overlord < Sinatra::Base
  # attr_accessor :errors

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
      process_code
    else
      process_configuration
    end
  end

  def process_configuration
    process_activate_code
    process_deactivate_code
    unless errors.any?
      bomb.configured = true
    end
    binding.pry
  end

  def process_activate_code
    begin
      if params['activate_code'].present?
        bomb.activate_code = params['activate_code']
      end
    rescue BombError => error
      errors << error.message
    end
  end

  def process_deactivate_code
    begin
      if params['deactivate_code'].present?
        bomb.deactivate_code = params['deactivate_code']
      end
    rescue BombError => error
      errors << error.message
    end
  end

  def process_code
    if params['code'].present?
      bomb.process_code(params['code'])
    else
      errors << BombFormErrors.no_code
    end
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
