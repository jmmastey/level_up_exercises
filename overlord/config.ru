require 'rubygems'
require 'bundler'
require File.join(File.dirname(__FILE__), 'lib/overlord.rb')

Bundler.require(:default, :development)


use Rack::Static, :urls => %w(/css /js /fonts /partials), :root => 'public'
# use Rack::Static :urls => %w(/angular /angular-resource /angular-route /jquery /sprintf /bootstrap), :root => 'bower_components'
run Overlord