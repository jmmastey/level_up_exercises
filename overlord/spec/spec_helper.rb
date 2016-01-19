require 'simplecov'
SimpleCov.start

require "sinatra"
require "sinatra/base"
require "rack/test"
require "pry"


# helpers

# app
require_relative '../overlord.rb'
require_relative "../lib/models/bomb.rb"
require_relative "../lib/models/timer.rb"
require_relative "../lib/models/wire.rb"
require_relative "../lib/models/wire_bundle.rb"

def app
	Overlord.new
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
end