# run `ruby overlord.rb` to run a webserver for this app
require 'sinatra'
require 'sinatra/base'
require 'sinatra/assetpack'
require 'json'

class Overlord < Sinatra::Base
  enable :sessions

  register Sinatra::AssetPack
  assets do
    js  :application, [ '/js/jquery-2.1.4.min.js', '/js/timer.js', '/js/*.js' ]
    css :application, [ '/css/*.css' ]
    js_compression :jsmin
    css_compression :scss
  end

  get '/' do
    erb :index
  end

  post '/reset-bomb' do
    reset_bomb
  end

  post '/activation/set/:code' do
    is_success = session[:bomb].activation_code.set params[:code]
    render_is_success_json is_success
  end

  post '/deactivation/set/:code' do
    is_success = session[:bomb].deactivation_code.set params[:code]
    render_is_success_json is_success
  end

  post '/activation/check/:code' do
    is_success = session[:bomb].activation_code.is? params[:code]
    render_is_success_json is_success
  end

  post '/deactivation/check/:code' do
    is_success = session[:bomb].deactivation_code.is? params[:code]
    render_is_success_json is_success
  end

  %w{jpg png}.each do |format|
    get "/assets/:image.#{format}" do |image|
      content_type("image/#{format}")
      settings.assets["#{image}.#{format}"]
    end
  end

  def reset_bomb 
    session[:bomb] = Bomb.new
  end

  def render_json(hash)
    content_type :json
    hash.to_json
  end

  def render_is_success_json(is_success)
    render_json { is_success: is_success }
  end
end
