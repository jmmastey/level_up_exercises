require 'csv'
require './dinosaur'

class DinoCSVDataMapper
  attr_reader :dinosaurs

  def initialize(*data_source)
    @dinosaurs = []
    data_source = ['dinodex.csv'] if data_source.empty?

    data_source.each do |ds|
      raise "Data source: #{ds} not found" unless File.file? ds
      import ds
    end
  end

  def import(csv_file)
    csv_data = CSV.read(csv_file, headers: true)
    csv_data.each do |csv_row|

      dino_obj = Dinosaur.new

      csv_row.each do |key, val|
        case key
          when "NAME", "Genus"
            dino_obj.name = val
          when "PERIOD", "Period"
            # Normalize Cretaceous since we don't care if early or late
            dino_obj.period = (val =~ /Cretaceous/i) ? 'Cretaceous' : val
          when "CONTINENT"
            dino_obj.continent = val
          when "DIET"
            dino_obj.diet = val
          when "Carnivore"
            dino_obj.diet = "Carnivore" if val == "Yes"
          when "WEIGHT_IN_LBS", "Weight"
            dino_obj.weight = val.to_i
          when "WALKING", "Walking"
            dino_obj.walking = val
          when "DESCRIPTION"
            dino_obj.desc = val
        end
      end

      @dinosaurs << dino_obj
    end
  end

end
