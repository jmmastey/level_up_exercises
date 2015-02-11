require 'rack/test'
require 'rspec'
require 'pry'
require 'faker'
require 'simplecov'
require './overlord.rb'

SimpleCov.start

Dir["./spec/support/**/*.rb"].sort.each { |f| require f }

# set test environment
Sinatra::Base.set :environment, :test
Sinatra::Base.set :run, false
Sinatra::Base.set :raise_errors, true
Sinatra::Base.set :logging, true

DataMapper.setup(:default, "sqlite::memory")

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    # be_bigger_than(2).and_smaller_than(4).description
    #   # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #   # => "be bigger than 2"
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end

  config.include Helpers::RSpecMixin

  # Let's clean the database here cause Svajone
  # likes it clean.
  config.before(:each) do
    DataMapper.auto_migrate!
  end

  config.include Helpers::StateMachine
  config.include Helpers::Session

  begin
    config.filter_run :focus
    config.run_all_when_everything_filtered = true

    config.disable_monkey_patching!

    config.warnings = false

    if config.files_to_run.one?
      config.default_formatter = 'doc'
    end

    config.profile_examples = 10

    config.order = :random

    Kernel.srand config.seed
  end
end
