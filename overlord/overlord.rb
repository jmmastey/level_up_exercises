# run `ruby overlord.rb` to run a webserver for this app
require 'sinatra'
require 'sinatra/base'
require 'sinatra/assetpack'

class Overlord < Sinatra::Base
  enable :sessions

  register Sinatra::AssetPack
  assets do
    js  :application, [ '/js/jquery-2.1.4.min.js', '/js/*.js' ]
    css :application, [ '/css/*.css' ]
    js_compression :jsmin
    css_compression :scss
  end

  get '/' do
    @start_time = start_time
    erb :index
  end

  def start_time
    session[:start_time] ||= (Time.now).to_s
  end
end
