require 'sinatra'
require './bomb'
require './bomb_form_text'
require 'pry'
require './bomb_form_errors'

class Overlord < Sinatra::Base
  attr_accessor :errors

  configure do
    enable :sessions
  end

  get '/' do
    start_time
    @bomb = bomb
    erb :bomb_form
  end

  post '/' do
    if params['code'].empty?
      self.errors = BombFormErrors.no_code
    else
      bomb.process_code(params['code'])
    end
    redirect '/'
  end

  def start_time
    session[:start_time] ||= (Time.now).to_s
  end

  def bomb
    session[:bomb] ||= Bomb.new
  end

  def errors=(new_error)
    @errors ||= []
    @errors << new_error
  end
end
