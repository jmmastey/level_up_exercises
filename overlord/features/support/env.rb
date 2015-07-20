require 'capybara/cucumber'
require 'capybara/dsl'
require 'capybara/rspec'
require 'capybara-screenshot/cucumber'
require 'capybara-screenshot/rspec'
require 'capybara/poltergeist'

require_relative '../../overlord'


Capybara.app = Overlord.new
Capybara.javascript_driver = :poltergeist

After do |s|
  # Tell Cucumber to quit after this scenario is done - if it failed.
  Cucumber.wants_to_quit = true if s.failed?
end
