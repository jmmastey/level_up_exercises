$LOAD_PATH << '.'
require 'csv'
require 'dinosaur'

class DinosaurLoader
  attr_reader :dinosaurs, :directory

  def initialize(directory)
    @directory = directory
    @dinosaurs = []
    get_files(directory)
  end

  def get_files(directory)
    Dir.foreach(directory) do |item|
      next if item == '.' || item == '..' || item == '.DS_Store'
      load_file(item)
    end
  end

  def load_file(filename)
    filename = @directory + filename
    CSV.foreach(
      filename,
      headers: true,
      header_converters: header_converter) do |row|
      @dinosaurs << Dinosaur.new(row)
    end
  end

  def header_converter
    lambda do |h|
      h.gsub!('Genus', 'name')
      h.gsub!('WEIGHT_IN_LBS', 'weight')
      h.gsub!('Walking', 'locomotion')
      h.downcase!
      h.to_sym
    end
  end
end
