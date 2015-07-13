require 'csv'

class DinoLoader
  attr_accessor :dino_data, :path, :header_mapper
  attr_reader :catalog

  def initialize
    @csv_table = []
  end

  def load_dino_data
    Dir.glob("data/*.csv").each do |file|
      data = CSV.read(file, headers: true, header_converters: header_converters,
        converters: [diet_field_converter, weight_field_converter]
                     )
      data.each { |row| @csv_table << row }
    end
    @csv_table
  end

  private

  def header_converters
    lambda do |header_value|
      header_value.gsub!('genus', 'name')
      header_value.gsub!('weight_in_lbs', 'weight')
      header_value.gsub!('carnivore', 'diet')
      header_value.downcase.to_sym
    end
  end

  def diet_field_converter
    lambda do |value, fields|
      return value unless (fields.header == :diet) && (value =~ /^(Yes|No)$/)
      value == 'Yes' ? 'Carnivore' : 'Herbivore'
    end
  end

  def weight_field_converter
    lambda do |value, fields|
      return value unless (fields.header == :weight)
      value.to_i
    end
  end
end
