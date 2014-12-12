require "csv"
require_relative "dinosaur"

class DinoLoader

  def self.load(filename)
    rows = CSV.read(filename,
                     headers: :first_row,
                     header_converters: [:downcase,
                                         lambda {|h| map_header(h)},
                                         :symbol])
    rows.each do |row|
      case row[:carnivore]
      when "Yes"
        row[:diet] = "Carnivore"
      when "No"
        row[:diet] = "Herbivore"
      end
      row[:weight] = row[:weight].to_i
    end
    rows.map {|row| Dinosaur.new(row)}
  end

  private

  HEADER_MAPPINGS = {
    "genus" => "name",
    "weight_in_lbs" => "weight",
  }
    
  def self.map_header(header)
    HEADER_MAPPINGS[header] || header
  end

end

