class Dinoparser

    require "CSV"

    attr_reader :dinos, :allDinosaurs
   
    def initialize(filename = nil)
        @allDinosaurs = Array.new
        parse_file(filename)
    end


    def parse_file(filename) 
        @dinos = CSV.open(filename, { headers: true, header_converters: :symbol })
        @dinos = @dinos.to_a.map {| row | row.to_hash }
        @dinos.each {| row | add_dinosaurs_to_collection(row) }

    end
 

    def find_dinosaurs(criteria)

        if (criteria.length == 0)
            print_valid_dinosaurs()
        else

        end

    end

    def add_dinosaurs_to_collection(new_dino)
        dino = Dinosaur.new(new_dino)
        @allDinosaurs.push(dino)
    end

    def print_valid_dinosaurs()
        @allDinosaurs.each do | dino |
            puts dino.to_s
        end
    end

end


class Dinosaur

    attr_accessor :name, :period, :continent, :diet, :weight, :walking, :description
    attr_reader :csvrow

    def initialize(row)
        @name = row[:name]
        @period = row[:period]
        @continent = row[:continent]
        @diet = row[:diet]
        @weight = row[:weight]
        @walking = row[:walking]
        @description = row[:description]
        @csvrow = row
    end

    def matches_any? criteria
       puts row[criteria.name] 

    end

    def to_s
        puts "Dinosaur Info \n
            Name: #{@name} Period: #{@period} Continent: #{@continent} Diet: #{@diet} \n
            Weight: #{@weight} Walking: #{@walking} Description: #{@description}"
    end

end




d1 = Dinoparser.new("dinodex.csv")
#d1.find_dinosaurs({"WALKING" => "Biped", "DIET" => "Carnivore", "WEIGHT" => 7000})
d1.find_dinosaurs({})
