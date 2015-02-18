ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), *%w[.. .. .. overlord.rb])

require 'capybara'
require 'capybara-webkit'
require 'capybara/cucumber'
require 'rspec'
require 'faker'

Capybara.configure do |config|
  config.app = Overlord
  config.default_driver = :webkit
end

DataMapper.setup(:default, "sqlite::memory")

class OverlordWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers

  DataMapper.auto_migrate!
end

World do
  OverlordWorld.new
end
