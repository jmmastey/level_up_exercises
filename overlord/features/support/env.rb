require_relative "../../overlord.rb"
require "Capybara"
require "Capybara/cucumber"
require "capybara/poltergeist"
require "rspec"

World do
  Capybara.app = Sinatra::Application.new
end

Capybara.default_driver = :poltergeist
Capybara.register_driver :poltergeist do |app|
    options = {
        :js_errors => true,
        :timeout => 120,
        :debug => false,
        :phantomjs_options => ['--load-images=no', '--disk-cache=false'],
        :inspector => true,
    }
    Capybara::Poltergeist::Driver.new(app, options)
end

RSpec.configure do |c|
  c.include Capybara::DSL, feature: true
  c.include Capybara::RSpecMatchers, feature: true
end