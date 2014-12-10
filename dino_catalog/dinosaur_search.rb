
class DinosaurSearch
  attr_accessor :result_dinosaurs

  def initialize(search_pool)
    @result_dinosaurs = search_pool
  end

  def filter(options)
    case options["compare"]
      when "equal"
        filter_equal_characteristics(options)
      when "greater", "lesser"
        filter_unequal_characteristics(options, options["compare"])
      else
        @result_dinosaurs
    end
    self
  end

  def filter_unequal_characteristics(options, comparer)
    @result_dinosaurs.reject! { |dinosaur| dinosaur[options.first.first].nil? }
    if comparer == "greater"
      @result_dinosaurs.reject! do |dinosaur|
        dinosaur[options.first.first].to_i <= options.first.last
      end
    else
      @result_dinosaurs.reject! do |dinosaur|
        dinosaur[options.first.first].to_i >= options.first.last
      end
    end
  end

  def filter_equal_characteristics(options)
    @result_dinosaurs.select! do |dinosaur|
      present?(options.first.last, dinosaur[(options.first.first)])
    end
  end

  def present?(value, comparer)
    return value.include?(comparer.chomp) if value.is_a?(Enumerable)
    value.to_s.chomp == comparer.to_s.chomp
  end
end
