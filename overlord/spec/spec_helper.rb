require "simplecov"
require "capybara"
require 'capybara/dsl'
require 'capybara/poltergeist'
require 'capybara/webkit'

SimpleCov.start

require_relative "../lib/bomb.rb"
require_relative "../lib/timer.rb"
require_relative "../lib/wire.rb"
require_relative "../lib/wire_bundle.rb"

Capybara.configure do |config|
  config.javascript_driver = :webkit
  config.default_driver = :webkit
  config.app_host = 'http://localhost:4567'
end

