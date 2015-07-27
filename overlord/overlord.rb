# run `ruby overlord.rb` to run a webserver for this app
require 'sinatra'
require 'sinatra/base'
require 'sinatra/assetpack'

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
    @start_time = start_time
    erb :index
  end

  %w{jpg png}.each do |format|
    get "/assets/:image.#{format}" do |image|
      content_type("image/#{format}")
      settings.assets["#{image}.#{format}"]
    end
  end

  def start_time
    session[:start_time] ||= (Time.now).to_s
  end
end
