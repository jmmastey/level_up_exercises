
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
        reset_resultant(index) if (options[key] > value.to_i) || (value.nil?)
      end
    end
  end

  def filter_lesser_characters(options)
    @result_dinosaurs.each_with_index do |dinosaur, index|
      dinosaur.each do |key, value|
        next unless value_present_in_options?(options, key)
        reset_resultant(index) if (options[key] < value.to_i) || (value.nil?)
      end
    end
  end

  def filter_characters(options)
    @result_dinosaurs.each_with_index do |dinosaur, index|
      dinosaur.each do |key, value|
        next unless value_present_in_options?(options, key)
        index = reset_resultant(index) if present?(options, key, value)
      end
    end
  end

  def present?(options, key, value)
    if options[key].is_a?(Array)
      return true unless options[key].include?(value)
    elsif options[key] != value
      return true
    else
      return false
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
    @result_dinosaurs.map { |dino| prepare_hash(dino) }.to_json
  end
end
