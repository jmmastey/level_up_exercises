require_relative "../../overlord"

require "Capybara"
require "Capybara/cucumber"
require "rspec"

Capybara.app = Overlord
Capybara.javascript_driver = :selenium

#World do
#  include Capybara::DSL
#  include RSpec::Matchers
#end
