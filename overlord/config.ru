require 'rubygems'
require 'yaml'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/sprockets'
require 'haml'
require File.join(File.dirname(__FILE__), 'app/overlord.rb')
require 'data_mapper'
require './app/overlord'

set :environment, :development
set :run, false
set :raise_errors, true

map "/#{Sinatra::Sprockets.config.prefix}" do
  run Sinatra::Sprockets.environment
end
run Overlord.new