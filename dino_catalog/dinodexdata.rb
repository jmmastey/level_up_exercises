require 'csv'

class DinoDexData
  attr_reader :data

  MAIN_DATA_SOURCE = 'dinodex.csv' # path to csv
  PB_DATA_SOURCE = 'african_dinosaur_export.csv' # path to csv

  FIELD_MAPPING = {
    carnivore: :diet,
    genus: :name,
    weight_in_lbs: :weight,
  }

  def initialize
    @data = get_main_data + get_pb_data
  end

  private

  def get_main_data
    CSV.open(MAIN_DATA_SOURCE,
             headers: true,
             header_converters: :symbol
    ) do |csv|
      csv.to_a.map(&:to_hash)
    end
  end

  def header_converters
    CSV::HeaderConverters[:map_to_main] = lambda do |header|
      header = header.downcase.to_sym
      return FIELD_MAPPING[header] if FIELD_MAPPING.key?(header)
      header
    end
  end

  def converters
    CSV::Converters[:map_to_main] = lambda do |value, field_info|
      if field_info.header == 'diet' && !value.nil? && value.downcase == 'yes'
        return 'Carnivore'
      end
      value
    end
  end

  def get_pb_data
    header_converters
    converters
    parse_pb_file
  end

  def parse_pb_file
    CSV.open(PB_DATA_SOURCE,
             converters: :map_to_main,
             headers: true,
             header_converters: :map_to_main
    ) do |csv|
      csv.to_a.map(&:to_hash)
    end
  end
end
