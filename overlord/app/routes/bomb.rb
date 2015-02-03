require 'sinatra'
require 'sinatra/contrib'
require 'dm-sqlite-adapter'
require 'json'

require_relative '../helpers/bomb_helpers'
require_relative '../helpers/wire_helpers'

enable :sessions

class Overlord < Sinatra::Application
  include BombHelpers

  def set_bomb_session
    session[:bomb] = Bomb.last.id
  end
  before(/.*/) do
    if request.url.match(/.json$/)
      request.accept.unshift('application/json')
      request.path_info = request.path_info.gsub(/.json$/, '')
    end
  end

  before :method => :post do
    params = {}
    opt_attributes = request.body.read.split("&")
    opt_attributes.each do |attribute|
      column_values = attribute.split("=")
      params[column_values[0]] = column_values[1]
    end
  end

  get '/bomb/:bomb_id' do
    @bomb = Bomb.where("id = ?", params[:bomb_id]).first
    session[:bomb] = @bomb
    BombHelpers.explode_bomb(@bomb)
    if request.accept.length == 1
      haml :bomb
    else
      respond_to do |format|
        format.json { @bomb.to_json }
        format.html { haml :bomb }
      end
    end
  end

  get "/bomb_activate" do
    haml :bomb_activate
  end

  get "/bomb_deactivate" do
    haml :bomb_deactivate
  end

  post '/bomb/diffuse' do
    set_bomb_session if ENV["RAILS_ENV"] == "test"
    @bomb = Bomb.where("id = ?", session[:bomb]).first
    wire = Wire.where(color: params["color"]).first

    if wire.diffuse?
      @bomb.inactive!
    else
      @bomb.explode!
    end
    @bomb.save!
    session[:bomb] = @bomb.id
    haml :bomb
  end

  post '/bomb' do
    @bomb = Bomb.create(
      activation_code: params["activation_code"] || "1234",
      deactivation_code: params["deactivation_code"] || "0000",
      detonation_time: params["detonation_time"])

    if @bomb.valid?
      params["wires"] ||= WireHelpers.default_wires

      @bomb.save!
      params["wires"].each do |wire_options|
        wire = @bomb.wires.build(wire_options)
        wire.save
      end
      session[:bomb] = @bomb.id
      haml :bomb
    else
      Overlord.error_message += @bomb.errors.messages.collect do |attribute, msg|
                                  "#{attribute} : #{msg.first} "
                              end.join(", ")
      redirect "/"
    end
  end

  post '/bomb/activate' do
    set_bomb_session if ENV["RAILS_ENV"] == "test"
    bomb = Bomb.where("id = ?", session[:bomb]).first

    if bomb.match_activation_code?(params["activation_code"])
      bomb.activate
    end
    BombHelpers.explode_bomb(bomb)
    @bomb = bomb
    haml :bomb
  end

  post '/bomb/deactivate' do
    set_bomb_session if ENV["RAILS_ENV"] == "test"
    bomb = Bomb.where("id = ?", session[:bomb]).first

    if bomb.match_deactivation_code?(params["deactivation_code"])
      bomb.deactivate
    else
      bomb.failed_attempts += 1
      bomb.save!
      if bomb.failed_attempts == 3
        bomb.explode
      end
    end
    BombHelpers.explode_bomb(bomb)
    @bomb = bomb
    haml :bomb
  end
end
