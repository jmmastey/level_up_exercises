class Dinoparser

    require "CSV"

    def initialize(filename = nil)
        parse_file(filename)
    end


    def parse_file(filename) 
        @dinos = CSV.read(filename, { headers: true })
    end
 

    def find_by_category(rowname = nil, criteria = nil)
        #criteria.each do | data |
            @dinos.select do | row |
                if row[rowname] == data
                    puts row
                end

            end


                
            end
    end

    private

    def print_valid_data()
        @dinos.headers.each do | header |
            puts header.to_s
    end

    

end

d1 = Dinoparser.new("dinodex.csv")
#d1.find_by_category("WALKING",["Biped"])
d1.find_by_category("DIET",["Insectivore"])

d2 = Dinoparser.new("african_dinosaur_export.csv")
d2.find_by_category("Walking",["Biped"])
