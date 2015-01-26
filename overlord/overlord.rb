require "sinatra"
require_relative "lib/overlord/bomb"

module Overlord
  class BombInterface < Sinatra::Base
    enable :sessions

    get "/" do
      erb bomb.status.downcase.to_sym,
        layout: :main,
        locals: { bomb: bomb }
    end

    post "/setup" do
      bomb.setup(params[:activation_code], params[:deactivation_code])  
      redirect to("/")
    end

    post "/activate" do
      bomb.activate(params[:activation_code])
      redirect to("/")
    end

    post "/deactivate" do
      bomb.deactivate(params[:deactivation_code])
      redirect to("/boom") if bomb.status == "BOOM"
      redirect to("/")
    end

    get "/boom" do
      erb :boom
    end

    def bomb
      session[:bomb] ||= Bomb.new
    end
  end
end
