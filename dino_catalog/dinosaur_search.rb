
class DinosaurSearch
  attr_accessor :result_dinosaurs

  def initialize(search_pool)
    @result_dinosaurs = search_pool
  end

  def filter(options)
    case options["compare"]
      when "equal"
        filter_equal_characteristics(options)
      when "greater"
        filter_unequal_characteristics(options, "greater")
      when "lesser"
        filter_unequal_characteristics(options, "lesser")
      else
        @result_dinosaurs
    end
    self
  end

  def filter_unequal_characteristics(options, comparer)
    if comparer == "greater"
      @result_dinosaurs.reject! do |dinosaur|
        (dinosaur[options.first.first].to_i <= options.first.last) ||
          dinosaur[options.first.first].nil?
      end
    else
      @result_dinosaurs.reject! do |dinosaur|
        (dinosaur[options.first.first].to_i >= options.first.last) ||
          dinosaur[options.first.first].nil?
      end
    end
  end

  def filter_equal_characteristics(options)
    @result_dinosaurs.select! do |dinosaur|
      present?(options.first.last, dinosaur[options.first.first])
    end
  end

  def present?(value, comparer)
    if value.is_a?(Array)
      value.include?(comparer)
    else
      value == comparer
    end
  end

  def delete_resultant(index)
    @result_dinosaurs.delete_at index
  end
end
