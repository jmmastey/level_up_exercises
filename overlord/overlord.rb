#!/usr/bin/env ruby

require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'

require 'tilt/haml'

require_relative 'overlord_helpers'
require_relative 'app/models/bomb'
require_relative 'app/models/trigger'
require_relative 'app/models/timer'

module Project
  class Overlord < Sinatra::Base
    register Sinatra::Reloader
    register Sinatra::Flash

    helpers OverlordHelpers

    configure { set :server, :puma }
    enable :sessions
    set :views, 'app/views'
    set :haml, format: :html5

    get '/' do
      haml :index
    end

    post '/' do
      session[:activate] = params[:activation_code]
      session[:deactivate] = params[:deactivation_code]
      session[:countdown] = params[:countdown_value]

      redirect to('/bomb')
    end

    post '/set/:seconds' do
      @bomb = session[:bomb]
      timer.reset(params[:seconds].to_i)
    end

    get '/bomb' do
      @bomb = session[:bomb] || provide_bomb
      session[:bomb] = @bomb
      haml :bomb
    end

    get '/enter/:code?' do
      @bomb = session[:bomb]

      if trigger.valid?(params[:code])
        trigger_bomb_state(trigger, timer)
      else
        flash[:invalid_code] = 'The code must be four numeric characters.'
      end

      redirect to('/bomb')
    end

    def trigger
      @bomb.components[:trigger]
    end

    def timer
      @bomb.components[:timer]
    end
  end
end

Project::Overlord.run! port: 9292 if __FILE__ == $PROGRAM_NAME
