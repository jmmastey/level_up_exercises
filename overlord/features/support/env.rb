require_relative './../../overlord.rb'

require 'capybara/poltergeist'
require 'capybara'
require 'capybara/cucumber'
require 'rspec'

Capybara.app = Sinatra::Application
Capybara.javascript_driver = :poltergeist
Capybara.default_driver = :poltergeist

class OverlordWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers
end

World do
  OverlordWorld.new
end
