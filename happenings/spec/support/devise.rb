require_relative 'controller_macros'
require_relative 'factory_girl'
RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.extend ControllerMacros, type: :controller

  config.include Devise::TestHelpers, type: :view
end
