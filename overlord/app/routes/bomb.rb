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


  post '/bomb' do
    request_json = {}

    request_json = JSON.parse(request.body.read) unless request.body.string == ""

    bomb = Bomb.create(
      activation_code: request_json["activation_code"],
      deactivation_code: request_json["deactivation_code"],
      detonation_time: request_json[:detonation_time])
    bomb.to_json
  end

  post '/bomb/activate' do
    request_json = {}
    request_json = JSON.parse(request.body.read) unless request.body.string == ""
    bomb = Bomb.last
    if bomb.activation_code == request_json["activation_code"] && !BombHelpers.is_active?(bomb)
      bomb.status = :active
      bomb.activated_time = Time.now
      bomb.save!
    end
    BombHelpers.bomb_status(bomb)
  end

  post '/bomb/deactivate' do
    request_json = {}
    request_json = JSON.parse(request.body.read) unless request.body.string == ""
    bomb = Bomb.last
    if bomb.deactivation_code == request_json["deactivation_code"] && BombHelpers.is_active?(bomb)
      bomb.status = :inactive
      bomb.activated_time = nil
      bomb.save!
    end
    BombHelpers.bomb_status(bomb)
  end
end