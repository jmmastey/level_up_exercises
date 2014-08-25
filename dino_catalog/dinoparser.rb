class Dinoparser

    require "CSV"

    def initialize()
    end
    
    def parse_csv_file(filename)
    
        @dinos = CSV.open(filename, { headers: true, header_converters: :symbol })
        @dinos = @dinos.to_a.map {| row | row.to_hash }

    end

end

