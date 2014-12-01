class InvalidFormatError < RuntimeError; end

module FormatterFactory
  FORMATTERS = { "" => "Formatter",
                 "genus,period,carnivore,weight,walking" => "AfricanFormatter",
                 "name,period,continent,diet,weight_in_lbs,walking,description" => "DinodexFormatter" }

  def self.formatter(header)
    formatter_class = FORMATTERS[header.downcase]
    raise InvalidFormatError, "Invalid CSV format" if formatter_class.nil?

    Object.const_get(formatter_class).new
  end
end

class Formatter
  def format(raw_data)
    # in case raw_data is nil
    raw_data_str = raw_data.to_s

    csv = CSV(raw_data_str, headers: true, header_converters: header_conversions.flatten,
                  converters: body_conversions.flatten)
    csv.map(&:to_hash)
  end

  private
  def header_conversions
    [:symbol]
  end

  def body_conversions
    [:downcase, :all]
  end

  CSV::Converters[:downcase] = lambda do |body, field_info|
    body.downcase unless body.nil?
  end
end

class DinodexFormatter < Formatter
end

class AfricanFormatter < Formatter
  def format(body)
    super.each { |dino_hash| add_continent(dino_hash) }
  end

  private
  HEADER_MAPPINGS = { "genus" => :name, "carnivore" => :diet, "weight" => :weight_in_lbs }
  DIET_MAPPINGS = { "yes" => "carnivore", "no" => "herbivore" }

  def header_conversions
    [:downcase, :standardize_header, super]
  end

  def body_conversions
    [super, :standardize_diet]
  end

  def add_continent(dino_hash)
    dino_hash[:continent] = "africa"
  end

  CSV::HeaderConverters[:standardize_header] = lambda do |header|
    HEADER_MAPPINGS[header] || header
  end

  CSV::Converters[:standardize_diet] = lambda do |body, field_info|
    field_info.header == :diet ? DIET_MAPPINGS[body] : body
  end
end
