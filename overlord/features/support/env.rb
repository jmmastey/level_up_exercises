require 'capybara'
require 'capybara/cucumber'
require 'site_prism'

require_relative '../../overlord'

Capybara.app = Project::Overlord
