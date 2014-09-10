require_relative "dino"

class DinoParser
  attr_reader :file_name, :dinos

  def initialize(file_name)
    @filename = file_name
    @dinos = []

    parse_csv
  end

  private

  def parse_csv
    CSV.foreach(@filename, headers: true, header_converters: :symbol) do |row|
      @dinos << Dino.new(standardize_row(row))
    end
  end

  def standardize_row(row_in)
    row = row_in.to_hash.reject { |_, val| val == nil }

    row[:name] = row.delete :genus if row.has_key? :genus
    if row.has_key? :weight
      row[:weight_in_lbs] = kg_to_lbs(row.delete :weight)
    end

    if row.has_key? :carnivore
      is_carnivore = row[:diet] = (row.delete :carnivore).downcase
      row[:diet] = diet_type(is_carnivore)
    end

    row[:continent] = "Africa" unless row.has_key? :continent

    row
  end

  def diet_type(is_carnivore)
    is_carnivore ? "carnivore" : "herbivore"
  end

  def kg_to_lbs(num_kg)
    (num_kg.to_f / 2.20462).to_i
  end
end

