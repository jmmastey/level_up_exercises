require 'json'
require './dinodexdata'

class DinoDex
  def initialize
    @dinodexdata ||= DinoDexData.new
  end

  def search(search_filters, format = '')
    results = []
    search_filters.each do |key, value|
      results << generate_results(key, value)
    end
    results = parse_results(results)
    return results.to_json if format == 'json'
    results
  end

  private

  # Analyze key/value and generate results properly

  def generate_results(key, value)
    if value.is_a?(Enumerable)
      get_results(key, value)
    elsif key == 'min_weight'
      get_results_from_min_weight(value)
    else
      get_results_from_string(key, value)
    end
  end

  def get_results(key, values = [])
    values = values.map(&:downcase)
    @dinodexdata.data.select do |dino|
      dino[key] && values.include?(dino[key].downcase)
    end
  end

  def get_results_from_min_weight(min_weight)
    @dinodexdata.data.select do |dino|
      dino['weight_in_lbs'] && dino['weight_in_lbs'].to_i >= min_weight
    end
  end

  def get_results_from_string(key, value)
    @dinodexdata.data.select do |dino|
      dino[key] && dino[key].downcase.include?(value.downcase)
    end
  end

  # Look for dinos that exist across all results

  def parse_results(results)
    return nil if results.length < 1
    common_results = results.first
    (1..(results.length - 1)).each do |i|
      common_results &= results[i]
    end
    common_results
  end
end
