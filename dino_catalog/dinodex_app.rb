require 'sinatra'
require 'sinatra/reloader'
require_relative 'lib/dinodex'
require_relative 'lib/joes_data_parser'
require_relative 'lib/african_data_parser'

dino_list = JoesDataParser.new.parse +
            AfricanDataParser.new.parse
dex = DinoDex.new(dino_list)

get '/' do
  erb :index
end

get '/all' do
  erb :show, :locals => {dinosaurs: dex.all_dinosaurs}
end
