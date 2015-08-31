require_relative './../../overlord.rb'

require 'selenium-webdriver'
require 'capybara'
require 'capybara/cucumber'
require 'rspec'

Capybara.app = Sinatra::Application
Capybara.default_driver = :selenium

class OverlordWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers
end

World do
  OverlordWorld.new
end
