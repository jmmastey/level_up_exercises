# Map between dino_data and CSV data source
# Used by dino_data_tester.rb

require 'csv'
require 'json'
require './dino_data'

class DinoCSVDataMapper
  def initialize
    @data_source = ['dinodex.csv', 'african_dinosaur_export.csv']
    @dino_data = []

    # Load data from data_source
    @data_source.each do |ds|
      raise "Data source: #{ds} not found" unless File.file? ds
      load_data ds
    end
  end

  # Load data from CSV files
  def load_data(csv_file)

    csv_data = CSV.read(csv_file, headers: true)
    csv_data.each do |csv_row|
      # Create a Dino Obj and store data
      dino_obj = DinoData.new

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

      # Append to dino_data
      @dino_data << dino_obj
      dino_obj = nil
    end
  end

  # Find by attribute & value, returns array of dino_obj
  def find_by_attr(attr, val, dino_data_in = nil)
    dino_data = dino_data_in || @dino_data

    dino_data_out =
      dino_data.select do |dino_obj|
        (ret = dino_obj.send(attr)) && ret.downcase == val.downcase
      end
  end

  # Find by attribute condition, returns array of dino_obj
  def find_by_attr_cond(attr, condition, dino_data_in = nil)
    dino_data = dino_data_in || @dino_data

    dino_data_out =
      dino_data.select do |dino_obj|
        (ret = dino_obj.send(attr)) && eval("#{ret} #{condition}")
      end
  end

  # Chain searches, returns an array of dino_obj
  def chain_find_by_attr(params = {}, dino_data_in = nil)
    dino_data = dino_data_in || @dino_data

    params.each { |attr, val| dino_data = find_by_attr(attr, val, dino_data) }

    dino_data
  end

  # Output to console
  def cout(dino_data_in = nil)
    dino_data = dino_data_in || @dino_data

    dino_data.each do |dino_obj|
      puts dino_obj.labels
      puts dino_obj
    end
    puts
  end

  # Output to json
  def jsonOut(dino_data_in = nil)
    dino_data = dino_data_in || @dino_data

    dino_data.to_json
  end

end
