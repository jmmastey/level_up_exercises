require 'csv'
require 'json'

class Dinosaur
  attr_accessor :result_dinosaurs
  def initialize
    @dinosaurs = []
    @result_dinosaurs = []
    CSV.foreach('dinodex.csv', :headers=>true) do |row|
      @dinosaurs << row.to_hash
    end
  end

  def filter_result(options)
    @result_dinosaurs.each do |dino|

    end
  end

  def get_name()
    dinosaur_names = []
    @result_dinosaurs.each do |dinosaur|
      dinosaur_names << dinosaur["NAME"]
    end
    dinosaur_names
  end

  def search_dinosaur(options)
    @dinosaurs = @result_dinosaurs unless @result_dinosaurs.empty?
    @result_dinosaurs = []
    options.each do |key, val|
      next if key == "compare"
      @dinosaurs.each do |dinosaur|
        if dinosaur["PERIOD"].split(' ').length == 2
          dinosaur["PERIOD"] = dinosaur["PERIOD"].split(' ')[1]
        end
        if options["compare"] == "greater"
          if dinosaur[key].to_i > val.to_i
            @result_dinosaurs << dinosaur unless @result_dinosaurs.include?dinosaur['NAME']
          end
        elsif options["compare"] == "lesser"
          if dinosaur[key].to_i < val.to_i
            @result_dinosaurs << dinosaur unless @result_dinosaurs.include?dinosaur['NAME']
          end
        else
          if val.kind_of?(Array)
            if val.include? dinosaur[key].downcase
              @result_dinosaurs << dinosaur unless @result_dinosaurs.include?dinosaur['NAME']
            end
          elsif dinosaur[key].downcase == val
            @result_dinosaurs << dinosaur unless @result_dinosaurs.include?dinosaur['NAME']
          end
        end
      end
    end
    self
  end

  def get_description(name)
    @dinosaurs.each do |dinosaur|
      if dinosaur["NAME"].downcase == name.downcase
        dinosaur.each do |key, value|
          puts key+" => "+value unless value == nil
        end
      end
    end
  end

  def as_json
    hash_json ||= {}
    i = 0
    @dinosaurs.each do |dinosaur|
      dinosaur.each do |key, value|
        hash_json[i] ||= {}
        hash_json[i][key] = value
      end
      i += 1
    end
    hash_json.to_json
   #@dinosaur.as_json
  end
end

options = Hash.new
options1 = Hash.new
options2 = Hash.new
options4 = Hash.new
options['WALKING'] = "biped"
options['compare'] = "equal"
dinosaur = Dinosaur.new

dinosaur1 = Dinosaur.new
#puts "----"
#dinosaur.get_description("Albertonykus")
#puts "----"
#result = dinosaur.search_dinosaur(options)

#p result.result_dinosaurs

options1['DIET'] = ['carnivore', 'insectivore']
options1['compare'] = "equal"
result = dinosaur.search_dinosaur(options1)
p result.get_name.inspect

options2['WEIGHT_IN_LBS'] = 2000
options2['compare'] = "greater"
result = dinosaur.search_dinosaur(options2).search_dinosaur(options1)
p result.get_name.inspect

result = dinosaur1.search_dinosaur(options2)
p result.get_name.inspect
#options4['PERIOD'] = "permian"
#options4['compare']= "equal"

#result = dinosaur.search_dinosaur(options4)
#p result.result_dinosaurs.inspect
#p dinosaur.as_json
