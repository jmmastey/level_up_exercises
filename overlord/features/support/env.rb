require_relative '../../overlord'

require 'capybara'
require 'capybara/cucumber'
require 'capybara/poltergeist'
require 'pry'
require 'tilt/erb'

World do
  Capybara.javascript_driver = :poltergeist
  Capybara.app = Overlord
end
