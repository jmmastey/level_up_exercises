#!/usr/bin/env ruby
# run `ruby overlord.rb` to run a webserver for this app

require "pry"
require "sinatra/base"

class Overlord < Sinatra::Base
  BOMB_CODE_REGEX = /[0-9]{4}/

  set :haml, format: :html5
  set :sessions, true

  get "/" do
    redirect("/boot")
  end

  get "/bomb" do
    haml(:bomb)
  end

  get "/boot" do
    haml(:boot)
  end

  post "/boot" do
    activation_code = params[:activation_code]
    deactivation_code = params[:deactivation_code]

    return haml(:boot) unless validate_codes(activation_code, deactivation_code)

    redirect "/bomb"
  end

  def add_error(error)
    @error ||= ""
    @error << "#{error}\n"
  end

  # we can shove stuff into the session cookie YAY!
  def start_time
    session[:start_time] ||= (Time.now).to_s
  end

  def validate_code(code)
    return true if code.empty? || code.match(BOMB_CODE_REGEX)

    add_error("#{code} is an invalid code.")
    false
  end

  def validate_codes(*codes)
    return codes.all? { |code| validate_code(code) }
  end

  # start server if this file is executed
  run! if app_file == $0
end
