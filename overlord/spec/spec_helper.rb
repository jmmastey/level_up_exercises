require 'rspec'
require 'rack/test'

require_relative '../app/overlord'
# require_relative '../app/helpers/init'

ENV["RAILS_ENV"] ||= 'test'

module RSpecMixin
  include Rack::Test::Methods
  def app
    Overlord
  end
end

# For RSpec 2.x
RSpec.configure { |c| c.include RSpecMixin }

RSpec.configure do |config|
  config.include Rack::Test::Methods
end
