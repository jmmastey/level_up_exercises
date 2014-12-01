class Transformer
  attr_accessor :parsed_rows

  HEADER_ALIASES = {
    genus:       ['genus', 'name', 'name_of_dino', 'namo', 'el_namer'],
    period:      ['period'],
    diet:        ['carnivore', 'diet'],
    weight:      ['weight_in_lbs', 'weight'],
    numlegs:     ['walking'],
    continent:   ['continent'],
    description: ['description'],
  }
  HEADER_CONVERSIONS = [:downcase, :standardize_header, :symbol]
  VALUE_CONVERSIONS  = [:standardize_weight, :standardize_period, :standardize_diet]

  def initialize(filename)
    @parsed_rows = []
    initialize_csv_converters
    parse_csv(filename)
  end

  private

  def initialize_csv_converters
    CSV::HeaderConverters[:standardize_header] = lambda do |field|
      HEADER_ALIASES.detect { |_index, value| value.include?(field) }[0]
    end

    CSV::Converters[:standardize_diet] = lambda do |field, field_info|
      return field unless (field_info.header == :diet) && (field =~ /^(Yes|No)$/)
      field == 'Yes' ? 'Carnivore' : 'Herbivore'
    end

    CSV::Converters[:standardize_period] = lambda do |field, field_info|
      return field unless (field_info.header == :period) && (field =~ /Cretaceous/i)
      'Cretaceous'
    end

    CSV::Converters[:standardize_weight] = lambda do |field, field_info|
      return field unless (field_info.header == :weight)
      field.to_i
    end
  end

  def parse_csv(filename)
    csv_options = { headers: true,
                    header_converters: HEADER_CONVERSIONS,
                    converters: VALUE_CONVERSIONS }
    CSV.foreach(filename, csv_options) do |row|
      row[:continent] = default_continent(filename, row)
      @parsed_rows << row
    end
  end

  def default_continent(filename, row)
    return row[:continent] unless filename.include?('africa') && row[:continent].nil?
    'Africa'
  end
end
