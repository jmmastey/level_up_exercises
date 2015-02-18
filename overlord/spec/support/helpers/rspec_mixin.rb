module Helpers
  module RSpecMixin
    include Rack::Test::Methods
    def app() Overlord end
  end
end
