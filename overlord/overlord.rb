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
    bomb_count = session[:bomb].nil? ? 0 : 1
    { count: bomb_count }.to_json
  end

  post '/bomb' do
    content_type :json
    bomb = Bomb.new(params[:activation_code], params[:deactivation_code])
    if bomb.valid?
      session[:bomb] = bomb
      return bomb_to_json
    end
    { error: true }.to_json
  end

  delete '/bomb/delete' do
    session.delete(:bomb)
  end

  def bomb_to_json
    {
      status: session[:bomb].status,
      timer: session[:bomb].timer,
    }.to_json
  end
end
