require 'rubygems'
require 'yaml'
require 'bundler/setup'
require 'sinatra'
require 'haml'
require File.join(File.dirname(__FILE__), 'app/overlord.rb')
require 'data_mapper'
require './app/overlord'

set :environment, :development
set :run, false
set :raise_errors, true

run Overlord.new