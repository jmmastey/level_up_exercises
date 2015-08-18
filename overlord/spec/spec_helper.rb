require "simplecov"
SimpleCov.start

require_relative "../lib/bomb.rb"
require_relative "../lib/timer.rb"
require_relative "../lib/wire.rb"
require_relative "../lib/wire_bundle.rb"

RSpec.configure do |config|
  config.before(:each, js: true) do
    page.driver.allow_url("maxcdn.bootstrapcdn.com")
    page.driver.allow_url("code.jquery.com")
  end
end
