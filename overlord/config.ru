require 'rubygems'
require 'yaml'
require 'bundler/setup'
require 'sinatra'
require 'haml'
require './app/overlord'

set :environment, :development
set :run, false
set :raise_errors, true

run Overlord.new