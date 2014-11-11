require 'csv'
require 'json'

class DinosaurParser

  def parse
    @result_dinosaurs = []
    CSV.foreach('dinodex.csv', :headers => true) do |row|
      @result_dinosaurs << row.to_hash
    end

    CSV.foreach('african_dinosaur_export.csv', :headers => true) do |row|
      dinosaur = {}
      dinosaur["NAME"]          = row["Genus"]
      dinosaur["PERIOD"]        = row["Period"]
      dinosaur["CONTINENT"]     = "Africa"
      dinosaur["DIET"]          = row["Carnivore"] == "Yes" ? "Carnivore" : "Vegan"
      dinosaur["WEIGHT_IN_LBS"] = row["Weight"]
      dinosaur["WALKING"]       = row["Walking"]
      dinosaur["DESCRIPTION"]   = ""
      @result_dinosaurs << dinosaur
    end
    @result_dinosaurs
  end

end

class DinosaurSearch
  attr_accessor :result_dinosaurs

  def initialize(search_pool)
    @result_dinosaurs = search_pool
  end

  def get_name
    dinosaur_names = []
    @result_dinosaurs.each{ |dinosaur| dinosaur_names << dinosaur["NAME"] }
    dinosaur_names
  end

  def smart_search_dinosaur(options)
    case options["compare"]
    when "greater"
      idx = -1
      search_dinosaur(options, "greater")
    when "lesser"
      search_dinosaur(options, "lesser")
    when "equal"
      search_dinosaur(options, "equal")
    end

    self
  end

  def search_dinosaur(options, symbol)
    idx = -1
    resultant = []
    @result_dinosaurs.each do |dinosaur|
      idx += 1

      dinosaur.each do |key, value|
        if options.has_key?(key) && options[key]
          if symbol == "greater" && options[key] <= value.to_i
            idx = reset_resultant(idx)
          elsif symbol == "lesser" && options[key] >= value.to_i
            idx = reset_resultant(idx)
          elsif symbol == "equal"
            if options[key].is_a?(Array)
              if !(options[key].include?(dinosaur[key].downcase))
                idx = reset_resultant(idx)
              end
            elsif options[key] != dinosaur[key].downcase
              idx = reset_resultant(idx)
            end
          end
        end
      end
    end
    self
  end

  def reset_resultant(idx)
    @result_dinosaurs.delete_at idx
    idx -= 1
    idx
  end
  def get_description(name)
    @result_dinosaurs.each do |dinosaur|
      if dinosaur["NAME"].downcase == name.downcase
        dinosaur.each do |key, value|
          puts key + " => " + value unless value == nil
        end
      end
    end
  end

  def prepare_hash(dinosaur)
    dino_hash = {}
    dinosaur.each do |key, value|
      dino_hash[key] = value
    end
    dino_hash
  end

  def to_json
    hash_json ||= {}
    i = 0
    @result_dinosaurs.each do |dinosaur|
      hash_json[i] = prepare_hash(dinosaur)
      i += 1
    end
    hash_json.to_json
  end
end

 options = Hash.new
 options2 = Hash.new

 options['WEIGHT_IN_LBS'] = 2000
 options['compare'] = "greater"

 parser = DinosaurParser.new
 resultant_dinosaurs = parser.parse
 dinosaur = DinosaurSearch.new(resultant_dinosaurs)

 result = dinosaur.smart_search_dinosaur(options)
 #p result.get_name.inspect

 dinosaur1 = DinosaurSearch.new(resultant_dinosaurs)



options2['DIET'] = ['carnivore', 'insectivore']
options2['compare'] = "equal"

result1 = dinosaur1.smart_search_dinosaur(options2)
p result1.get_name.inspect
p result1.to_json



