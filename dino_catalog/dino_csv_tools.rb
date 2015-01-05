require 'csv'
module DinoCSVTools
  class CSVtoDinos
    CSV::Converters[:blank_to_nil] = -> (field) do
      field && field.empty? ? nil : field
    end

    CSV::Converters[:downcase] = -> (s) { s.downcase rescue s }

    CSV_PARAMS = {
      headers: true,
      header_converters: :symbol,
      converters: [:all, :downcase, :blank_to_nil],
    }

    MAPPINGS = {
      genus: :name,
      weight: :weight_in_lbs,
      carnivore: :diet,
    }

    def self.csv_to_dinos(files)
      files.map do |file|
        csv = CSV.read("#{file}", CSV_PARAMS)
        normalize(csv.map(&:to_hash))
      end.flatten
    end

    def self.normalize(dinos)
      dinos.each do |d|
        d.keys.each { |k| d[MAPPINGS[k]] = d.delete(k) if MAPPINGS[k] }
        d[:continent] = "africa" unless d.key?(:continent)
        d[:diet] = "carnivore" if d[:diet] == "yes"
        d[:diet] = "herbivore" if d[:diet] == "no"
      end
    end
  end
end
