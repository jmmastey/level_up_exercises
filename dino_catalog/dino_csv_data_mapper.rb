# Map between dino_data and CSV data source
# Used by dino_data_tester.rb

require 'csv'
require 'json'
require './dinosaur'

class DinoCSVDataMapper
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
      dino_obj = nil
    end
  end

  # TODO: Have a better name, simple one
  # Find by attribute & value, returns array of dino_obj
  def find(attr, val, dino_data = @dinosaurs)

    dino_data_out =
      dino_data.select do |dino_obj|
        (ret = dino_obj.send(attr)) && ret.downcase == val.downcase
      end
  end

  # Chain searches, returns an array of dino_obj
  def chain_find_by_attr(params = {}, dino_data = @dinosaurs)

    params.each { |attr, val| dino_data = find(attr, val, dino_data) }

    dino_data
  end

  ## Comments: separate concerns (print)
  # return same class
  #
  # Output to console
  # TODO: Just call it puts (override to_s)
  def cout(dino_data = @dinosaurs)

    dino_data.each do |dino_obj|
      puts dino_obj
    end
    puts
  end

  def json_out(dino_data = @dinosaurs)
    dino_data.map{ |dino| dino.to_json }
  end
end
