require 'csv'

class Parser
  def initialize
    CSV::HeaderConverters[:header_converter] = method(:header_converter)
  end

  def parse_dinodex(filename)
    csv = CSV.read(filename, headers: true,
          header_converters: [:downcase, :header_converter, :symbol])
    csv.map(&:to_hash)
  end

  def parse_african_dinosaurs(filename)
    african_dinos_hash = parse_dinodex(filename)
    african_dinos_hash.each do |row|
      row[:continent] = "Africa"
      row[:diet] = row[:diet] == "Yes" ? "Carnivore" : "Herbivore"
    end
  end

  def header_converter(header)
    case header
      when 'genus' then :name
      when 'weight_in_lbs' then :weight
      when 'carnivore' then :diet
      else header
    end
  end
end
