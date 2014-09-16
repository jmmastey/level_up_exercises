require 'rubygems'
require 'bundler/setup'
Bundler.require(:default, :test, :development)
require File.expand_path(File.dirname(__FILE__) + '/overlord_helpers.rb')
# require 'sinatra'
# require 'sinatra/json'
# require 'sinatra/partial'
# require 'json'
# require 'active_support/all'
# require 'time_difference'
# require 'data_mapper'
# require_relative 'models/bomb'


class Overlord < Sinatra::Application
  include OverlordHelpers
  register Sinatra::Partial
  set :partial_template_engine, :erb
  enable :sessions
  enable :partial_underscores

  set static: true
  # set :public_folder, File.dirname(__FILE__) + '../public'
  configure :development do
    DataMapper::Logger.new($stdout, :debug)
    DataMapper.setup(
        :default,
        "sqlite3://#{Dir.pwd}/bomb.db"
    )
  end

  configure :test do
    DataMapper::Logger.new($stdout, :debug)
    DataMapper.setup(
        :default,
        "sqlite3://#{Dir.pwd}/bomb_test.db"
    )
    set :views_folder, "#{File.dirname(__FILE__)}/views"
    set :public_folder, "#{File.dirname(__FILE__)}/public"
  end

  configure :production do
    DataMapper.setup(
        :default,
        'postgres://postgres:12345@localhost/sinatra_service'
    )
  end

  get '/' do
    @form_fields = %w(activation_code deactivation_code detonation_time)
    erb :index, layout: :base
  end

  # after do
  #   puts body
  # end

  get '/explode' do
    json status: 'boom'

  end

  run! if app_file == $PROGRAM_NAME
end

require_relative 'models/init'
require_relative 'helpers/init'
require_relative 'routes/init'


