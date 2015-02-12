require 'csv'
require 'json'
require_relative 'Dino_Methods'

$Dinodex = Hash.new

class Dinosaur

    attr_reader :name, :period, :period_prefix, :diet, :weight, :movement, :continent, :description
    def extract_period(period)
        if /(.+)\s(.+)/.match(period)
            @period_prefix = $1
            @period = $2
        else
            @period_prefix = nil
            @period = period
        end
    end
    
    def to_json
        {'name' => @name,
         'period_prefix' => @period_prefix,
         'period' => @period,
         'diet' => @diet,
         'weight' => @weight,
         'movement' => @movement,
         'continent' => @continetn,
         'description' => @description}.to_json
    end

    def initialize(dino)
        @name = dino[0]
        extract_period(dino[1])
        @diet = dino[3]
        @weight = dino[4]
        @movement = dino[5]
        @continent = dino[6]
        @description = dino[7]
    end 
end

class African_Dinosaur < Dinosaur
    
    def is_carnivore?(diet)
        if diet == 'Yes'
            "Carnivore"
        else
            "Herbivore"
        end
    end
    
    def initialize(dino)
        @dino=[]
        @dino[0] = dino['Genus']
        @dino[1] = dino['Period']
        @dino[2] = nil
        @dino[3] = is_carnivore?(dino['Carnivore'])
        @dino[4] = dino['Weight']
        @dino[5] = dino['Walking']
        @dino[6] = "Africa"
        @dino[7] = nil

        super(@dino)
    end
end

class Normal_Dinosaur < Dinosaur
    @@version = 0

    def initialize(dino)
        @dino=[]
        if !(/(.+)\sor\s(.+)/.match(dino['PERIOD']))
            @dino[0] = dino['NAME']
            @dino[1] = dino['PERIOD']
            @dino[2] = nil
            @dino[3] = dino['DIET']
            @dino[4] = dino['WEIGHT_IN_LBS']
            @dino[5] = dino['WALKING']
            @dino[6] = dino['CONTINENT']
            @dino[7] = dino['DESCRIPTION']
            super(@dino)
        else
            @@version = @@version + 1
            dino2 = dino
            dino2['PERIOD'] = $2
            $Dinodex[dino2['NAME']+"_v"+@@version.to_s] = Normal_Dinosaur.new(dino2)
            @dino[0] = dino['NAME']
            @dino[1] = $1
            @dino[2] = nil
            @dino[3] = dino['DIET']
            @dino[4] = dino['WEIGHT_IN_LBS']
            @dino[5] = dino['WALKING']
            @dino[6] = dino['CONTINENT']
            @dino[7] = dino['DESCRIPTION']
            super(@dino)
        end
    end
end        

CSV.foreach('african_dinosaur_export.csv', converters: :numeric, headers:true) do |row|
     $Dinodex[row['Genus']] = African_Dinosaur.new(row)
end

CSV.foreach('dinodex.csv', converters: :numeric, headers:true) do |row|
     $Dinodex[row['NAME']] = Normal_Dinosaur.new(row)
end 

include Dino_Methods

def find(params)
    @flag
    search_terms = eval(params.gsub(':','=>'))
    $Dinodex.each do|key, dinosaur|
        @flag = false
        search_terms.each do|search_key, search_value|
            if search_value == dinosaur.send(search_key.to_s)
                @flag = true
            else
                @flag = false
            end
        end
        print_dino($Dinodex.fetch(key)) if @flag == true
    end
end

if ARGV.length == 0
    menu($Dinodex)
else 
    find(ARGV[0])
end

            
