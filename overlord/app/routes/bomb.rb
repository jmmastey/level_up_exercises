require 'sinatra'
require 'dm-sqlite-adapter'

class Overlord < Sinatra::Application
  post '/bomb' do
    request_json = {}

    request_json = JSON.parse(request.body.read) unless request.body.string == ""

    bomb = Bomb.create(
      activation_code: request_json["activation_code"],
      deactivation_code: request_json["deactivation_code"],
      detonation_time: request_json[:detonation_time])

    bomb.to_json
  end
end