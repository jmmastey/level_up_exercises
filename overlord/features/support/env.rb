require File.join(File.dirname(__FILE__), '..', '..', 'overlord.rb')

require 'Capybara'
require 'Capybara/cucumber'
require 'rspec'

Capybara.app = Sinatra::Application
Capybara.default_driver = :selenium

class OverLordWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers
end

World do
  OverLordWorld.new
end

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end
