require 'csv'

module DinoCSVTools
  class CSVtoDinos

    CSV::Converters[:blank_to_nil] = lambda do |field|
      field && field.empty? ? nil : field
    end

    CSV::Converters[:downcase] = lambda { |s| s.downcase rescue s }

    def self.csv_to_hash_array(file)
      csv_params = {
        headers: true,
        header_converters: :symbol,
        converters: [:all, :downcase, :blank_to_nil]
      }
      @csv = CSV.read(file, csv_params)
      @csv.map(&:to_hash)
    end

    def self.normalize(dinos)
      dinos.each do |dino|
        dino[:name] = dino.delete :genus
        dino[:weight_in_lbs] = dino.delete :weight
        dino[:diet] = dino.delete :carnivore
        dino[:continent] = "africa"
        dino[:diet] = dino[:diet].eql?("yes") ? "carnivore" : "herbivore"
      end
    end

  end

end