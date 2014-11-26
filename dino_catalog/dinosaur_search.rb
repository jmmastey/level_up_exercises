
class DinosaurSearch
  attr_accessor :result_dinosaurs

  def initialize(search_pool)
    @result_dinosaurs = search_pool
  end

  def names
    @result_dinosaurs.map { |dinosaur| dinosaur["NAME"] }
  end

  def filter(options)
    if options["compare"] == "equal"
      filter_equal_characteristics(options)
    else
      filter_unequal_characteristics(options)
    end
    # case options["compare"]
    #   when "greater"
    #     filter_greater_characteristics(options)
    #   when "lesser"
    #     filter_lesser_characteristics(options)
    #   when "equal"
    #     filter_equal_characteristics(options)
    # end
    self
  end

  def value_present_in_options?(options, key)
    options.key?(key) && options[key]
  end

  def filter_unequal_characteristics(options)
    @result_dinosaurs.each_with_index do |dinosaur, index|
      dinosaur.each do |key, value|
        next unless value_present_in_options?(options, key)
        reject_resultant_array(options, index, value)
      end
    end
  end

  def reject_resultant_array(options, index, value)
    if options["compare"] == "greater"
      delete_resultant(index) if (options.first.last > value.to_i) || value.nil?
    else
      delete_resultant(index) if (options.first.last < value.to_i) || value.nil?
    end
  end

  def filter_equal_characteristics(options)
    @result_dinosaurs.each_with_index do |dinosaur, index|
      dinosaur.each do |key, value|
        next unless value_present_in_options?(options, key)
        delete_resultant(index) if present?(options, key, value)
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

  def delete_resultant(index)
    @result_dinosaurs.delete_at index
    index -= 1
    index
  end

  def description(name)
    @result_dinosaurs.select { |dinosaur|  dinosaur["NAME"] == name }
  end

  def to_json
    dinosaur = {}
    @result_dinosaurs.each_with_index do |dino, index|
      dinosaur[index] = dino.to_json
    end
    dinosaur.to_json
  end
end
