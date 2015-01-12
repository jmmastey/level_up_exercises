require 'sinatra/base'
require './app'

run Rack::Cascade.new [Overlord]