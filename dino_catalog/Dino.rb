require 'csv'

$Dinodex = Hash.new

class Dinosaur
    def initialize(dino)
        @name = dino['Genus']
        @period = dino['Period']
        @carnivore = dino['Carnivore']
        @weight = dino['Weight']
        @walking = dino['Walikng']
    end
    
attr_accessor :@name, @period, @carnivore, @weight, @walking

protected :attr_accessor
end

class Dinodex < Dinosaur
    def initialize(dino)
        @name = dino['NAME']
        @period = dino['PERIOD']
        @weight = dino['WEIGHT_IN_LBS']
        @walking = dino['WALKING']
        @description = dino['DESCRIPTION']
        @diet = dino['DIET']
        @carnivore = is_carnivore?(dino)
    end

    def is_carnivore?(dino)
        if dino[DIET] != 'Herbivore'
            "Yes"
        else
            "No"
        end
    end
end

CSV.foreach('african_dinosaur_export.csv', converters: :numeric, headers:true) do |row|
    Dinodex[row['Genus']] = Dinosaur.new(row)
end

CSV.foreach('dinodex.csv', converters: :numeric, headers:true) do |row|
    Dinodex[row['Genus']] = Dinosaur.new(row)
end
