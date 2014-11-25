class StandardizedData
  attr_reader :filename
  attr_accessor :rows

  def initialize(filename)
    @filename = filename
    parse_csv
  end

  private

  HEADER_ALIASES = {
    genus:       ["genus", "name", "name_of_dino", "namo", "el_namer"],
    period:      ["period"],
    diet:        ["carnivore", "diet"],
    weight:      ["weight_in_lbs", "weight"],
    numlegs:     ["walking"],
    continent:   ["continent"],
    description: ["description"],
  }

  def parse_csv
    parsed_rows = []
    CSV.foreach(filename, headers: true, header_converters: header_conversions,
        converters: value_conversions) do |row|
          row[:continent] = default_continent(row)
          parsed_rows << row
        end
    @rows = parsed_rows
  end

  def header_conversions
    [
      :downcase,
      :standardize_header,
      :symbol,
    ]
  end

  def value_conversions
    [
      :standardize_weight,
      :standardize_period,
      :standardize_diet,
    ]
  end

  CSV::HeaderConverters[:standardize_header] = lambda do |field|
    HEADER_ALIASES.detect { |_index, value| value.include?(field) }[0]
  end

  CSV::Converters[:standardize_diet] = lambda do |field, field_info|
    return field unless (field_info.header == :diet) && (field =~ /^(Yes|No)$/)
    field == 'Yes' ? "Carnivore" : "Herbivore"
  end

  CSV::Converters[:standardize_period] = lambda do |field, field_info|
    return field unless (field_info.header == :period) && (field =~ /Cretaceous/i)
    "Cretaceous"
  end

  CSV::Converters[:standardize_weight] = lambda do |field, field_info|
    return field unless (field_info.header == :weight)
    field.to_i
  end

  def default_continent(row)
    return row[:continent] unless filename.include?("africa") && row[:continent].nil?
    "Africa"
  end
end
