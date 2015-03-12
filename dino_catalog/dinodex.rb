require 'csv'

class Dinosaur
  attr_reader :name
  attr_reader :period
  attr_reader :continent
  attr_reader :diet
  attr_reader :weight
  attr_reader :walk
  attr_reader :descrp

  def initialize(name, period, continent, diet, weight, walk, descrp)
    @name = name
    @period = period
    @continent = continent
    @diet = diet
    @weight = weight
    @walk = walk
    @descrp = descrp
  end

  def display
    if !@name.nil?
      puts "NAME: #{@name}\n"
    end    
    if !@period.nil?
      puts "PERIOD: #{@period}\n"
    end
    if !@continent.nil?
      puts "CONTINENT: #{@continent}\n"
    end
    if !@diet.nil?
      puts "DIET: #{@diet}\n"
    end
    if !@weight.nil?
      puts "WEIGHT: #{@weight} lbs\n"
    end
    if !@walk.nil?
      puts "WALK: #{@walk}\n"
    end
    if !@descrp.nil?
      puts "DESCRIPTION: #{@descrp}\n"
    end
  end
end


class DinosaurCollection
  attr_accessor :dinosaurs
  def initialize 
    @dinosaurs = {}

    dino = CSV.new(File.read("dinodex.csv"), headers: true, :header_converters => :symbol, :converters => :all)
    dino_hash = dino.to_a.map {|row| row.to_hash}
    dino_hash.each do |dino|
      @dinosaurs[dino[:name]] = Dinosaur.new(dino[:name], dino[:period], 
                                dino[:continent], dino[:diet], 
                                dino[:weight_in_lbs], dino[:walking], dino[:description])
    end
    
    african_dino = CSV.new(File.read("african_dinosaur_export.csv"), headers: true, :header_converters => :symbol, :converters => :all)
    african_dino_hash = african_dino.to_a.map {|row| row.to_hash}

    african_dino_hash.each do |h|
      h[:continent] = nil
      h[:description] = nil
    end
    
    african_dino_hash.each do |dino|
      if dino[:carnivore] == "Yes"
        dino[:carnivore] = "Carnivore"
      else
        dino[:carnivore] = nil  
      end
        @dinosaurs[dino[:genus]] = Dinosaur.new(dino[:genus], dino[:period], 
                                  dino[:continent], dino[:carnivore], 
                                  dino[:weight], dino[:walking],dino[:description])
    end
  end
end

class Finder
  def initialize
    @dinoCol = DinosaurCollection.new
    search
  end

  def getBipeds
    @dinoCol.dinosaurs = @dinoCol.dinosaurs.select { |k, v| v.walk == "Biped" }
  end

  def getCarnivores
    @dinoCol.dinosaurs = @dinoCol.dinosaurs.select { |k, v| v.diet == "Carnivore" }
  end

  def getSpecificDinosaur(param)
    @dinoCol.dinosaurs = @dinoCol.dinosaurs.select { |k, v| k == param }
    if @dinoCol.dinosaurs.empty?
      puts "No records found matching your criteria for #{param}"
    end 
  end
 
  def getBigDinosaurs(param)
    @dinoCol.dinosaurs = @dinoCol.dinosaurs.select { |k, v| v.weight.to_i > param.to_i * 2000 }
    if @dinoCol.dinosaurs.empty?
      puts "No records found matching your criteria for #{param}"
    end
  end

  def getSmallDinosaurs(param)
    @dinoCol.dinosaurs = @dinoCol.dinosaurs.select { |k, v| v.weight.to_i <= param.to_i * 2000 }
    if @dinoCol.dinosaurs.empty?
      puts "No records found matching your criteria for #{param}"
    end
  end
  
  def getPeriodSpecificDinosaurs(param)
    @dinoCol.dinosaurs = @dinoCol.dinosaurs.select { |k, v| v.period =~ /#{param}/ }
    if @dinoCol.dinosaurs.empty?
      puts "No records found matching your criteria for #{param}"
    end
  end
  
  def getDinosaurCollection
  end
  
  def displayUsage
    puts "Usage:\nruby dinodex.rb <search_options>\n-b\t\t\t\treturn all biped dinosaurs\n-c\t\t\t\treturn all carnivore dinosaurs"
    puts "-a\t\t\t\treturn dinosaur collection\n-n  <NAME>\t\t\treturn facts for this dinosaur\n"
    puts "-wg <WEIGHT IN TONS>\t\treturn dinosaurs weighing more than <WEIGHT IN TONS>\n-wl <WEIGHT IN TONS>\t\treturn dinosaurs weighing less or equal to <WEIGHT IN TONS                >\n-p  <PERIOD>\t\t\treturn dinosaurs in this <PERIOD>"
    puts "You can also combine the criteria\nExample 1: ruby dinodex.rb -bcp Late\twill return all biped dinosaurs that are carnivores in 'Late' period."
    puts "Example 2: ruby dinodex.rb -bwg 2\twill return all biped dinosaurs who weigh more than 2 tons."

  end
 
  def displayDinosaurData
    @dinoCol.dinosaurs.each do |k, v|
      v.display
      puts "\n"
    end
  end  
  
  def search
    option = ARGV[0]
    param = ARGV[1]
    
    if !option.nil?    
      getBipeds if option =~ /b/
      getCarnivores if option =~ /c/
      getSpecificDinosaur(param) if option =~ /n/
      getBigDinosaurs(param) if option =~ /wg/
      getSmallDinosaurs(param) if option =~ /wl/
      getPeriodSpecificDinosaurs(param) if option =~ /p/
      getDinosaurCollection if option =~ /a/
      puts "\n"
      displayDinosaurData
    else
      displayUsage
    end   
   end
end
obj = Finder.new
