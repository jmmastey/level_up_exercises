require 'capybara'
require 'capybara/cucumber'
require 'rspec'

require_relative '../../overlord'

Capybara.app = Overlord
