module Helpers
  module Session
    def session
      last_request.env['rack.session']
    end
  end
end
