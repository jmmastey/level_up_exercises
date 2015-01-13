require 'sinatra'
require_relative 'bomb'
require_relative 'bomb_form_text'
require 'pry'

class Overlord < Sinatra::Base
  configure do
    enable :sessions
  end

  get '/' do
    start_time
    @bomb = bomb
    erb :bomb_form
  end

  post '/' do
    bomb.process_code(params['code'])
    redirect '/'
  end

  def start_time
    session[:start_time] ||= (Time.now).to_s
  end

  def bomb
    session[:bomb] ||= Bomb.new
  end
end
