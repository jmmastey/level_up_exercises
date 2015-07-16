#!/usr/bin/env ruby

require 'sinatra'

configure { set :server, :puma }

enable :sessions

get '/' do
  'Time to build an app around here. Start time: ' + start_time
end

def start_time
  session[:start_time] ||= (Time.now).to_s
end
