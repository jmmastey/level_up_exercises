#!/usr/bin/env ruby

require 'sinatra/base'
require 'sinatra/reloader'

require 'tilt/haml'

require_relative 'app/models/trigger'

module Project
  class Overlord < Sinatra::Base
    register Sinatra::Reloader

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

    get '/enter/:code' do
      @trigger = session[:trigger]

      if trigger.deactivated?
        trigger.activate(params[:code])
      else
        trigger.deactivate(params[:code])
      end

      redirect to('/')
    end
  end
end

Project::Overlord.run! port: 9292 if __FILE__ == $PROGRAM_NAME
