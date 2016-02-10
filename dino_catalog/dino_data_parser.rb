# Provides a general framework to parse a CSV file into an array of Dinosaurs
class DinoDataParser
  require 'csv'
  require_relative 'dinosaur'

  def parse
    table = CSV.read(data_file, headers: true, header_converters: :symbol,
                     converters: :all)
    table.reduce([]) { |array, dino| array << Dinosaur.new(format_data(dino)) }
  end

  def format_data(dino)
    raise NotImplementedError, "'format_data' must be defined in subclass"
  end

  def data_file
    raise NotImplementedError, "'data_file' must be defined in subclass"
  end
end
