# File response_format.rb
# encoding: UTF-8
# require 'sinatra/base'

module Sinatra
  module ResponseFormat
    def format_response(data, accept)
      accept.each do |type|
        return data.to_xml if type.downcase.eql? 'text/xml'
        return data.to_json if type.downcase.eql? 'application/json'
        return data.to_yaml if type.downcase.eql? 'text/x-yaml'
        return data.to_csv if type.downcase.eql? 'text/csv'
        return data.to_json
      end
    end

    def format_bomb(bomb)
      wires = bomb.wires.map do |wire|
        { color: wire.color, id: wire.id }
      end
      format_response({ id: bomb.id, status: bomb.status,
                        attempts: bomb.attempts,
                        detonation_time: bomb.detonation_time,
                        wires: wires }, request.accept)
    end
  end
  helpers ResponseFormat
end
