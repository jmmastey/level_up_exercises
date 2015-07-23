# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require 'json'
require_relative 'lib/bomb'

class Overlord < Sinatra::Base
  enable :sessions

  set :public_folder, File.dirname(__FILE__) + '/public'

  # All methods except GET send content_type application/json
  before do
    unless request.request_method.eql?('GET')
      parameters = request.body.read
      return unless parameters.length > 2
      params.merge!(JSON.parse(parameters))
    end
  end

  get '/' do
    erb :home,
        layout: 'layouts/main'.to_sym,
        locals: { bomb: session[:bomb] }
  end

  get '/bomb' do
    content_type :json
    session[:bomb].explode if session[:bomb].exploded?
    bomb_to_json
  end

  post '/bomb' do
    content_type :json
    bomb = Bomb.new(params[:activation_code], params[:deactivation_code])
    if bomb.valid?
      session[:bomb] = bomb
      return bomb_to_json
    end
    error
  end

  delete '/bomb' do
    session.delete(:bomb)
  end

  post '/bomb/activate' do
    content_type :json

    bomb = session[:bomb]

    return error if bomb.active?

    if bomb.correct_activation_code?(params[:activation_code])
      bomb.activate
      {
        status: session[:bomb].status,
        timer: session[:bomb].timer,
        pin: session[:bomb].explode_pin,
      }.to_json
    else
      error
    end
  end

  post '/bomb/deactivate' do
    content_type :json

    bomb = session[:bomb]
    if bomb.correct_deactivation_code?(params[:deactivation_code])
      bomb.deactivate
      bomb_to_json
    else
      bomb.increment_deactivation_code_attempts
      bomb.explode if bomb.reached_deactivation_attempt_limit?
      error
    end
  end

  post '/bomb/explode' do
    content_type :json
    bomb = session[:bomb]

    bomb.explode if bomb.correct_explode_pin?(params[:explode_pin])
    bomb_to_json
  end

  def error(type = true)
    { error: type }.to_json
  end

  def bomb_to_json
    {
      status: session[:bomb].status,
      timer: session[:bomb].timer,
    }.to_json
  end
end
