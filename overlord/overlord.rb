#!/usr/bin/env ruby
# run `ruby overlord.rb` to run a webserver for this app

require "json"
require "pry"
require "sinatra/base"
require_relative "lib/bomb_controller"
require_relative "lib/wire_box"
require_relative "lib/wire_generator"
require_relative "lib/bomb"

class Overlord < Sinatra::Base
  BOMB_CODE_REGEX = /[0-9]{4}/

  set :haml, format: :html5
  set :sessions, true
  set :raise_errors, true
  set :dump_errors, false
  set :show_exceptions, true

  get "/" do
    redirect("/boot")
  end

  get "/bomb" do
    @bomb_controller = current_bomb_controller
    redirect "/boot" unless @bomb_controller

    begin
    haml(:bomb)
    rescue Exception => e
      log_error(e)
      raise e
    end
  end

  get "/boot" do
    haml(:boot)
  end

  get "/get_state" do
    get_json_response
  end

  get "/explosion" do
    haml(:explosion)
  end

  post "/boot" do
    activation_code = params[:activation_code]
    deactivation_code = params[:deactivation_code]

    return haml(:boot) unless validate_codes(activation_code, deactivation_code)

    session[:bomb_controller] = create_bomb_controller(activation_code, deactivation_code)
    redirect "/bomb"
  end

  post "/code_entry" do
    code = params[:code]

    bomb_controller = current_bomb_controller
    bomb_controller.enter_code(code)
    # binding.pry

    get_json_response
  end

  post "/snip_wire" do
    color = params[:wire_color]
    bomb_controller = current_bomb_controller
    wire = bomb_controller.wire_box.get_wire_from_color(color)
    wire.snip

    get_json_response
  end

  private

  def add_error(error)
    @error ||= ""
    @error << "#{error}\n"
  end

  def current_bomb_controller
    session[:bomb_controller]
  end

  def create_bomb_controller(activation_code, deactivation_code)
    bomb_controller = BombController.new(activation_code, deactivation_code)
    bomb_controller.wire_box = create_wire_box
    bomb_controller.wire_box.device = create_bomb

    bomb_controller
  end

  def create_wire_box
    wire_generator = WireGenerator.new("./valid_wire_colors.dat")
    wires = wire_generator.generate_wires
    WireBox.new(wires)
  end

  def create_bomb
    Bomb.new
  end

  def get_json_response
    bomb_controller = current_bomb_controller
    bomb_controller.update_state
    detonation_time = get_detonation_time_from_timer(bomb_controller.timer)

    { message: bomb_controller.message,
      state: bomb_controller.state,
      detonation_time: detonation_time
    }.to_json
  end

  def get_detonation_time_from_timer(timer)
    return nil if timer.nil?
    timer.end_time
  end

  def log_error(error)
    File.open("error.log", "a") do |file|
      file.write("ERROR LOGGED #{Time.now}\n")
      file.write("\t#{error}\n")
      backtrace = error.backtrace.map { |entry| "\t\t#{entry}" }
      file.write("#{backtrace.join("\n")}\n")
    end
  end

  def validate_code(code)
    return true if code.nil? || code.empty? || code.match(BOMB_CODE_REGEX)

    add_error("'#{code}' is an invalid code.")
    false
  end

  def validate_codes(*codes)
    return codes.all? { |code| validate_code(code) }
  end

  # start server if this file is executed
  run! if app_file == $0
end
