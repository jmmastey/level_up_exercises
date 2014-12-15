require "database_cleaner"
require "rspec/rails"

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:example) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
