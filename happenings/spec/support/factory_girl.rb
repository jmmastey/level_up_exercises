# RSpec
# spec/support/factory_girl.rb
require 'factory_girl'




RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  factory_girl_results = {}
  config.before(:suite) do
      begin
        DatabaseCleaner.start
        # FactoryGirl.lint
      ensure
        DatabaseCleaner.clean
      end

      ActiveSupport::Notifications.subscribe("factory_girl.run_factory") do
      |payload|
        factory_name = payload
        strategy_name = payload
        factory_girl_results[factory_name] ||= {}
        factory_girl_results[factory_name][strategy_name] ||= 0
        factory_girl_results[factory_name][strategy_name] += 1
      end
    # additional factory_girl configuration
  end

  config.after(:suite) do
    puts factory_girl_results
  end
end

# Test::Unit
# class Test::Unit::TestCase
#   include FactoryGirl::Syntax::Methods
# end

# Cucumber
# World(FactoryGirl::Syntax::Methods)
