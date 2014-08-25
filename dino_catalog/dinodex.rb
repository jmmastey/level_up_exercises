class Dinodex

    require "CSV"
    require_relative "Dinosaur"
    require_relative "Dinoparser"

    attr_reader :dinos, :all_dinosaurs
   
    def initialize(filename = nil)
        @all_dinosaurs = []
        parser = Dinoparser.new()
        @dinos = parser.parse_csv_file(filename)
        @dinos.each {| row | add_dinosaurs_to_collection(row) }

    end

    def find_dinosaurs(criteria)

        if (criteria.length == 0)
            print_valid_dinosaurs()
        else
            @all_dinosaurs.each do | dino |
                puts dino.to_s if dino.matches_any?(criteria)
            end

        end

    end

    private

    def add_dinosaurs_to_collection(new_dino)
        dino = Dinosaur.new(new_dino)
        @all_dinosaurs.push(dino)
    end

    def print_valid_dinosaurs()
        @all_dinosaurs.each do | dino |
            puts dino.to_s
        end
    end

end



d1 = Dinodex.new("dinodex.csv")
#d1.find_dinosaurs({"WALKING" => "Biped", "DIET" => "Carnivore", "WEIGHT" => 7000})
d1.find_dinosaurs({diet: "Insectivore", walking: "Wee"})
