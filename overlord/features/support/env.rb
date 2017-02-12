require File.join(File.dirname(__FILE__), '..', '..', 'overlord.rb')

require 'Capybara'
require 'Capybara/cucumber'
require 'rspec'

Capybara.app = Sinatra::Application

class OverLordWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers
end

World do
  OverLordWorld.new
end
