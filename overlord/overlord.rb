#!/usr/bin/env ruby

require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'

require 'tilt/haml'

require_relative 'overlord_helpers'
require_relative 'app/models/trigger'

module Project
  class Overlord < Sinatra::Base
    register Sinatra::Reloader
    register Sinatra::Flash

    helpers OverlordHelpers

    attr_reader :trigger

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

      redirect to('/trigger')
    end

    get '/trigger' do
      @trigger = session[:trigger] || provide_trigger
      session[:trigger] = @trigger
      haml :trigger
    end

    get '/enter/:code?' do
      @trigger = session[:trigger]

      if trigger.valid?(params[:code])
        trigger_bomb_state(trigger)
      else
        flash[:invalid_code] = 'The code must be four numeric characters.'
      end

      redirect to('/trigger')
    end
  end
end

Project::Overlord.run! port: 9292 if __FILE__ == $PROGRAM_NAME
