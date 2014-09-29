require_relative '../lib/loader.rb'
require 'abanalyzer'

class DataCalculator

  def initialize(data_hash)    	
    @data_hash = data_hash
  end

  def count(cohort)
    result = 0 
    @data_hash.each do |x|
      result += 1 if x["cohort"] == cohort
    end
    result
  end

  def conversion_rate(cohort)
    number_of_coversions = 0	
    @data_hash.each do |x|
      if x["result"] == 1 && x["cohort"] == cohort
        number_of_coversions += 1
      end
    end
    number_of_conversions/count(cohort).to_f
  end     

  def bounce_rate(cohort)
    return 1 - conversion_rate(cohort)
  end

  def standard_error(cohort)
    p = conversion_rate(cohort)
    n = count(cohort)
    Math.sqrt(p * (1-p)/n)
  end

  def confidence_interval(cohort)
    ABAnalyzer.confidence_interval(success,totaltrial,standard_error)
  end
end

data = Loader.new("lib/source_data.json").parse_json
# calculator = DataCalculator.new(data)
# puts calculator.count("A")

#fossils
# side effects of commands (verbs)
# test results of queries (nouns)
# happy and sad
# value = {}
# values[cohort] = { :result => ?, :result => ?}
# values[cohort] = { :result => ?, :result => ?}
