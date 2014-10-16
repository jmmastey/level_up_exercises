ENV['RACK_ENV'] = 'test'

require_relative '../overlord'  # <-- your sinatra app
require 'rspec'
require 'rack/test'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

def app
  Sinatra::Application
end

def session
  last_request.env['rack.session']
end

def configure_bomb(act_code = 1111, deact_code = 1234)
  post '/initialize', params={activation_code: act_code,
                                      deactivation_code: deact_code}
end

def activate_bomb(act_code = 1111)
  post '/activate', params={activation_code: act_code}
end

def deactivate_bomb(deact_code = 1234)
  post '/deactivate', params={deactivation_code: deact_code}
end