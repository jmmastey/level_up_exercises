require './dinodexdata'

class DinoDex
  def initialize
    @dinodexcsv ||= DinoDexData.new
  end

  # Analyze key/value and generate results properly

  def generate_results(key, value)
    if value.class == Array
      results_from_array(key, value)
    elsif key == 'min_weight'
      results_from_min_weight(value)
    else
      results_from_string(key, value)
    end
  end

  def results_from_array(key, array_of_values)
    array_of_values_dl = array_of_values.map(&:downcase)
    @dinodexcsv.data.select do |dino|
      dino[key] && array_of_values_dl.include?(dino[key].downcase)
    end
  end

  def results_from_min_weight(min_weight)
    @dinodexcsv.data.select do |dino|
      dino['weight_in_lbs'] && dino['weight_in_lbs'].to_i >= min_weight
    end
  end

  def results_from_string(key, value)
    @dinodexcsv.data.select do |dino|
      dino[key] && dino[key].downcase.include?(value.downcase)
    end
  end

  def search(search_filters)
    results = []
    search_filters.each do |key, value|
      results += generate_results(key, value)
    end
    results.uniq.to_json
  end
end
