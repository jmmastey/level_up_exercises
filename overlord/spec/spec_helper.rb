$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rspec'

require_relative '../lib/overlord'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
