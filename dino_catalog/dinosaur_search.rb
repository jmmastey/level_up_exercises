
class DinosaurSearch
  attr_accessor :result_dinosaurs

  def initialize(search_pool)
    @result_dinosaurs = search_pool
  end

  def names
    @result_dinosaurs.map { |dinosaur| dinosaur["NAME"] }
  end

  def filter(options)
    case options["compare"]
      when "greater"
        filter_greater_characters(options)
      when "lesser"
        filter_lesser_characters(options)
      when "equal"
        filter_characters(options)
    end

    self
  end

  def value_present_in_options?(options, key)
    options.key?(key) && options[key]
  end

  def filter_greater_characters(options)
    @result_dinosaurs.each_with_index do |dinosaur, index|
      dinosaur.each do |key, value|
        next unless value_present_in_options?(options, key)
        index = reset_resultant(index) if options[key] <= value.to_i
      end
    end
  end

  def filter_lesser_characters(options)
    @result_dinosaurs.each_with_index do |dinosaur, index|
      dinosaur.each do |key, value|
        next unless value_present_in_options?(options, key)
        index = reset_resultant(index) if options[key] >= value.to_i
      end
    end
  end

  def filter_characters(options)
    @result_dinosaurs.each_with_index do |dinosaur, index|
      dinosaur.each do |key, value|
        next unless value_present_in_options?(options, key)
        if options[key].is_a?(Array)
          unless options[key].include?(value.downcase)
            index = reset_resultant(index)
          end
        end
        index = reset_resultant(index) if options[key] != value.downcase
      end
    end
  end

  def reset_resultant(index)
    @result_dinosaurs.delete_at index
    index -= 1
    index
  end

  def get_description(name)
    @result_dinosaurs.each do |dinosaur|
      next unless dinosaur["NAME"].downcase == name.downcase
      dinosaur.each do |key, value|
        puts key + " => " + value unless value.nil?
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
