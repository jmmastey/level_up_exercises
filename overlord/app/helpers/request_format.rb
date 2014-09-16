# File request_format.rb
# encoding: UTF-8

module Sinatra
  module RequestFormat
    def json
      @json ||= JSON(request.body.read).symbolize_keys!
    end
  end
  helpers RequestFormat
end
