ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', '..', 'app/overlord.rb')
Dir[File.dirname(__FILE__) + '/helpers/*.rb'].each { |file| require file }

require 'capybara'
require 'capybara/cucumber'
require 'rspec'
require 'capybara/rspec'

Capybara.app = Overlord

class OverlordWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers
  include FormFillHelpers
end

World do
  OverlordWorld.new
end
