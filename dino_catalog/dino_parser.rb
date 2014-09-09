require_relative "dino"

class DinoParser
  attr_reader :file_name, :dinos

  def initialize(file_name)
    @file_name = file_name
    @dinos = []

    parse_csv 
  end

  private
    def parse_csv
      CSV.foreach(@file_name, { headers: true, header_converters: :symbol} ) do |row|
      @dinos << Dino.new(standardize_row(row)) 
      end
    end

    def standardize_row(row_in)
      row = row_in.to_hash.reject{ |key, val| val == nil }

      row[:name] = row.delete :genus if row.has_key? :genus
      row[:weight_in_lbs] = kg_to_lbs(row.delete :weight) if row.has_key? :weight

      if row.has_key? :carnivore
        is_carnivore = row[:diet] = (row.delete :carnivore).downcase
        if is_carnivore == "yes"
          row[:diet] = "carnivore"
        elsif is_carnivore == "no"
          row[:diet] = "herbivore"
        end
      end

      row[:continent] = "Africa" if !row.has_key? :continent

      row 
    end

    def kg_to_lbs(num_kg)
      (num_kg.to_f / 2.20462).to_i
    end
end

