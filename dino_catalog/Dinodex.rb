require 'csv'
require 'json'
require_relative 'Dino_Methods'

$Dinodex = Hash.new

class Dinosaur

 attr_reader :name, :period, :diet, :weight, :movement, :continent, :description
  def extract_period(period)
    period.each do |row, column|
      if /(.+)\s(.+)/.match(period)
        @period << [Regexp.last_match(1), Regexp.last_match(2)]
      else
        @period << ["",period]
      end
    end
  end
    
  def get_period period
    period.each do |index|
      @output = @output + "" + index
    end
      @output
  end
    
  def to_json
    {'name' => @name,
     'period' => (get_period period).to_s,
     'diet' => @diet,
     'weight' => @weight,
     'movement' => @movement,
     'continent' => @continetn,
     'description' => @description}.to_json
  end

  def initialize(dino)
    @name = dino[0]
    extract_period(dino[1])
    @diet = dino[2]
    @weight = dino[3]
    @movement = dino[4]
    @continent = dino[5]
    @description = dino[6]
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
    @dino[1] = split_period dino['PERIOD']
    @dino[2] = is_carnivore?(dino['Carnivore'])
    @dino[3] = dino['Weight']
    @dino[4] = dino['Walking']
    @dino[5] = "Africa"
    @dino[6] = nil
    super(@dino)
  end
end

class Normal_Dinosaur < Dinosaur
     def split_period period
     unless /(.+)\sor\s(.+)/.match(period)
       @period << dino['PERIOD']
     else
       @period << Regexp.last_match(1)
       split_period Regexp.last_match(2)
     end
  initialize(dino)
    @dino=[]
      @dino[0] = dino['NAME']
      @dino[1] = split_period dino['PERIOD']
      @dino[2] = dino['DIET']
      @dino[3] = dino['WEIGHT_IN_LBS']
      @dino[4] = dino['WALKING']
      @dino[5] = dino['CONTINENT']
      @dino[6] = dino['DESCRIPTION']
      super(@dino)
  end
end        

#CSV.foreach('african_dinosaur_export.csv', converters: :numeric, headers:true) do |row|
 #    $Dinodex[row['Genus']] = African_Dinosaur.new(row)
#end

CSV.foreach('dinodex.csv', converters: :numeric, headers:true) do |row|
     $Dinodex[row['NAME']] = Normal_Dinosaur.new(row)
end 

def match_period(dino, period)
  dino.period.each do |index|
    if dino.period[index].include? period
      @flag = true
    end
  end
  @flag ||= false
end

def match_attribute(dino, attribute, key)
  attribute == dino.send(key.to_s)
end
  

def find(params)
  search_terms = eval(params.gsub(':','=>'))
  $Dinodex.each do|key, dinosaur|
    @flag = false
      search_terms.each do|search_key, search_value|
        if search_key == 'period'
          @flag = match_period(dinosaur, search_value)
        else
          @flag = match_attribute(dinosaur, search_value, search_key)
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

            
