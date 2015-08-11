ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', '..', 'overlord.rb')

require 'capybara'
require 'capybara/cucumber'
require 'rspec'
require 'capybara/rspec'

World do
  Capybara.app = Sinatra::Application.new
end

RSpec.configure do |c|
  c.include Capybara::DSL, feature: true
  c.include Capybara::RSpecMatchers, feature: true
end

Capybara.default_driver = :selenium
