require_relative '../../overlord'

require 'capybara'
require 'capybara-webkit'
require 'capybara/cucumber'
require 'pry'
require 'tilt/erb'

World do
  Capybara.app = Overlord
end
