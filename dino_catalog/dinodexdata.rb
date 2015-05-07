require 'csv'
require 'json'

class DinoDexData
  attr_reader :data

  def initialize
    @data = read_main_csv('dinodex.csv') + read_pirate_bay_csv('african_dinosaur_export.csv')
  end

  def read_main_csv(file)
    CSV.open(file,
      headers: true,
      header_converters: :downcase).to_a.map(&:to_hash)
  end

  def read_pirate_bay_csv(file)
    CSV::HeaderConverters[:map_to_main] = lambda do |header|
      case header.downcase
        when 'carnivore'
          'diet'
        when 'genus'
          'name'
        when 'weight'
          'weight_in_lbs'
        else
          header
      end
    end
    CSV::Converters[:map_to_main] = lambda do |value, field_info|
      if field_info.header == 'diet' && !value.nil? && value.downcase == 'yes'
        'Carnivore'
      else
        value
      end
    end
    CSV.open(file,
      converters: :map_to_main,
      headers: true,
      header_converters: :map_to_main).to_a.map(&:to_hash)
  end
end
