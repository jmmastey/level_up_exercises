require 'json'
require 'abanalyzer'

class Optimizer
  attr_accessor :data
  def initialize(initial_data)
    @data = DataLoader.load_data initial_data
  end

  def simple_counts
    result = {}
    [:A, :B].each do |cohort|
      result[cohort] = { :sample_size => @data[cohort].values.inject(:+),
                        :conversions => @data[cohort][:successes] }
    end
    result
  end

  def conversion_rates
    counts = simple_counts
    result = {}
    [:A, :B].each do |cohort|
      result[cohort] = ABAnalyzer.confidence_interval(
        counts[cohort][:conversions], counts[cohort][:sample_size], 0.95)
    end
    result
  end

  def result_confidence
    tester = ABAnalyzer::ABTest.new @data
    tester.chisquare_p
  end
end

class DataLoader
  def self.load_data(filename_or_array)
    return parse filename_or_array if filename_or_array.class == Array
    self.parse(
      self.load_json(filename_or_array)
    )
  end

  def self.load_json(json_data_filename)
    f = File.open(json_data_filename, "r")
    data = f.read
    f.close
    JSON.parse(data)
  end

  def self.parse(data)
    result = Hash.new { |hash, key| hash[key] = { :successes => 0, :failures => 0 } }
    data.each do |entry|
      result_key = self.key_or_sym(entry, "result") == 1 ? :successes : :failures
      result[self.key_or_sym(entry, "cohort").to_sym][result_key] += 1
    end
    result
  end

  def self.key_or_sym(hash, value)
    hash[value.to_sym] || hash[value.to_s]
  end
end

optimizer = Optimizer.new "data_export_2014_06_20_15_59_02.json"
puts optimizer.result_confidence
