require 'json'
require './dinodexdata'

class DinoDex
  def initialize
    @dino_database ||= DinoDexData.new
  end

  def search(search_filters, format = '')
    search_results = retrieve_matching_results(search_filters)
    return search_results.to_json if format == 'json'
    search_results
  end

  private

  def retrieve_matching_results(filters)
    merged_results = []
    filters.each do |key, value|
      filter_results = generate_results(key, value)
      merged_results = filter_results if merged_results.empty?
      merged_results &= filter_results
    end
    merged_results
  end

  def generate_results(key, value)
    if value.is_a?(Enumerable)
      retrieve_results(key, value)
    elsif key == 'min_weight'
      retrieve_results_from_min_weight(value)
    else
      retrieve_results_from_string(key, value)
    end
  end

  def retrieve_results(key, values = [])
    values = values.map(&:downcase)
    @dino_database.data.select do |dino|
      dino[key] && values.include?(dino[key].downcase)
    end
  end

  def retrieve_results_from_min_weight(min_weight)
    @dino_database.data.select do |dino|
      dino['weight_in_lbs'] && dino['weight_in_lbs'].to_i >= min_weight
    end
  end

  def retrieve_results_from_string(key, value)
    @dino_database.data.select do |dino|
      dino[key] && dino[key].downcase.include?(value.downcase)
    end
  end
end
