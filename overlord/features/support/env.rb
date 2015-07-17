require "capybara/cucumber"
require "capybara/dsl"
require "capybara/rspec"
require 'capybara-screenshot/cucumber'
require 'capybara-screenshot/rspec'
require_relative "../../overlord"



Capybara.app = Overlord.new
Capybara.javascript_driver = :selenium
# Capybara.javascript_driver = :poltergeist

Before do |scenario|
  # The +scenario+ argument is optional, but if you use it, you can get the title,
  # description, or name (title + description) of the scenario that is about to be
  # executed.
  # Rails.logger.debug "Starting scenario: #{scenario.title}"
  Capybara.reset!
  # session.clear
end

After do |s|
  # Tell Cucumber to quit after this scenario is done - if it failed.
  Cucumber.wants_to_quit = true if s.failed?
end