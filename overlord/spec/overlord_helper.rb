require_relative "spec_helper"
require_relative "../overlord"
require "rack/test"
require "rspec"

ENV['RACK_ENV'] = 'test'

module OverlordSinatra
  include Rack::Test::Methods
  def app
   Overlord
  end

  def parse_response(response)
    JSON.parse(response, symbolize_names: true)
  rescue JSON::JSONError
    false
  end
end

RSpec.configure do |config|
  config.include OverlordSinatra
end
