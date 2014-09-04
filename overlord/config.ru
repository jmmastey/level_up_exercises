require 'rubygems'
require File.join(File.dirname(__FILE__), 'lib/overlord.rb')
use Rack::Static, :urls => %w(/css /js /fonts), :root => 'public'
# use Rack::Static :urls => %w(/angular /angular-resource /angular-route /jquery /sprintf /bootstrap), :root => 'bower_components'

run Overlord