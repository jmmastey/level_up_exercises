require 'haml'
require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'bomb_helpers.rb'
require_relative 'view_helpers.rb'

module Overlord
  class ApplicationController < ::Sinatra::Base
    include ViewHelpers
    include BombHelpers

    set :port, 8080
    enable :sessions, :logging
    register Sinatra::Reloader

    set :haml, format: :html5, layout: :template
    set :layout, :template

    after '/' do
      unnotify
      still_dead?
    end

    get '/' do
      haml :index
    end

    get '/configure' do
      configure_bomb(params[:codes].empty? ? nil : params[:codes])
      redirect '/'
    end
  end
end
