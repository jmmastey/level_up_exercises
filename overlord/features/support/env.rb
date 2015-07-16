require 'capybara'
require 'capybara/cucumber'

require_relative '../../overlord'

Capybara.app = Project::Overlord
