# run `ruby overlord.rb` to run a webserver for this app

require_relative 'lib/models/bomb'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'tilt'
require 'active_record'

Tilt.register Tilt::ERBTemplate, 'html.erb'

class Overlord < Sinatra::Base
  enable :sessions

  get '/' do
    @bomb = session[:bomb]
    if @bomb
      erb @bomb.state
    else
      erb :index
    end
  end

  post '/initialize' do
    act_code = params["actcode"].empty? ? "1234" : params["actcode"]
    deact_code = params["deactcode"].empty? ? "0000" : params["deactcode"]
    session[:bomb] = Bomb.new(act_code, deact_code)
    redirect '/'
  end

  post '/activate' do
    @bomb = session[:bomb]
    @bomb.enter_code(params["actcode"])
    if @bomb.state == :active
      redirect '/'
    else
      @error = "You failed to activate the bomb."
      erb :inactive
    end
  end

  post '/deactivate' do
    @bomb = session[:bomb]
    @bomb.enter_code(params["deactcode"])
    if @bomb.state == :inactive
      redirect '/'
    else
      @error = "Wrong deactivation code"
      redirect '/'
    end
  end

  def start_time
    session[:start_time] ||= (Time.zone.now).to_s
  end

  run! if app_file == $PROGRAM_NAME
end
