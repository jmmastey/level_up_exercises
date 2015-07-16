#!/usr/bin/env ruby

require 'sinatra/base'
require 'sinatra/reloader'

module Project
  class Overlord < Sinatra::Base
    register Sinatra::Reloader

    configure { set :server, :puma }
    enable :sessions
    set :views, 'app/views'
    set :haml, format: :html5

    get '/' do
      haml :index
    end

    def start_time
      session[:start_time] ||= (Time.now).to_s
    end
  end
end

Project::Overlord.run! port: 9292 if __FILE__ == $PROGRAM_NAME
