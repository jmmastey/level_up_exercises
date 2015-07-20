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
      @trigger = session[:trigger] || Trigger.new
      session[:trigger] = @trigger
      haml :index
    end

    get '/enter/:code?' do
      @trigger = session[:trigger]

      if trigger.valid?(params[:code])
        trigger_bomb_state(trigger)
      else
        flash[:invalid_code] = 'The code must be four numeric characters.'
      end

      redirect to('/')
    end
  end
end

Project::Overlord.run! port: 9292 if __FILE__ == $PROGRAM_NAME
