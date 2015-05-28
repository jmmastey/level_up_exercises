require 'sinatra'
require 'json'
require 'pry'
require './bomb'

class Overlord < Sinatra::Base
  enable :sessions

  get '/?:activation_code?/?:deactivation_code?' do
    session[:bomb] = create_bomb(params)
    erb :index, locals: {
      bomb_status: session[:bomb].status,
    }
  end

  post '/security' do
    submit_code(params[:code])
    response = { bomb_status: session[:bomb].status }
    response[:error_count] = session[:bomb].error_count
    response.to_json
  end

  def create_bomb(params)
    if params.key?(:activation_code) && params.key?(:deactivation_code)
      return Bomb.new(params[:activation_code], params[:deactivation_code])
    else
      return Bomb.new
    end
  end

  def submit_code(code)
    case session[:bomb].status
    when 'active'
      session[:bomb].deactivate(code)
    when 'inactive'
      session[:bomb].activate(code)
    end
  end
end
