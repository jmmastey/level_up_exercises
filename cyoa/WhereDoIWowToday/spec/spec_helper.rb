require 'webmock/rspec'
require 'devise'

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include WebMock::API
  config.include Devise::TestHelpers, type: :controller
end
