require 'pry'
class DinoParser
  @@fields =  
    [:food, :name, :period, :weight,
     :walking, :continent, :description]

  def initialize(file_name)
    @csv_data = CSV.read(file_name)
    @data_fields = @csv_data.delete_at(0).map(&:downcase).map(&:to_sym)
    map_fields
    map_indices
    @carnivores = []
    @food_index = @map_indices[@fields_mapping[:food].to_sym]
    @@fields.each do |field|
      self.class.send(:define_method,"#{field}_index") do 
        @map_indices[@fields_mapping[field.to_sym].to_sym]
      end
    end
  end

  def map_fields()
    @fields_mapping = {}
    @@fields.each do |field|
      @possible_fields = DinoParser.send("#{field}_fields")
      @fields_mapping[field.to_sym] = (@data_fields & @possible_fields)[0] || 
      "".to_sym
    end
  end

  def map_indices
    @map_indices = {}
    @data_fields.each_with_index do |data_field, i|
      @map_indices[data_field.to_sym] = i
    end 
  end

  def find_bipeds
    bipeds = []
    @csv_data.each do |line|
      if(line[walking_index].downcase == 'biped')
        bipeds << line[name_index]
      end
    end
    print_dinosaurs("Biped Dinosaurs", bipeds)
  end

  def dino_classified_by_periods
    dinos_in_periods = {}
    @csv_data.each  do |line|
      key = line[period_index]
      key = 'Cretaceous' if(line[period_index].match(/Cretaceous/))
   
      if(dinos_in_periods[key]).nil?
        dinos_in_periods[key] = [line[name_index]]
      else
        dinos_in_periods[key] << line[name_index]
      end
    end   
    print_dinosaurs("Dinos in different periods", dinos_in_periods)
  end

  def find_carnivores
    carnivores = []
  end

  def classify_by_weight
    dinos_by_weight = {:small => [], :big => []}
    @csv_data.each do |line|
      if(line[weight_index] && line[weight_index].to_i >= 2000)
        dinos_by_weight[:big] << line[name_index]
      elsif(line[weight_index] && line[weight_index].to_i < 2000)
        dinos_by_weight[:small] << line[name_index]
      else
        next    
      end
    end
    print_dinosaurs("Dinos by weight", dinos_by_weight)
  end

  def self.food_fields
    [:diet, :carnivore]
  end

  def self.name_fields
    [:genus, :name]
  end

  def self.period_fields 
    [:period]
  end

  def self.weight_fields
    [:weight, :weight_in_lbs]
  end

  def self.walking_fields
    [:walking]
  end

  def self.continent_fields
    [:continent]
  end
 
  def self.description_fields
    [:description]
  end

  def print_dinosaurs(message, data)
    puts ":#############{message.upcase}############"
    if(data.is_a?(Array))
      data.each do |element|
        puts element
      end
    elsif(data.is_a?(Hash))
      data.each do |k,v|
        puts "::#{k.to_s.upcase}::\n"
        v.each do |el|
          puts "#{el}\n"
        end
      end
    end 
  end
end
