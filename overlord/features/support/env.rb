require "capybara/cucumber"
require "rspec/expectations"

require_relative "../../src/overlord_app"

path = File.expand_path(File.dirname(__FILE__) + '/../../src/**')

Dir[path].each { |file| require file }

Capybara.app = Overlord
