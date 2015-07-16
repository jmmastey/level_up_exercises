#!/usr/bin/env ruby

require 'sinatra/base'
require 'sinatra/reloader'

module Project
  class Overlord < Sinatra::Base
    register Sinatra::Reloader

    configure { set :server, :puma }
    enable :sessions

    get '/' do
      'Time to build an app around here. Start time: ' + start_time
    end

    def start_time
      session[:start_time] ||= (Time.now).to_s
    end
  end
end

Project::Overlord.run! port: 9292 if __FILE__ == $PROGRAM_NAME
