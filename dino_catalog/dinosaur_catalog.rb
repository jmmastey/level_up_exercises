require 'csv'
require 'json'

class DinosaurParserAndSearch
  attr_accessor :result_dinosaurs
  def initialize
    @result_dinosaurs = []
    CSV.foreach('dinodex.csv', :headers => true) do |row|
      @result_dinosaurs << row.to_hash
    end
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
            @result_dinosaurs.delete_at idx
            idx -= 1
          end
          if symbol == "lesser" && options[key] >= value.to_i
            @result_dinosaurs.delete_at idx
            idx -= 1
          end
          if symbol == "equal"
            if options[key].is_a?(Array) && !options[key].include?(dinosaur[key].downcase)
              @result_dinosaurs.delete_at idx
              idx -= 1
            elsif options[key] != dinosaur[key].downcase
              @result_dinosaurs.delete_at idx
              idx -= 1
            end
          end
        end
      end
    end
  end

  def get_description(name)
    @search_list_dinosaurs.each do |dinosaur|
      if dinosaur["NAME"].downcase == name.downcase
        dinosaur.each do |key, value|
          puts key + " => " + value unless value == nil
        end
      end
    end
  end

  def as_json
    hash_json ||= {}
    i = 0
    @search_list_dinosaurs.each do |dinosaur|
      dinosaur.each do |key, value|
        hash_json[i] ||= {}
        hash_json[i][key] = value
      end
      i += 1
    end
    hash_json.to_json
  end
end

options = Hash.new
options1 = Hash.new
options2 = Hash.new

 options['WEIGHT_IN_LBS'] = 2000
 options['compare'] = "greater"
 dinosaur = DinosaurParserAndSearch.new

 result = dinosaur.smart_search_dinosaur(options)
 p result.get_name.inspect

 dinosaur1 = DinosaurParserAndSearch.new


# result = dinosaur1.smart_search_dinosaur(options1)
# p result.get_name.inspect

options2['DIET'] = ['carnivore', 'insectivore']
options2['compare'] = "equal"
#p result.get_name.inspect

result1 = dinosaur1.smart_search_dinosaur(options2)
p result1.get_name.inspect
