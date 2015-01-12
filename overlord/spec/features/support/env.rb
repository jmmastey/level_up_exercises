require './app'
require 'capybara'
require 'capybara/cucumber'
require 'rspec'

module OverlordTest
  Capybara.app = Overlord
  include RSpec::Matchers
  include Capybara::DSL
end
