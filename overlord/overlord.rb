# run `ruby overlord.rb` to run a webserver for this app
require 'sinatra'
require 'sinatra/base'
require 'sinatra/assetpack'
require 'json'

require_relative './bomb.rb'

class Overlord < Sinatra::Base
  enable :sessions

  register Sinatra::AssetPack
  assets do
    js :application, ['/js/jquery-2.1.4.min.js', '/js/timer.js', '/js/*.js']
    css :application, ['/css/*.css']
    js_compression :jsmin
    css_compression :scss
  end

  get '/' do
    erb :index
  end

  post '/bomb/reset' do
    reset_bomb
  end

  post '/activation/set/?:code?' do
    bomb.activation_code.set params[:code]
    render_activation_status
  end

  post '/deactivation/set/?:code?' do
    bomb.deactivation_code.set params[:code]
    render_deactivation_status
  end

  post '/activation/check/?:code?' do
    bomb.activation_code.check params[:code]
    render_activation_status
  end

  post '/deactivation/check/?:code?' do
    bomb.deactivation_code.check params[:code]
    render_deactivation_status
  end

  %w(jpg png).each do |format|
    get "/assets/:image.#{format}" do |image|
      content_type("image/#{format}")
      settings.assets["#{image}.#{format}"]
    end
  end

  def bomb
    session[:bomb]
  end

  def reset_bomb
    session[:bomb] = Bomb.new
  end

  def render_json(hash)
    content_type :json
    hash.to_json
  end

  def render_activation_status
    render_json bomb.activation_code.status
  end

  def render_deactivation_status
    render_json bomb.deactivation_code.status
  end
end
