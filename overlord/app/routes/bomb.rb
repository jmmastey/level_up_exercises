require 'sinatra'
require 'dm-sqlite-adapter'
require 'json'

require_relative '../helpers/bomb_helpers'
class Overlord < Sinatra::Application
  include BombHelpers

  get '/bomb.json' do
    bomb = Bomb.last
    haml :bomb
    content_type :json
    BombHelpers.bomb_status(bomb)
  end

  get '/bomb' do
    bomb = Bomb.last
    BombHelpers.bomb_status(bomb)
    haml :bomb
  end

  get '/bomb/diffuse' do
    bomb = Bomb.last
    wire = Wire.where(color: params["color"]).first
    if wire.diffuse?
      bomb.status = "inactive"
    else
      bomb.status = "explode"
    end
    bomb.save!
    haml :bomb
  end

  post '/bomb' do
    request_json = {}
    request_json = JSON.parse(request.body.read) if request.body.try("string") != ""

    bomb = Bomb.create(
      activation_code: request_json["activation_code"],
      deactivation_code: request_json["deactivation_code"],
      detonation_time: request_json["detonation_time"])

    request_json["wires"] ||= [{ color: "red", diffuse: true },
                                { color: "green", diffuse: true }]

    bomb.save!

    request_json["wires"].each do |wire|
      wire_string = bomb.wires.build(wire)
      wire_string.save
    end

    bomb.to_json
  end

  post '/bomb/activate' do
    request_json = {}
    request.body
    request_json = JSON.parse(request.body.read)
    bomb = Bomb.last
    if bomb.activation_code == request_json["activation_code"] && !BombHelpers.active?(bomb)
      bomb.status = :active
      bomb.activated_time = Time.now
      bomb.failed_attempts = 0
      bomb.save!
    end
    BombHelpers.bomb_status(bomb)
  end

  post '/bomb/deactivate' do
    request_json = {}
    request_json = JSON.parse(request.body.read)
    bomb = Bomb.last
    if bomb.deactivation_code == request_json["deactivation_code"] && BombHelpers.active?(bomb)
      bomb.status = :inactive
      bomb.activated_time = nil
      bomb.failed_attempts = 0
      bomb.save!
    else
      bomb.failed_attempts += 1
      bomb.save!
      if bomb.failed_attempts == 3
        bomb.status = :explode
        bomb.activated_time = nil
        bomb.save!
      end
    end
    BombHelpers.bomb_status(bomb)
  end
end
