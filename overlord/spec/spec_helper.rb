require "simplecov"
SimpleCov.start

require_relative "../lib/bomb"
require_relative "../lib/timer"
require_relative "../lib/wire"
require_relative "../lib/wire_bundle"

RSpec.configure do |config|
  config.before(:each, js: true) do
    page.driver.allow_url("maxcdn.bootstrapcdn.com")
    page.driver.allow_url("code.jquery.com")
  end
end
