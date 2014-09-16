require 'rack/test'
require 'rspec'

require File.expand_path '../../app/overlord.rb', __FILE__
# require_relative '../app/helpers/init'
require File.expand_path '../support/request_helpers.rb', __FILE__

ENV['RACK_ENV'] = 'test'

module RSpecMixin
  include Rack::Test::Methods
  def app
    Overlord
  end
end

RSpec.configure do |config|
  config.include RSpecMixin
  config.include Requests::JsonHelpers
end
