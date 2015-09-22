require_relative "../../overlord"
require "Capybara"
require "Capybara/cucumber"
require "rspec"

World do
  Capybara.app = Sinatra::Application.new
end

RSpec.configure do |c|
  c.include(Capybara::DSL, feature: true)
  c.include(Capybara::RSpecMatchers, feature: true)
end

Capybara.default_driver = :selenium