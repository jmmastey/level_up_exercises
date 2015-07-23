require 'capybara'
require 'capybara/cucumber'
require 'capybara/poltergeist'
require 'site_prism'

require_relative '../../overlord'

Capybara.app = Project::Overlord
# Capybara.javascript_driver = :poltergeist
Capybara.javascript_driver = :selenium
