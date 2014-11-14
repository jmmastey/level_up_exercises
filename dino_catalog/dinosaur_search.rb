
class DinosaurSearch
  attr_accessor :result_dinosaurs

  def initialize(search_pool)
    @result_dinosaurs = search_pool
  end

  def get_name
    dinosaur_names = []
    @result_dinosaurs.each { |dinosaur| dinosaur_names << dinosaur["NAME"] }
    dinosaur_names
  end

  def smart_search_dinosaur(options)
    case options["compare"]
      when "greater"
        search_dinosaur(options, "greater")
      when "lesser"
        search_dinosaur(options, "lesser")
      when "equal"
        search_dinosaur(options, "equal")
    end

    self
  end

  def search_dinosaur(options, symbol)
    index = -1
    @result_dinosaurs.each do |dinosaur|
      index += 1

      dinosaur.each do |key, value|
        if options.has_key?(key) && options[key]
          if symbol == "greater" && options[key] <= value.to_i
            index = reset_resultant(index)
          elsif symbol == "lesser" && options[key] >= value.to_i
            index = reset_resultant(index)
          elsif symbol == "equal"
            if options[key].is_a?(Array)
              unless options[key].include?(dinosaur[key].downcase)
                index = reset_resultant(index)
              end
            elsif options[key] != dinosaur[key].downcase
              index = reset_resultant(index)
            end
          end
        end
      end
    end
    self
  end

  def reset_resultant(index)
    @result_dinosaurs.delete_at index
    index -= 1
    index
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