require "Capybara"
require "Capybara/cucumber"
require "rspec"

DatabaseCleaner.clean_with(:truncation) # clean once, now
DatabaseCleaner.strategy = :transaction
Cucumber::Rails::Database.javascript_strategy = :deletion

RSpec.configure do |c|
  c.include(Capybara::DSL, feature: true)
  c.include(Capybara::RSpecMatchers, feature: true)
end

Capybara.default_driver = :selenium

# Selenium::WebDriver::Chrome::Service.class_eval do
#   def stop
#     #STDOUT.puts "#{self.class}#stop: no-op"
#   end
# end
#
# Capybara::Selenium::Driver.class_eval do
#   def reset!
#   end
# end
