require "csv"
require_relative "dinosaur"

class DinoLoader
  HEADER_MAPPINGS = {
    "genus" => "name",
    "weight_in_lbs" => "weight",
  }

  def self.load(filename)
    rows = CSV.read(filename,
      headers: :first_row,
      header_converters: [:downcase,
                          ->(h) { map_header(h) },
                          :symbol])
    transform_data(rows)
    rows.map { |row| Dinosaur.new(row) }
  end

  def self.transform_data(rows)
    transform_diet(rows)
    transform_weight(rows)
  end

  def self.transform_diet(rows)
    rows.each do |row|
      if row[:carnivore] == "Yes"
        row[:diet] = "Carnivore"
      elsif row[:carnivore] == "No"
        row[:diet] = "Herbivore"
      end
    end
  end

  def self.transform_weight(rows)
    rows.each { |row| row[:weight] = row[:weight].to_i }
  end

  def self.map_header(header)
    HEADER_MAPPINGS[header] || header
  end
end
