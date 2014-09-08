require 'rubygems'
require 'bundler'
require File.join(File.dirname(__FILE__), 'app/overlord.rb')

Bundler.require(:default, :development)

# root = ::File.dirname(__FILE__)
# require ::File.join( root, 'app' )
# run MyApp.new


use Rack::Static, :urls => %w(/css /js /fonts /partials), :root => 'public'
# use Rack::Static :urls => %w(/angular /angular-resource /angular-route /jquery /sprintf /bootstrap), :root => 'bower_components'
run Overlord.new