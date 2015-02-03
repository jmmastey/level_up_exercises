# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra/base'
require 'json'
require './model/interface.rb'

class Overlord < Sinatra::Base

  enable :sessions

  # root route
  get '/' do
    session[:interface] = Interface.new
    send_file './public/index.html'
  end

  # new bomb or activate bomb (power on the bomb)
  get '/bomb/new' do
    content_type :json
    if session[:interface].turn_on(params)
      { :success => :ok }.to_json
    else
      halt 500
    end
  end

  post '/bombs' do
    content_type :json

    if session[:interface].configure_settings(params)
      session[:interface].to_json
    else
      halt 500
    end
  end

  # we can shove stuff into the session cookie YAY!
  def start_time
    session[:start_time] ||= (Time.now).to_s
  end
end
