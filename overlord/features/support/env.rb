require File.join(File.expand_path(File.dirname(__FILE__)),'../../overlord')

require "rspec"
require "Capybara"
require"Capybara/cucumber"

Capybara.app = Sinatra::Application

World do
  include Capybara::DSL
  include RSpec::Matchers
end
