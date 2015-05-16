require 'sinatra'
require 'json'
require 'pry'
require './bomb'

class Overlord < Sinatra::Base
  enable :sessions

  get '/?:activation_code?/?:deactivation_code?' do
    if params.key?(:activation_code) && params.key?(:deactivation_code)
      session[:bomb] = Bomb.new(params[:activation_code], params[:deactivation_code])
    else
      session[:bomb] = Bomb.new
    end
    erb :index, locals: {
      bomb_status: session[:bomb].status,
    }
  end

  post '/security' do
    submit_code(params[:code])
    response = { bomb_status: session[:bomb].status }
    if session[:bomb].error_count > 0
      response[:error_count] = session[:bomb].error_count
    end
    JSON.generate(response)
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
