# Map between dinosaur and CSV data source

require 'csv'
require 'json'
require './dinosaur'

class DinoCSVDataMapper
  attr_accessor :dinosaurs

  def initialize
    @data_source = ['dinodex.csv', 'african_dinosaur_export.csv']
    @dinosaurs = []

    @data_source.each do |ds|
      raise "Data source: #{ds} not found" unless File.file? ds
      load_data ds
    end
  end

  def load_data(csv_file)

    csv_data = CSV.read(csv_file, headers: true)
    csv_data.each do |csv_row|

      dino_obj = Dinosaur.new

      csv_row.each do |key, val|
        case key
          when "NAME", "Genus"
            dino_obj.name = val
          when "PERIOD", "Period"
            dino_obj.period = val
          when "CONTINENT"
            dino_obj.continent = val
          when "DIET"
            dino_obj.diet = val
          when "Carnivore"
            dino_obj.diet = "Carnivore" if val == "Yes"
          when "WEIGHT_IN_LBS", "Weight"
            dino_obj.weight = val
          when "WALKING", "Walking"
            dino_obj.walking = val
          when "DESCRIPTION"
            dino_obj.desc = val
        end
      end

      @dinosaurs << dino_obj
    end
  end

  # TODO: Make it work with multiple conditions
  def find(condition = nil)

    dinosaurs_found = DinoCSVDataMapper.new

    return dinosaurs_found unless (condition)
    raise "find condition must be a hash" unless condition.is_a? Hash

    (attr, val) = condition.first

    dinosaurs_found.dinosaurs =
      @dinosaurs.select do |dino_obj|
        (ret = dino_obj.send(attr)) && ret.downcase == val.downcase
      end

    dinosaurs_found
  end

  def to_s
    @dinosaurs.inject('') { |string, dino| string << dino.to_s }
  end

  def to_json
    @dinosaurs.map{ |dino| dino.to_json }
  end
end
